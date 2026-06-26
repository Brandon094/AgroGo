import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../inventory_management/presentation/providers/insumos_notifier.dart';
import '../../inventory_costs/presentation/providers/costos_notifier.dart';
import 'providers/cronograma_notifier.dart';
import '../domain/tarea_model.dart';
import '../../inventory_management/domain/insumo_model.dart';
import '../../../core/shared/widgets/agro_section_header.dart';
import '../../../core/shared/widgets/agro_empty_state.dart';

class PantallaCronograma extends ConsumerWidget {
  const PantallaCronograma({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoTareas = ref.watch(cronogramaNotifierProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF9FBF9), Colors.white],
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: AgroSectionHeader(
                titulo: 'Agenda',
                icono: Icons.calendar_today_rounded,
                extra: estadoTareas.maybeWhen(
                  data: (tareas) {
                    final pendientes = tareas.where((t) => !t.estaCompletada).length;
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Theme.of(context).primaryColor, const Color(0xFF2E7D32)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Labores Pendientes',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$pendientes',
                            style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                ),
              ),
            ),
            estadoTareas.when(
              loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
              error: (error, stack) => SliverFillRemaining(child: Center(child: Text('Error: $error'))),
              data: (tareas) {
                if (tareas.isEmpty) {
                  return const SliverFillRemaining(
                    child: AgroEmptyState(
                      mensaje: 'Su agenda está limpia',
                      icono: Icons.calendar_today_rounded,
                      subtitulo: 'No tiene labores programadas para hoy.',
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => RepaintBoundary(
                        child: _TarjetaTarea(tarea: tareas[index]),
                      ),
                      childCount: tareas.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormularioAgregarTarea(context, ref),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        label: const Text('NUEVA LABOR', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2)),
        icon: const Icon(Icons.add_task_rounded),
      ),
    );
  }

  void _mostrarFormularioAgregarTarea(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => const _FormularioAgendaModal(),
    );
  }
}

class _TarjetaTarea extends ConsumerWidget {
  final TareaEntity tarea;
  const _TarjetaTarea({required this.tarea});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = _getColorActividad(tarea.tipoActividad);
    final fecha = DateFormat('d MMM', 'es_CO').format(tarea.fechaInicio);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))],
        border: tarea.estaCompletada ? Border.all(color: Colors.green.withValues(alpha: 0.2)) : null,
      ),
      child: InkWell(
        onTap: () => _manejarToque(context, ref),
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.task_alt_rounded, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tarea.titulo,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        decoration: tarea.estaCompletada ? TextDecoration.lineThrough : null,
                        color: tarea.estaCompletada ? Colors.grey : const Color(0xFF37474F),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          tarea.tipoActividad,
                          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.calendar_today, size: 10, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(fecha, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                tarea.estaCompletada ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                color: tarea.estaCompletada ? Colors.green : Colors.grey.shade300,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorActividad(String tipo) {
    switch (tipo) {
      case 'Secado': return Colors.orange.shade800;
      case 'Abonado': return Colors.green.shade800;
      case 'Fumigación': return Colors.blue.shade800;
      case 'Sanidad Animal': return Colors.purple.shade800;
      default: return Colors.blueGrey;
    }
  }

  void _manejarToque(BuildContext context, WidgetRef ref) async {
    final nuevoEstado = !tarea.estaCompletada;
    await ref.read(cronogramaNotifierProvider.notifier).marcarComoCompletada(tarea, nuevoEstado);
    
    if (context.mounted) {
      if (nuevoEstado) {
        final tiposConGasto = ['Abonado', 'Fumigación', 'Sanidad Animal'];
        if (tiposConGasto.contains(tarea.tipoActividad)) {
          showDialog(context: context, builder: (context) => _DialogoGastoConInventario(tarea: tarea));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Labor marcada como completada ✅'),
              backgroundColor: Color(0xFF2E7D32),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    }
  }
}

class _DialogoGastoConInventario extends ConsumerStatefulWidget {
  final TareaEntity tarea;
  const _DialogoGastoConInventario({required this.tarea});
  @override
  ConsumerState<_DialogoGastoConInventario> createState() => _DialogoGastoConInventarioState();
}

class _DialogoGastoConInventarioState extends ConsumerState<_DialogoGastoConInventario> {
  final _costoCtrl = TextEditingController();
  final _cantidadInsumoCtrl = TextEditingController(text: '1');
  InsumoEntity? _insumoSeleccionado;

  @override
  void dispose() {
    _costoCtrl.dispose();
    _cantidadInsumoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insumosAsync = ref.watch(insumosNotifierProvider);
    return AlertDialog(
      title: const Text('Registrar Gasto', style: TextStyle(fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Esta labor genera un costo automático.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            TextField(
              controller: _costoCtrl, 
              keyboardType: TextInputType.number, 
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              decoration: const InputDecoration(labelText: 'Valor (COP)', prefixText: '\$ ', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            const Text('VÍNCULO CON BODEGA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 1)),
            const SizedBox(height: 8),
            insumosAsync.maybeWhen(
              data: (insumos) => DropdownButtonFormField<InsumoEntity>(
                value: _insumoSeleccionado,
                items: insumos.map((i) => DropdownMenuItem(value: i, child: Text(i.nombre))).toList(),
                onChanged: (v) => setState(() => _insumoSeleccionado = v),
                decoration: const InputDecoration(labelText: 'Insumo usado', border: OutlineInputBorder()),
              ),
              orElse: () => const Text('Cargando bodega...'),
            ),
            if (_insumoSeleccionado != null) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _cantidadInsumoCtrl, 
                keyboardType: TextInputType.number, 
                decoration: InputDecoration(labelText: 'Cantidad', suffixText: _insumoSeleccionado!.unidadMedida, border: const OutlineInputBorder()),
              ),
            ]
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('OMITIR GASTO', style: TextStyle(color: Colors.grey))),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(120, 50)),
          onPressed: () async {
            final valor = double.tryParse(_costoCtrl.text);
            if (valor != null) {
              await ref.read(costosNotifierProvider.notifier).agregarCosto(
                nombre: widget.tarea.titulo,
                categoria: 'Operativos',
                precioTotal: valor,
                loteId: widget.tarea.loteId,
              );
            }
            if (_insumoSeleccionado != null) {
              final cant = double.tryParse(_cantidadInsumoCtrl.text) ?? 0;
              await ref.read(insumosNotifierProvider.notifier).ajustarStock(_insumoSeleccionado!.id, -cant);
            }
            if (mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Labor y gasto guardados correctamente'),
                  backgroundColor: Color(0xFF00695C),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: const Text('GUARDAR'),
        ),
      ],
    );
  }
}

class _FormularioAgendaModal extends ConsumerStatefulWidget {
  const _FormularioAgendaModal();
  @override
  ConsumerState<_FormularioAgendaModal> createState() => _FormularioAgendaModalState();
}

class _FormularioAgendaModalState extends ConsumerState<_FormularioAgendaModal> {
  final _formularioKey = GlobalKey<FormState>();
  final _tituloCtrl = TextEditingController();
  String _tipoSeleccionado = 'Abonado';
  DateTime _fechaInicio = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + padding),
      child: Form(
        key: _formularioKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Nueva Actividad', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
            const SizedBox(height: 24),
            TextFormField(
              controller: _tituloCtrl, 
              decoration: const InputDecoration(labelText: '¿Qué labor va a realizar?', prefixIcon: Icon(Icons.edit_calendar_rounded)),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              validator: (v) => v!.isEmpty ? 'Ingrese la labor' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _tipoSeleccionado,
              items: ['Secado', 'Abonado', 'Fumigación'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (v) => setState(() => _tipoSeleccionado = v!),
              decoration: const InputDecoration(labelText: 'Categoría', prefixIcon: Icon(Icons.category_rounded)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (_formularioKey.currentState!.validate()) {
                  await ref.read(cronogramaNotifierProvider.notifier).agregarTarea(
                    titulo: _tituloCtrl.text.trim(),
                    tipoActividad: _tipoSeleccionado,
                    fechaInicio: _fechaInicio,
                    fechaFinEstimada: _fechaInicio.add(const Duration(days: 1)),
                  );
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Actividad programada en la agenda'),
                        backgroundColor: Color(0xFF00695C),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              },
              child: const Text('AGENDAR ACTIVIDAD'),
            ),
          ],
        ),
      ),
    );
  }
}
