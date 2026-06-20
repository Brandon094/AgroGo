import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../inventory_management/presentation/providers/insumos_notifier.dart';
import '../../inventory_costs/presentation/providers/costos_notifier.dart';
import 'providers/cronograma_notifier.dart';
import '../domain/tarea_model.dart';
import '../../inventory_management/domain/insumo_model.dart';

class PantallaCronograma extends ConsumerWidget {
  const PantallaCronograma({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoTareas = ref.watch(cronogramaNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda de la Finca', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: estadoTareas.when(
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 4.0)),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (tareas) {
          final pendientes = tareas.where((t) => !t.estaCompletada).length;
          return Column(
            children: [
              RepaintBoundary(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)]),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                  ),
                  child: Column(
                    children: [
                      const Text('ACTIVIDADES PENDIENTES', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white70)),
                      Text('$pendientes', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tareas.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return RepaintBoundary(
                      child: _TarjetaTarea(tarea: tareas[index]),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TarjetaTarea extends ConsumerWidget {
  final TareaEntity tarea;
  const _TarjetaTarea({required this.tarea});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () => _manejarToque(context, ref),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.task_alt, color: Color(0xFF1B5E20)),
              const SizedBox(width: 16),
              Expanded(child: Text(tarea.titulo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              Icon(tarea.estaCompletada ? Icons.check_circle : Icons.radio_button_unchecked, color: tarea.estaCompletada ? Colors.green : Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _manejarToque(BuildContext context, WidgetRef ref) {
    final nuevoEstado = !tarea.estaCompletada;
    ref.read(cronogramaNotifierProvider.notifier).marcarComoCompletada(tarea, nuevoEstado);
    if (nuevoEstado && ['Abonado', 'Fumigación', 'Sanidad Animal'].contains(tarea.tipoActividad)) {
      showDialog(context: context, builder: (context) => _DialogoGastoConInventario(tarea: tarea));
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
      title: const Text('Registrar Gasto'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _costoCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Valor (COP)', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            insumosAsync.maybeWhen(
              data: (insumos) => DropdownButtonFormField<InsumoEntity>(
                value: _insumoSeleccionado,
                items: insumos.map((i) => DropdownMenuItem(value: i, child: Text(i.nombre))).toList(),
                onChanged: (v) => setState(() => _insumoSeleccionado = v),
                decoration: const InputDecoration(labelText: 'Insumo (Bodega)', border: OutlineInputBorder()),
              ),
              orElse: () => const Text('Cargando bodega...'),
            ),
            if (_insumoSeleccionado != null) ...[
              const SizedBox(height: 12),
              TextField(controller: _cantidadInsumoCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Cantidad', suffixText: _insumoSeleccionado!.unidadMedida, border: const OutlineInputBorder())),
            ]
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
        ElevatedButton(
          onPressed: () async {
            final valor = double.tryParse(_costoCtrl.text);
            if (valor != null) {
              await ref.read(costosNotifierProvider.notifier).agregarCosto(
                nombreItem: widget.tarea.titulo,
                categoria: 'Operativos',
                precioTotal: valor,
                loteId: widget.tarea.loteId,
              );
            }
            if (_insumoSeleccionado != null) {
              final cant = double.tryParse(_cantidadInsumoCtrl.text) ?? 0;
              await ref.read(insumosNotifierProvider.notifier).ajustarStock(_insumoSeleccionado!.id, -cant);
            }
            if (mounted) Navigator.pop(context);
          },
          child: const Text('GUARDAR'),
        ),
      ],
    );
  }
}
