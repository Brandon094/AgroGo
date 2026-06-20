import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/insumos_notifier.dart';
import '../domain/insumo_model.dart';

class PantallaBodega extends ConsumerWidget {
  const PantallaBodega({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insumosAsync = ref.watch(insumosNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bodega Virtual'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: Colors.white,
      ),
      body: insumosAsync.when(
        data: (insumos) => insumos.isEmpty 
          ? const _VistaVaciaBodega()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: insumos.length + 1,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == insumos.length) {
                  return const RepaintBoundary(child: _BotonBetaServiCarga());
                }
                return RepaintBoundary(child: _TarjetaInsumo(insumo: insumos[index]));
              },
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormInsumo(context, ref),
        label: const Text('Nuevo Insumo', style: TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add_box),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: Colors.white,
      ),
    );
  }

  void _mostrarFormInsumo(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(context: context, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))), builder: (context) => const _FormInsumoModal());
  }
}

class _BotonBetaServiCarga extends StatelessWidget {
  const _BotonBetaServiCarga();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 40),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.blueGrey.shade200)),
      child: Column(children: [
        const Icon(Icons.local_shipping_outlined, size: 48, color: Colors.blueGrey),
        const SizedBox(height: 16),
        const Text('¿Necesitas despachar tu carga?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: null, child: const Text('SOLICITAR SERVICARGA (PRÓXIMAMENTE)')),
      ]),
    );
  }
}

class _TarjetaInsumo extends ConsumerWidget {
  final InsumoEntity insumo;
  const _TarjetaInsumo({required this.insumo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: insumo.esEscaso ? Colors.red.shade50 : Colors.blue.shade50,
          child: Icon(insumo.esEscaso ? Icons.warning : Icons.inventory_2, color: insumo.esEscaso ? Colors.red : Colors.blue),
        ),
        title: Text(insumo.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${insumo.cantidadActual} ${insumo.unidadMedida}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: insumo.esEscaso ? Colors.red : Colors.black87)),
        trailing: IconButton(onPressed: () => _mostrarAjusteStock(context, ref), icon: const Icon(Icons.edit_note)),
      ),
    );
  }

  void _mostrarAjusteStock(BuildContext context, WidgetRef ref) {
    final ctrl = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Ajustar ${insumo.nombre}'),
      content: TextField(controller: ctrl, keyboardType: TextInputType.number, decoration: InputDecoration(suffixText: insumo.unidadMedida)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
        ElevatedButton(onPressed: () { ref.read(insumosNotifierProvider.notifier).ajustarStock(insumo.id, double.parse(ctrl.text)); Navigator.pop(context); }, child: const Text('AJUSTAR')),
      ],
    ));
  }
}

class _VistaVaciaBodega extends StatelessWidget {
  const _VistaVaciaBodega();
  @override
  Widget build(BuildContext context) { return const Center(child: Text('Bodega vacía')); }
}

class _FormInsumoModal extends ConsumerStatefulWidget {
  const _FormInsumoModal();
  @override
  ConsumerState<_FormInsumoModal> createState() => _FormInsumoModalState();
}

class _FormInsumoModalState extends ConsumerState<_FormInsumoModal> {
  final _nombreCtrl = TextEditingController();
  final _stockCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + padding), child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre')),
      TextField(controller: _stockCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stock')),
      ElevatedButton(onPressed: () { ref.read(insumosNotifierProvider.notifier).registrarInsumo(nombre: _nombreCtrl.text, unidad: 'Bultos', stockInicial: double.parse(_stockCtrl.text)); Navigator.pop(context); }, child: const Text('GUARDAR'))
    ]));
  }
}
