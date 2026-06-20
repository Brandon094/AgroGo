import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/costos_notifier.dart';
import 'package:agrogo/features/maps_and_lots/presentation/providers/panel_lotes_notifier.dart';
import 'package:agrogo/features/maps_and_lots/domain/lote_model.dart';
import 'package:agrogo/features/inventory_costs/domain/calculadora_insumos_usecase.dart';

/// Pantalla que muestra el panel de insumos y costos acumulados de la finca.
class PantallaPanelCostos extends ConsumerStatefulWidget {
  final bool abrirCalculadora;
  final bool abrirFormulario;
  const PantallaPanelCostos({super.key, this.abrirCalculadora = false, this.abrirFormulario = false});
  @override
  ConsumerState<PantallaPanelCostos> createState() => _PantallaPanelCostosState();
}

class _PantallaPanelCostosState extends ConsumerState<PantallaPanelCostos> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.abrirCalculadora) _mostrarCalculadoraInsumos(context, ref);
      else if (widget.abrirFormulario) _mostrarFormularioAgregar(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final estadoCostos = ref.watch(costosNotifierProvider);
    final totalAcumulado = ref.read(costosNotifierProvider.notifier).obtenerTotalAcumulado();
    final estadoLotes = ref.watch(panelLotesNotifierProvider);

    final mapaLotes = estadoLotes.maybeWhen(
      data: (lotes) => {for (var l in lotes) l.id: l},
      orElse: () => <String, Lote>{},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insumos y Gastos'),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: estadoCostos.when(
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 4.0)),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (costos) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RepaintBoundary(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)]),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32.0), bottomRight: Radius.circular(32.0)),
                  ),
                  child: Column(
                    children: [
                      const Text('GASTO TOTAL ACUMULADO', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w900, color: Colors.white70)),
                      const SizedBox(height: 8.0),
                      Text('\$${totalAcumulado.toStringAsFixed(0)}', style: const TextStyle(fontSize: 36.0, fontWeight: FontWeight.w900, color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  onTap: () => _mostrarCalculadoraInsumos(context, ref),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.blue.shade100, width: 2)),
                    child: const Row(
                      children: [
                        Icon(Icons.calculate, color: Colors.blue, size: 28),
                        SizedBox(width: 16),
                        Text('CALCULADORA DE INSUMOS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: costos.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, indice) {
                    return RepaintBoundary(
                      child: _TarjetaGasto(
                        gasto: costos[indice],
                        lote: costos[indice].loteId != null ? mapaLotes[costos[indice].loteId] : null,
                        onDelete: () => _confirmarEliminacion(context, ref, costos[indice]),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormularioAgregar(context, ref),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        label: const Text('Registrar Gasto', style: TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add_shopping_cart),
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref, dynamic gasto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar registro?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          TextButton(onPressed: () { ref.read(costosNotifierProvider.notifier).eliminarCosto(gasto.id); Navigator.pop(context); }, child: const Text('ELIMINAR', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

  void _mostrarCalculadoraInsumos(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(context: context, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28.0))), builder: (context) => const _ModalCalculadoraInsumos());
  }

  void _mostrarFormularioAgregar(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(context: context, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28.0))), builder: (context) => const _FormularioCostoModal());
  }
}

class _TarjetaGasto extends StatelessWidget {
  final dynamic gasto;
  final Lote? lote;
  final VoidCallback onDelete;
  const _TarjetaGasto({required this.gasto, this.lote, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.receipt_long)),
        title: Text(gasto.nombreItem, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(gasto.categoria),
        trailing: Text('\$${gasto.precioTotal.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
      ),
    );
  }
}

class _VistaVaciaCostos extends StatelessWidget {
  const _VistaVaciaCostos();
  @override
  Widget build(BuildContext context) { return const Center(child: Text('Sin gastos')); }
}

class _ModalCalculadoraInsumos extends ConsumerStatefulWidget {
  const _ModalCalculadoraInsumos();
  @override
  ConsumerState<_ModalCalculadoraInsumos> createState() => _ModalCalculadoraInsumosState();
}

class _ModalCalculadoraInsumosState extends ConsumerState<_ModalCalculadoraInsumos> {
  final _calculadora = CalculadoraInsumosUseCase();
  Lote? _loteSeleccionado;
  final _gramosCtrl = TextEditingController(text: '50.0');
  @override
  Widget build(BuildContext context) {
    final lotes = ref.watch(panelLotesNotifierProvider).valueOrNull ?? [];
    return Container(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('Calculadora'),
      if (lotes.isNotEmpty) DropdownButton<Lote>(value: _loteSeleccionado ?? lotes.first, items: lotes.map((l) => DropdownMenuItem(value: l, child: Text(l.nombre))).toList(), onChanged: (v) => setState(() => _loteSeleccionado = v)),
      ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar'))
    ]));
  }
}

class _FormularioCostoModal extends ConsumerStatefulWidget {
  const _FormularioCostoModal();
  @override
  ConsumerState<_FormularioCostoModal> createState() => _FormularioCostoModalState();
}

class _FormularioCostoModalState extends ConsumerState<_FormularioCostoModal> {
  final _nombreCtrl = TextEditingController();
  final _precioCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + padding), child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre')),
      TextField(controller: _precioCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Precio')),
      ElevatedButton(onPressed: () { ref.read(costosNotifierProvider.notifier).agregarCosto(nombreItem: _nombreCtrl.text, categoria: 'Otro', precioTotal: double.parse(_precioCtrl.text)); Navigator.pop(context); }, child: const Text('GUARDAR'))
    ]));
  }
}
