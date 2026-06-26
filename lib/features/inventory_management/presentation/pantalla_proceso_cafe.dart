import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'providers/beneficio_notifier.dart';
import '../domain/beneficio_model.dart';
import '../../maps_and_lots/domain/lote_model.dart';
import '../../maps_and_lots/presentation/providers/panel_lotes_notifier.dart';

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
                  return const Center(child: Text('No hay lotes en proceso de beneficio', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)));
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
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
          ),
          child: Column(
            children: [
              const Text('RECOLECCIÓN TOTAL SEMANA', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
              const SizedBox(height: 8),
              Text('${kilos.toStringAsFixed(1)} kg Cereza', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
              const SizedBox(height: 20),
              
              // Selector de Lote para el beneficio
              lotesAsync.maybeWhen(
                data: (lotes) {
                  final agricolas = lotes.where((l) => l.uso == TipoUsoLote.agricola).toList();
                  if (agricolas.isEmpty) return const SizedBox.shrink();
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: DropdownButton<Lote>(
                      value: _loteSeleccionado,
                      hint: const Text('Vincular a un lote', style: TextStyle(color: Colors.white60)),
                      dropdownColor: const Color(0xFF3E2723),
                      underline: const SizedBox(),
                      isExpanded: true,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      items: agricolas.map((l) => DropdownMenuItem(value: l, child: Text(l.nombre))).toList(),
                      onChanged: (v) => setState(() => _loteSeleccionado = v),
                    ),
                  );
                },
                orElse: () => const SizedBox.shrink(),
              ),

              ElevatedButton.icon(
                onPressed: kilos > 0 ? () => _iniciarProceso(context, ref, kilos, _loteSeleccionado?.id) : null,
                icon: const Icon(Icons.settings_input_component_rounded),
                label: const Text('INICIAR DESPULPADO'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF57C00),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _iniciarProceso(BuildContext context, WidgetRef ref, double kilos, String? loteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Iniciar beneficio?'),
        content: Text('Se creará un nuevo lote con los ${kilos.toStringAsFixed(1)} kg recolectados.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          ElevatedButton(
            onPressed: () {
              ref.read(beneficioNotifierProvider.notifier).iniciarNuevoBeneficio(kilos, loteId: loteId);
              Navigator.pop(context);
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
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(20),
            title: Text('Lote Café - $fecha', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${beneficio.kilosCereza} kg Cereza inicial', style: const TextStyle(fontWeight: FontWeight.bold)),
                if (beneficio.loteOrigenNombre != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.landscape_rounded, size: 12, color: Colors.teal),
                        Text(' Origen: ${beneficio.loteOrigenNombre}', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12)),
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
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
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
                await ref.read(beneficioNotifierProvider.notifier).venderLote(beneficio, peso);
                if (context.mounted) Navigator.pop(context);
              }
            }, 
            child: const Text('REGISTRAR VENTA')
          ),
        ],
      ),
    );
  }

  void _avanzarLote(BuildContext context, WidgetRef ref) {
    if (beneficio.estado == EstadoBeneficio.secado) {
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
              onPressed: () {
                final peso = double.tryParse(pesoCtrl.text);
                if (peso != null) {
                  ref.read(beneficioNotifierProvider.notifier).avanzarEstado(beneficio, kilosFinales: peso);
                  Navigator.pop(context);
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
              onPressed: () {
                final costo = double.tryParse(costoCtrl.text) ?? 0.0;
                ref.read(beneficioNotifierProvider.notifier).avanzarEstado(beneficio, costoAdicional: costo);
                Navigator.pop(context);
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
