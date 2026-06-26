import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'providers/beneficio_notifier.dart';
import '../domain/beneficio_model.dart';
import '../../maps_and_lots/domain/lote_model.dart';
import '../../maps_and_lots/presentation/providers/panel_lotes_notifier.dart';

import 'package:agrogo/features/field_workers/presentation/providers/trabajadores_notifier.dart';
import 'package:agrogo/features/field_workers/presentation/providers/gestion_administrativa_orchestrator.dart';
import 'package:agrogo/features/field_workers/domain/trabajador_model.dart';
import 'package:agrogo/features/field_workers/data/registro_labor_isar_model.dart';
import 'package:agrogo/core/utils/formatters.dart';
import 'package:flutter/services.dart';

import '../../../core/errors/fallos.dart';
import '../../../core/shared/widgets/agro_card.dart';
import '../../../core/shared/widgets/agro_empty_state.dart';

class PantallaProcesoCafe extends ConsumerWidget {
  const PantallaProcesoCafe({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lotesBeneficio = ref.watch(beneficioNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      appBar: AppBar(
        title: const Text('Beneficio de Café', style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Resumen de Recolección Semanal
          _BannerRecoleccionSemanal(),

          Expanded(
            child: lotesBeneficio.when(
              data: (lotes) {
                if (lotes.isEmpty) {
                  return const AgroEmptyState(
                    mensaje: 'No hay lotes en proceso de beneficio',
                    icono: Icons.coffee_maker_rounded,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: lotes.length,
                  itemBuilder: (context, index) => _TarjetaLoteBeneficio(beneficio: lotes[index]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerRecoleccionSemanal extends ConsumerStatefulWidget {
  const _BannerRecoleccionSemanal();
  @override
  ConsumerState<_BannerRecoleccionSemanal> createState() => _BannerRecoleccionSemanalState();
}

class _BannerRecoleccionSemanalState extends ConsumerState<_BannerRecoleccionSemanal> {
  Lote? _loteSeleccionado;
  Lote? _beneficiaderoSeleccionado;

  @override
  Widget build(BuildContext context) {
    final lotesAsync = ref.watch(panelLotesNotifierProvider);

    return FutureBuilder<double>(
      future: ref.read(beneficioNotifierProvider.notifier).calcularKilosCerezaPendientes(),
      builder: (context, snapshot) {
        final kilos = snapshot.data ?? 0;
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF4E342E), Color(0xFF3E2723)]),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20)],
          ),
          child: Column(
            children: [
              const Text('RECOLECCIÓN TOTAL SEMANA', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
              const SizedBox(height: 8),
              Text('${kilos.toStringAsFixed(1)} kg Cereza', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
              const SizedBox(height: 20),
              
              // Selectores de Lote e Infraestructura
              lotesAsync.maybeWhen(
                data: (lotes) {
                  final agricolas = lotes.where((l) => l.uso == TipoUsoLote.agricola).toList();
                  final beneficiaderos = lotes.where((l) => l.uso == TipoUsoLote.infraestructura && (l.subCategoria == 'Beneficiadero' || l.subCategoria == 'Tanque')).toList();
                  
                  // Autocompletado por defecto si solo hay uno
                  if (_beneficiaderoSeleccionado == null && beneficiaderos.length == 1) {
                    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _beneficiaderoSeleccionado = beneficiaderos.first));
                  }

                  if (agricolas.isEmpty && beneficiaderos.isEmpty) return const SizedBox.shrink();
                  
                  return Column(
                    children: [
                      if (agricolas.isNotEmpty) 
                        _buildDropdown<Lote>(
                          label: 'Lote de Origen',
                          value: _loteSeleccionado,
                          items: agricolas,
                          onChanged: (v) => setState(() => _loteSeleccionado = v),
                        ),
                      const SizedBox(height: 12),
                      if (beneficiaderos.isNotEmpty)
                        _buildDropdown<Lote>(
                          label: 'Beneficiadero / Tanque',
                          value: _beneficiaderoSeleccionado,
                          items: beneficiaderos,
                          onChanged: (v) => setState(() => _beneficiaderoSeleccionado = v),
                        ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
                orElse: () => const SizedBox.shrink(),
              ),

              ElevatedButton.icon(
                onPressed: kilos > 0 ? () => _iniciarProceso(context, ref, kilos, _loteSeleccionado?.id, _beneficiaderoSeleccionado?.id) : null,
                icon: const Icon(Icons.settings_input_component_rounded),
                label: const Text('INICIAR DESPULPADO'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF57C00),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => _mostrarFormRecoleccion(context, ref),
                icon: const Icon(Icons.add_task_rounded),
                label: const Text('REGISTRAR PESAJE (NUEVA RECOLECCIÓN)', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white24),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarFormRecoleccion(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => const _FormularioRecoleccionGlobal(),
    );
  }

  Widget _buildDropdown<T extends Lote>({required String label, T? value, required List<T> items, required ValueChanged<T?> onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButton<T>(
        value: value,
        hint: Text(label, style: const TextStyle(color: Colors.white60, fontSize: 13)),
        dropdownColor: const Color(0xFF3E2723),
        underline: const SizedBox(),
        isExpanded: true,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        items: items.map((l) => DropdownMenuItem(value: l, child: Text(l.nombre))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _iniciarProceso(BuildContext context, WidgetRef ref, double kilos, String? loteId, String? beneficiaderoId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Iniciar beneficio?'),
        content: Text('Se creará un nuevo lote con los ${kilos.toStringAsFixed(1)} kg recolectados.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          ElevatedButton(
            onPressed: () async {
              final res = await ref.read(beneficioNotifierProvider.notifier).iniciarNuevoBeneficio(kilos, loteId: loteId, beneficiaderoId: beneficiaderoId);
              if (context.mounted) {
                res.fold(
                  (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ ${f.mensaje}'), backgroundColor: Colors.red)),
                  (_) => Navigator.pop(context),
                );
              }
            },
            child: const Text('INICIAR'),
          ),
        ],
      ),
    );
  }
}

class _TarjetaLoteBeneficio extends ConsumerWidget {
  final BeneficioEntity beneficio;
  const _TarjetaLoteBeneficio({required this.beneficio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fecha = DateFormat('d MMM').format(beneficio.fechaInicio);
    
    return AgroCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(20),
            title: Text('Lote Café - $fecha', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${beneficio.kilosCereza} kg Cereza inicial', style: const TextStyle(fontWeight: FontWeight.bold)),
                if (beneficio.loteOrigenNombre != null || beneficio.beneficiaderoNombre != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_rounded, size: 12, color: Colors.teal),
                        Text(
                          ' ${beneficio.loteOrigenNombre ?? 'Sin lote'} • ${beneficio.beneficiaderoNombre ?? 'Sin planta'}', 
                          style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12)
                        ),
                      ],
                    ),
                  ),
                if (beneficio.secaderoNombre != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      children: [
                        const Icon(Icons.wb_sunny_rounded, size: 12, color: Colors.orange),
                        Text(' Secado en: ${beneficio.secaderoNombre}', style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 11)),
                      ],
                    ),
                  ),
              ],
            ),
            trailing: _buildBadgeEstado(beneficio.estado),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (beneficio.estado == EstadoBeneficio.molido || beneficio.estado == EstadoBeneficio.vendido) 
                      ? null 
                      : () => _avanzarLote(context, ref),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade50,
                      foregroundColor: Colors.teal.shade800,
                      elevation: 0,
                    ),
                    child: Text(_getTextoBoton(beneficio.estado)),
                  ),
                ),
                if (beneficio.estado != EstadoBeneficio.molido && beneficio.estado != EstadoBeneficio.vendido) ...[
                  const SizedBox(width: 12),
                  IconButton.filledTonal(
                    style: IconButton.styleFrom(backgroundColor: Colors.orange.shade100, foregroundColor: Colors.orange.shade900),
                    onPressed: () => _mostrarDialogoVenta(context, ref),
                    icon: const Icon(Icons.monetization_on_rounded),
                    tooltip: 'Vender ya',
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeEstado(EstadoBeneficio estado) {
    Color color;
    String texto;
    switch(estado) {
      case EstadoBeneficio.cereza: color = Colors.red; texto = 'CEREZA'; break;
      case EstadoBeneficio.lavado: color = Colors.blue; texto = 'LAVADO'; break;
      case EstadoBeneficio.secado: color = Colors.orange; texto = 'SECADO'; break;
      case EstadoBeneficio.listo: color = Colors.green; texto = 'PERGAMINO'; break;
      case EstadoBeneficio.tostado: color = Colors.brown; texto = 'TOSTADO'; break;
      case EstadoBeneficio.molido: color = Colors.blueGrey; texto = 'MOLIDO'; break;
      case EstadoBeneficio.vendido: color = Colors.purple; texto = 'VENDIDO'; break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(texto, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 10)),
    );
  }

  String _getTextoBoton(EstadoBeneficio estado) {
    switch(estado) {
      case EstadoBeneficio.cereza: return 'PASAR A LAVADO';
      case EstadoBeneficio.lavado: return 'PASAR A SECADO';
      case EstadoBeneficio.secado: return 'PESAR PERGAMINO SECO';
      case EstadoBeneficio.listo: return 'PASAR A TOSTADO';
      case EstadoBeneficio.tostado: return 'PASAR A MOLIENDA';
      case EstadoBeneficio.molido: return 'PROCESO FINALIZADO';
      case EstadoBeneficio.vendido: return 'VENDIDO';
    }
  }

  void _mostrarDialogoVenta(BuildContext context, WidgetRef ref) {
    final pesoCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Venta Directa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('¿Vendió este café mojado o en cereza? Ingrese el peso final de la venta.', style: TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 16),
            TextField(
              controller: pesoCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Kilos Vendidos', suffixText: 'kg', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
              child: const Row(
                children: [
                  Icon(Icons.local_shipping_rounded, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(child: Text('¿Necesita transporte para llevarlo? Use ServiCarga.', style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          ElevatedButton(
            onPressed: () async {
              final peso = double.tryParse(pesoCtrl.text);
              if (peso != null) {
                final res = await ref.read(beneficioNotifierProvider.notifier).venderLote(beneficio, peso);
                if (context.mounted) {
                  res.fold(
                    (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ ${f.mensaje}'), backgroundColor: Colors.red)),
                    (_) => Navigator.pop(context),
                  );
                }
              }
            }, 
            child: const Text('REGISTRAR VENTA')
          ),
        ],
      ),
    );
  }

  void _avanzarLote(BuildContext context, WidgetRef ref) {
    if (beneficio.estado == EstadoBeneficio.lavado) {
      // Pedir en qué secadero/marquesina se pondrá
      final lotes = ref.read(panelLotesNotifierProvider).valueOrNull ?? [];
      final secaderos = lotes.where((l) => l.uso == TipoUsoLote.infraestructura && (l.subCategoria == 'Secadero' || l.subCategoria == 'Marquesina')).toList();
      Lote? seleccionado = secaderos.length == 1 ? secaderos.first : null;

      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: const Text('Iniciar Secado'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Seleccione el área de secado donde ubicará este lote:', style: TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 16),
                DropdownButtonFormField<Lote>(
                  value: seleccionado,
                  items: secaderos.map((l) => DropdownMenuItem(value: l, child: Text(l.nombre))).toList(),
                  onChanged: (v) => setDialogState(() => seleccionado = v),
                  decoration: const InputDecoration(labelText: 'Secadero / Marquesina', border: OutlineInputBorder()),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
              ElevatedButton(
                onPressed: () async {
                  final res = await ref.read(beneficioNotifierProvider.notifier).avanzarEstado(beneficio, secaderoId: seleccionado?.id);
                  if (context.mounted) {
                    res.fold(
                      (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ ${f.mensaje}'), backgroundColor: Colors.red)),
                      (_) => Navigator.pop(context),
                    );
                  }
                }, 
                child: const Text('EMPEZAR SECADO')
              ),
            ],
          ),
        ),
      );
    } else if (beneficio.estado == EstadoBeneficio.secado) {
      // Pedir el peso final del pergamino
      final pesoCtrl = TextEditingController();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Peso Final de Pergamino'),
          content: TextField(
            controller: pesoCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Kilos Secos', suffixText: 'kg'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final peso = double.tryParse(pesoCtrl.text);
                if (peso != null) {
                  final res = await ref.read(beneficioNotifierProvider.notifier).avanzarEstado(beneficio, kilosFinales: peso);
                  if (context.mounted) {
                    res.fold(
                      (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ ${f.mensaje}'), backgroundColor: Colors.red)),
                      (_) => Navigator.pop(context),
                    );
                  }
                }
              }, 
              child: const Text('GUARDAR PERGAMINO')
            ),
          ],
        ),
      );
    } else if (beneficio.estado == EstadoBeneficio.listo || beneficio.estado == EstadoBeneficio.tostado) {
      // Pedir costo de transformación (tostado o molienda)
      final costoCtrl = TextEditingController();
      final titulo = beneficio.estado == EstadoBeneficio.listo ? 'Proceso de Tostado' : 'Proceso de Molienda';
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(titulo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ingrese el costo operativo del ${beneficio.estado == EstadoBeneficio.listo ? 'tostado' : 'molido'}.', style: const TextStyle(fontSize: 13, color: Colors.grey)),
              const SizedBox(height: 16),
              TextField(
                controller: costoCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Costo del Proceso', prefixText: r'$ ', suffixText: 'COP'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
            ElevatedButton(
              onPressed: () async {
                final costo = double.tryParse(costoCtrl.text) ?? 0.0;
                final res = await ref.read(beneficioNotifierProvider.notifier).avanzarEstado(beneficio, costoAdicional: costo);
                if (context.mounted) {
                  res.fold(
                    (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ ${f.mensaje}'), backgroundColor: Colors.red)),
                    (_) => Navigator.pop(context),
                  );
                }
              }, 
              child: const Text('CONFIRMAR Y AVANZAR')
            ),
          ],
        ),
      );
    } else {
      ref.read(beneficioNotifierProvider.notifier).avanzarEstado(beneficio);
    }
  }
}

class _FormularioRecoleccionGlobal extends ConsumerStatefulWidget {
  const _FormularioRecoleccionGlobal();
  @override
  ConsumerState<_FormularioRecoleccionGlobal> createState() => _FormularioRecoleccionGlobalState();
}

class _FormularioRecoleccionGlobalState extends ConsumerState<_FormularioRecoleccionGlobal> {
  final _kilosCtrl = TextEditingController();
  Lote? _loteSeleccionado;
  TrabajadorEntity? _trabajadorSeleccionado;
  bool _conComida = false;
  String _tipoPago = 'porKilo';
  double _pagoEstimado = 0;

  @override
  void initState() {
    super.initState();
    _kilosCtrl.addListener(_recalcularPago);
  }

  void _recalcularPago() {
    if (_trabajadorSeleccionado == null) return;
    setState(() {
      _pagoEstimado = RegistroLaborIsarModel.calcularPago(
        tipo: _tipoPago,
        kilos: double.tryParse(_kilosCtrl.text),
        tarifaBase: _trabajadorSeleccionado!.tarifaBase,
        conAlimentacion: _conComida,
      );
    });
  }

  @override
  void dispose() {
    _kilosCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lotesAsync = ref.watch(panelLotesNotifierProvider);
    final trabajadoresAsync = ref.watch(trabajadoresNotifierProvider);
    final padding = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Nueva Recolección', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
          const SizedBox(height: 24),
          
          // Selector de Trabajador
          trabajadoresAsync.maybeWhen(
            data: (list) {
              final recolectores = list.where((t) => t.tipoTrabajador == 'Recolector').toList();
              return DropdownButtonFormField<TrabajadorEntity>(
                value: _trabajadorSeleccionado,
                decoration: const InputDecoration(labelText: '¿Quién recolectó?', prefixIcon: Icon(Icons.person_search_rounded)),
                items: recolectores.map((t) => DropdownMenuItem(value: t, child: Text(t.nombreCompleto))).toList(),
                onChanged: (v) {
                  setState(() {
                    _trabajadorSeleccionado = v;
                    if (v != null) _tipoPago = 'porKilo'; // Reset a kilo para recolectores
                  });
                  _recalcularPago();
                },
              );
            },
            orElse: () => const Text('Cargando equipo...'),
          ),

          const SizedBox(height: 16),
          
          // Selector de Lote
          lotesAsync.maybeWhen(
            data: (lotes) {
              final agricolas = lotes.where((l) => l.uso == TipoUsoLote.agricola).toList();
              return DropdownButtonFormField<Lote>(
                value: _loteSeleccionado,
                decoration: const InputDecoration(labelText: 'Lote de origen', prefixIcon: Icon(Icons.landscape_rounded)),
                items: agricolas.map((l) => DropdownMenuItem(value: l, child: Text(l.nombre))).toList(),
                onChanged: (v) => setState(() => _loteSeleccionado = v),
              );
            },
            orElse: () => const Text('Cargando lotes...'),
          ),

          const SizedBox(height: 16),

          if (_trabajadorSeleccionado != null) ...[
            DropdownButtonFormField<String>(
              value: _tipoPago,
              decoration: const InputDecoration(labelText: 'Sistema de Pago', prefixIcon: Icon(Icons.payments_rounded)),
              items: const [
                DropdownMenuItem(value: 'porKilo', child: Text('Por Kilo')),
                DropdownMenuItem(value: 'porArroba', child: Text('Por Arroba (12.5 kg)')),
              ],
              onChanged: (v) {
                setState(() => _tipoPago = v!);
                _recalcularPago();
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _kilosCtrl, 
              keyboardType: TextInputType.number, 
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Cantidad recolectada', 
                prefixIcon: const Icon(Icons.scale_rounded),
                suffixText: _tipoPago == 'porKilo' ? 'Kilos' : 'Arrobas',
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(16)),
              child: SwitchListTile(
                title: const Text('¿Incluye Alimentación?', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Se descuenta \$15,000 del pago'),
                value: _conComida,
                activeColor: Colors.teal,
                onChanged: (v) {
                  setState(() => _conComida = v);
                  _recalcularPago();
                },
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF00695C).withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF00695C).withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  const Text('PAGO NETO ESTIMADO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      Formateadores.formatearMoneda(_pagoEstimado), 
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF00695C))
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: (_trabajadorSeleccionado != null && _loteSeleccionado != null && _kilosCtrl.text.isNotEmpty)
              ? () async {
                  final kilos = double.tryParse(_kilosCtrl.text) ?? 0;
                  HapticFeedback.mediumImpact();
                  
                  await ref.read(gestionAdministrativaOrchestratorProvider.notifier).liquidarLaborDiaria(
                    trabajadorId: int.parse(_trabajadorSeleccionado!.id),
                    loteId: int.parse(_loteSeleccionado!.id),
                    tipoPago: _tipoPago,
                    kilos: kilos,
                    tarifaBase: _trabajadorSeleccionado!.tarifaBase,
                    conAlimentacion: _conComida,
                  );
                  
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pesaje registrado con éxito. Se sumará a la liquidación semanal.'),
                        backgroundColor: Color(0xFF00695C),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              : null,
            child: const Text('GUARDAR PESAJE'),
          ),
        ],
      ),
    );
  }
}
