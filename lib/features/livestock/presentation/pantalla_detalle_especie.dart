import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'providers/pecuario_notifier.dart';
import 'providers/especie_detalle_notifier.dart';
import '../domain/entidades_pecuario.dart';
import '../../inventory_management/presentation/providers/insumos_notifier.dart';
import '../../inventory_management/domain/insumo_model.dart';

import 'package:agrogo/features/maps_and_lots/domain/lote_model.dart';
import 'package:agrogo/features/maps_and_lots/presentation/providers/panel_lotes_notifier.dart';

class PantallaDetalleEspecie extends ConsumerWidget {
  final String especieId;
  const PantallaDetalleEspecie({super.key, required this.especieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final especieAsync = ref.watch(pecuarioNotifierProvider);

    return especieAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (especies) {
        final especie = especies.firstWhere(
          (e) => e.id == especieId,
          orElse: () => const EspecieEntity(id: '', nombre: '', tipoEspecie: '', cantidadActual: 0, cantidadInicial: 0),
        );

        if (especie.id.isEmpty) {
          return const Scaffold(body: Center(child: Text('Grupo no encontrado')));
        }

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 120,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(especie.nombre, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
                  Row(
                    children: [
                      Text('${especie.cantidadActual} / ${especie.cantidadInicial} ${especie.tipoEspecie}', style: const TextStyle(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      const Icon(Icons.calculate_rounded, size: 12, color: Colors.amber),
                      Text(' Unitario: \$${especie.costoUnitarioActual.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.w900)),
                      if (!especie.estaActivo || especie.utilidadesGeneradas != 0) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.trending_up_rounded, size: 12, color: Colors.lightGreenAccent),
                        Text(' Utilidad: \$${especie.utilidadesGeneradas.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12, color: Colors.lightGreenAccent, fontWeight: FontWeight.w900)),
                      ],
                    ],
                  ),
                ],
              ),
              actions: [
                if (especie.estaActivo)
                  IconButton(
                    icon: const Icon(Icons.check_circle_outline_rounded, size: 30, color: Colors.lightGreenAccent),
                    onPressed: () => _mostrarFormCierre(context, ref, especie),
                    tooltip: 'Cerrar Ciclo (Venta/Beneficio)',
                  ),
                IconButton(
                  icon: const Icon(Icons.edit_note_rounded, size: 30),
                  onPressed: () => _mostrarFormEditar(context, ref, especie),
                  tooltip: 'Editar Grupo',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, size: 30),
                  onPressed: () => _confirmarEliminacion(context, ref, especie),
                  tooltip: 'Eliminar Grupo',
                ),
                const SizedBox(width: 8),
              ],
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              bottom: const TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 4,
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                tabs: [
                  Tab(icon: Icon(Icons.health_and_safety_rounded), text: 'Salud'),
                  Tab(icon: Icon(Icons.restaurant_rounded), text: 'Alimento'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _TabSalud(especie: especie),
                _TabAlimentacion(especie: especie),
              ],
            ),
          ),
        );
      },
    );
  }

  void _mostrarFormEditar(BuildContext context, WidgetRef ref, EspecieEntity especie) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => _FormularioEdicionEspecieModal(especie: especie),
    );
  }

  void _mostrarFormCierre(BuildContext context, WidgetRef ref, EspecieEntity especie) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => _FormCierreModal(especie: especie),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref, EspecieEntity especie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar grupo animal?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('Esta acción eliminará a ${especie.nombre} y todo su historial de salud y alimentación.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          TextButton(
            onPressed: () async {
              await ref.read(pecuarioNotifierProvider.notifier).eliminarEspecie(especie.id);
              if (context.mounted) {
                Navigator.pop(context); // Cerrar diálogo
                Navigator.pop(context); // Volver al panel pecuario
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Grupo animal eliminado con éxito'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('ELIMINAR', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _FormularioEdicionEspecieModal extends ConsumerStatefulWidget {
  final EspecieEntity especie;
  const _FormularioEdicionEspecieModal({required this.especie});

  @override
  ConsumerState<_FormularioEdicionEspecieModal> createState() => _FormularioEdicionEspecieModalState();
}

class _FormularioEdicionEspecieModalState extends ConsumerState<_FormularioEdicionEspecieModal> {
  late TextEditingController _nombreCtrl;
  late TextEditingController _cantCtrl;
  late TextEditingController _valorUnitarioCtrl;
  late String _tipo;
  String? _loteId;

  @override
  void initState() {
    super.initState();
    _nombreCtrl = TextEditingController(text: widget.especie.nombre);
    _cantCtrl = TextEditingController(text: widget.especie.cantidadActual.toString());
    _valorUnitarioCtrl = TextEditingController(text: widget.especie.valorUnitario.toString());
    _tipo = widget.especie.tipoEspecie;
    _loteId = widget.especie.loteId;
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _cantCtrl.dispose();
    _valorUnitarioCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    final lotesAsync = ref.watch(panelLotesNotifierProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Editar Grupo', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
          const SizedBox(height: 24),
          TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre del Grupo', prefixIcon: Icon(Icons.edit_note_rounded))),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _tipo,
            items: ['Cerdo', 'Vaca / Toro', 'Gallina / Pollo', 'Pez'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (v) => setState(() => _tipo = v!),
            decoration: const InputDecoration(labelText: 'Especie', prefixIcon: Icon(Icons.category_rounded)),
          ),
          const SizedBox(height: 16),
          lotesAsync.maybeWhen(
            data: (lotes) => DropdownButtonFormField<String>(
              value: _loteId,
              decoration: const InputDecoration(labelText: 'Cambiar de lote', prefixIcon: Icon(Icons.landscape_rounded)),
              items: lotes.map((l) => DropdownMenuItem(value: l.id, child: Text(l.nombre))).toList(),
              onChanged: (v) => setState(() => _loteId = v),
            ),
            orElse: () => const Text('Cargando lotes...'),
          ),
          const SizedBox(height: 16),
          TextField(controller: _cantCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Cantidad Actual', prefixIcon: Icon(Icons.numbers_rounded))),
          const SizedBox(height: 16),
          TextField(
            controller: _valorUnitarioCtrl, 
            keyboardType: TextInputType.number, 
            decoration: const InputDecoration(
              labelText: 'Valor unitario estimado', 
              prefixIcon: Icon(Icons.payments_rounded),
              suffixText: 'COP',
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20)),
            onPressed: () async {
              if (_nombreCtrl.text.isNotEmpty && _cantCtrl.text.isNotEmpty) {
                final cant = int.tryParse(_cantCtrl.text) ?? widget.especie.cantidadActual;
                final vUnit = double.tryParse(_valorUnitarioCtrl.text) ?? 0.0;
                
                final especieActualizada = widget.especie.copyWith(
                  nombre: _nombreCtrl.text.trim(),
                  tipoEspecie: _tipo,
                  cantidadActual: cant,
                  loteId: _loteId,
                  valorUnitario: vUnit,
                  valorTotalInversion: cant * vUnit,
                );
                await ref.read(pecuarioNotifierProvider.notifier).actualizarEspecie(especieActualizada);
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Grupo animal actualizado'),
                      backgroundColor: Color(0xFF00695C),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
            child: const Text('GUARDAR CAMBIOS'),
          ),
        ],
      ),
    );
  }
}

class _TabSalud extends ConsumerWidget {
  final EspecieEntity especie;
  const _TabSalud({required this.especie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalle = ref.watch(especieDetalleProvider(especie.id));

    return detalle.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (state) {
        return Column(
          children: [
            Expanded(
              child: state.controles.isEmpty
                  ? const _VistaVacia(mensaje: 'Sin registros sanitarios', icono: Icons.vaccines_rounded)
                  : ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: state.controles.length,
                      itemBuilder: (context, i) {
                        final c = state.controles[i];
                        final fAplicacion = DateFormat('d MMM', 'es_CO').format(c.fechaAplicacion);
                        final fProxima = DateFormat('d MMM yyyy', 'es_CO').format(c.proximaDosis);
                        
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
                                  child: Icon(Icons.medical_information_rounded, color: Colors.red.shade800),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${c.tipo}: ${c.producto}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Color(0xFF37474F))),
                                      const SizedBox(height: 4),
                                      Text('Aplicado: $fAplicacion', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 13)),
                                      Text('PRÓXIMA: $fProxima', style: TextStyle(color: Colors.purple.shade800, fontWeight: FontWeight.w900, fontSize: 13)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            if (especie.estaActivo)
              _BotonAccion(
                onTap: () => _mostrarFormSalud(context, ref, especie),
                label: 'REGISTRAR SANIDAD',
                icon: Icons.add_moderator_rounded,
                color: Colors.red.shade800,
              ),
          ],
        );
      },
    );
  }

  void _mostrarFormSalud(BuildContext context, WidgetRef ref, EspecieEntity especie) {
    showModalBottomSheet(context: context, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))), builder: (context) => _FormSaludModal(especie: especie));
  }
}

class _TabAlimentacion extends ConsumerWidget {
  final EspecieEntity especie;
  const _TabAlimentacion({required this.especie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalle = ref.watch(especieDetalleProvider(especie.id));

    return detalle.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (state) {
        return Column(
          children: [
            Expanded(
              child: state.alimentacion.isEmpty
                  ? const _VistaVacia(mensaje: 'Sin registros de comida', icono: Icons.bakery_dining_rounded)
                  : ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: state.alimentacion.length,
                      itemBuilder: (context, i) {
                        final a = state.alimentacion[i];
                        final fecha = DateFormat('EEEE d, MMM', 'es_CO').format(a.fecha);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            leading: CircleAvatar(backgroundColor: Colors.orange.withValues(alpha: 0.1), child: const Icon(Icons.restaurant_rounded, color: Colors.orange)),
                            title: Text(a.producto, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
                            subtitle: Text('Consumo: ${a.cantidadKilos} kg', style: const TextStyle(fontWeight: FontWeight.bold)),
                            trailing: Text(fecha, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                          ),
                        );
                      },
                    ),
            ),
            if (especie.estaActivo)
              _BotonAccion(
                onTap: () => _mostrarFormComida(context, ref, especie),
                label: 'REGISTRAR CONSUMO',
                icon: Icons.add_shopping_cart_rounded,
                color: Colors.orange.shade800,
              ),
          ],
        );
      },
    );
  }

  void _mostrarFormComida(BuildContext context, WidgetRef ref, EspecieEntity especie) {
    showModalBottomSheet(context: context, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))), builder: (context) => _FormComidaModal(especie: especie));
  }
}

class _BotonAccion extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final IconData icon;
  final Color color;
  const _BotonAccion({required this.onTap, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(backgroundColor: color, minimumSize: const Size(double.infinity, 64)),
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}

class _VistaVacia extends StatelessWidget {
  final String mensaje;
  final IconData icono;
  const _VistaVacia({required this.mensaje, required this.icono});
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icono, size: 80, color: Colors.grey.withValues(alpha: 0.2)), const SizedBox(height: 16), Text(mensaje, style: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold))]));
  }
}

class _FormSaludModal extends ConsumerStatefulWidget {
  final EspecieEntity especie;
  const _FormSaludModal({required this.especie});
  @override
  ConsumerState<_FormSaludModal> createState() => _FormSaludModalState();
}

class _FormSaludModalState extends ConsumerState<_FormSaludModal> {
  final _prodCtrl = TextEditingController();
  final _cantCtrl = TextEditingController();
  String _tipo = 'Vacuna';
  DateTime _proxima = DateTime.now().add(const Duration(days: 90));
  InsumoEntity? _insumoSeleccionado;

  @override
  void dispose() {
    _prodCtrl.dispose();
    _cantCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    final insumos = ref.watch(insumosNotifierProvider).valueOrNull ?? [];

    return Padding(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + padding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Tratamiento', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _tipo,
              items: ['Vacuna', 'Purga', 'Vitamina', 'Medicamento'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (v) => setState(() => _tipo = v!),
              decoration: const InputDecoration(labelText: 'Tipo de tratamiento', prefixIcon: Icon(Icons.category_rounded)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _prodCtrl, 
              decoration: const InputDecoration(labelText: 'Nombre del Producto', prefixIcon: Icon(Icons.medication_rounded)),
              onChanged: (v) => setState(() {}),
            ),
            const SizedBox(height: 16),
            
            // Opcional: Descontar de bodega
            DropdownButtonFormField<InsumoEntity>(
              value: _insumoSeleccionado,
              decoration: const InputDecoration(labelText: 'Descontar de Bodega (Opcional)', prefixIcon: Icon(Icons.inventory_2_rounded)),
              items: insumos.map((i) => DropdownMenuItem(value: i, child: Text(i.nombre))).toList(),
              onChanged: (v) {
                setState(() {
                  _insumoSeleccionado = v;
                  if (v != null) _prodCtrl.text = v.nombre;
                });
              },
            ),
            
            if (_insumoSeleccionado != null) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _cantCtrl, 
                keyboardType: TextInputType.number, 
                decoration: InputDecoration(
                  labelText: 'Cantidad utilizada', 
                  prefixIcon: const Icon(Icons.scale_rounded),
                  suffixText: _insumoSeleccionado!.unidadMedida,
                ),
              ),
            ],

            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade800),
              onPressed: () async {
                if (_prodCtrl.text.isEmpty) return;
                HapticFeedback.mediumImpact();
                
                final cant = double.tryParse(_cantCtrl.text) ?? 0.0;

                await ref.read(especieDetalleProvider(widget.especie.id).notifier).registrarSalud(
                  tipo: _tipo, 
                  producto: _prodCtrl.text, 
                  fecha: DateTime.now(), 
                  proxima: _proxima, 
                  nombreEspecie: widget.especie.nombre,
                  insumoId: _insumoSeleccionado?.id,
                  cantidadInsumo: cant,
                );
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Salud registrada y agendada'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text('GUARDAR Y AGENDAR'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormComidaModal extends ConsumerStatefulWidget {
  final EspecieEntity especie;
  const _FormComidaModal({required this.especie});
  @override
  ConsumerState<_FormComidaModal> createState() => _FormComidaModalState();
}

class _FormComidaModalState extends ConsumerState<_FormComidaModal> {
  final _cantCtrl = TextEditingController();
  InsumoEntity? _insumoSeleccionado;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    final insumos = ref.watch(insumosNotifierProvider).valueOrNull ?? [];

    return Padding(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Alimentación', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
          const SizedBox(height: 24),
          DropdownButtonFormField<InsumoEntity>(
            value: _insumoSeleccionado,
            decoration: const InputDecoration(labelText: 'Descontar de Bodega', prefixIcon: Icon(Icons.inventory_2_rounded)),
            items: insumos.map((i) => DropdownMenuItem(value: i, child: Text(i.nombre))).toList(),
            onChanged: (v) => setState(() => _insumoSeleccionado = v),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _cantCtrl, 
            keyboardType: TextInputType.number, 
            decoration: const InputDecoration(
              labelText: 'Cantidad a descontar', 
              prefixIcon: Icon(Icons.scale_rounded),
              suffixText: 'kg',
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade800),
            onPressed: () async {
              final kilos = double.tryParse(_cantCtrl.text) ?? 0;
              if (kilos <= 0 || _insumoSeleccionado == null) return;
              HapticFeedback.mediumImpact();
              await ref.read(especieDetalleProvider(widget.especie.id).notifier).registrarComida(
                producto: _insumoSeleccionado!.nombre, 
                kilos: kilos, 
                insumoId: _insumoSeleccionado!.id
              );
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Consumo registrado con éxito'),
                    backgroundColor: Colors.orange,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('REGISTRAR CONSUMO'),
          ),
        ],
      ),
    );
  }
}

class _FormCierreModal extends ConsumerStatefulWidget {
  final EspecieEntity especie;
  const _FormCierreModal({required this.especie});
  @override
  ConsumerState<_FormCierreModal> createState() => _FormCierreModalState();
}

class _FormCierreModalState extends ConsumerState<_FormCierreModal> {
  final _kilosCtrl = TextEditingController();
  final _precioCtrl = TextEditingController();
  final _cantidadCtrl = TextEditingController();
  TipoSalidaPecuaria _tipo = TipoSalidaPecuaria.ventaEnPie;

  @override
  void initState() {
    super.initState();
    _cantidadCtrl.text = widget.especie.cantidadActual.toString();
  }

  @override
  void dispose() {
    _kilosCtrl.dispose();
    _precioCtrl.dispose();
    _cantidadCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Venta / Beneficio', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
          const SizedBox(height: 8),
          Text('Costo Unitario Prorrateado: \$${widget.especie.costoUnitarioActual.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          const SizedBox(height: 24),
          
          SegmentedButton<TipoSalidaPecuaria>(
            segments: const [
              ButtonSegment(value: TipoSalidaPecuaria.ventaEnPie, label: Text('Venta en Pie'), icon: Icon(Icons.front_loader)),
              ButtonSegment(value: TipoSalidaPecuaria.sacrificio, label: Text('Sacrificio'), icon: Icon(Icons.restaurant_rounded)),
            ],
            selected: {_tipo},
            onSelectionChanged: (set) => setState(() => _tipo = set.first),
          ),

          const SizedBox(height: 24),
          TextField(
            controller: _cantidadCtrl, 
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(
              labelText: '¿Cuántos animales salen?', 
              prefixIcon: const Icon(Icons.numbers_rounded),
              helperText: 'Quedarán ${widget.especie.cantidadActual - (int.tryParse(_cantidadCtrl.text) ?? 0)} en el lote',
            ),
            onChanged: (v) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _kilosCtrl, 
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(
              labelText: _tipo == TipoSalidaPecuaria.ventaEnPie ? 'Peso Total de la tanda (kg)' : 'Kilos de carne obtenidos', 
              prefixIcon: const Icon(Icons.scale_rounded),
              suffixText: 'kg',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _precioCtrl, 
            keyboardType: TextInputType.number, 
            decoration: const InputDecoration(
              labelText: 'Precio de Venta Total (Tanda)', 
              prefixIcon: Icon(Icons.payments_rounded),
              suffixText: 'COP',
            ),
          ),

          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20)),
            onPressed: () async {
              final cantidad = int.tryParse(_cantidadCtrl.text) ?? 0;
              final kilos = double.tryParse(_kilosCtrl.text) ?? 0;
              final precio = double.tryParse(_precioCtrl.text) ?? 0;
              
              if (cantidad <= 0 || cantidad > widget.especie.cantidadActual) return;
              if (precio <= 0) return;

              HapticFeedback.heavyImpact();
              await ref.read(especieDetalleProvider(widget.especie.id).notifier).registrarSalidaPecuaria(
                tipo: _tipo, 
                cantidadASacar: cantidad,
                kilos: kilos, 
                precioTotal: precio,
              );
              
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(cantidad == widget.especie.cantidadActual ? 'Lote cerrado con éxito.' : 'Salida parcial registrada con éxito.'),
                    backgroundColor: Color(0xFF1B5E20),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('REGISTRAR SALIDA'),
          ),
        ],
      ),
    );
  }
}
