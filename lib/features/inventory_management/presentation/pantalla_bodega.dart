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
        backgroundColor: const Color(0xFF3E2723), // Color café/madera para bodega
        foregroundColor: Colors.white,
      ),
      body: insumosAsync.when(
        data: (insumos) => insumos.isEmpty 
          ? const _VistaVaciaBodega()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: insumos.length,
              itemBuilder: (context, index) => _TarjetaInsumo(insumo: insumos[index]),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormInsumo(context, ref),
        label: const Text('Nuevo Insumo'),
        icon: const Icon(Icons.add_box),
        backgroundColor: const Color(0xFF3E2723),
      ),
    );
  }

  void _mostrarFormInsumo(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => const _FormInsumoModal(),
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: insumo.esEscaso ? Colors.red.shade50 : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                insumo.esEscaso ? Icons.warning_amber_rounded : Icons.inventory_2,
                color: insumo.esEscaso ? Colors.red : Colors.blue.shade800,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(insumo.nombre, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('${insumo.cantidadActual} ${insumo.unidadMedida}', 
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.w900,
                      color: insumo.esEscaso ? Colors.red : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => _mostrarAjusteStock(context, ref),
              icon: const Icon(Icons.edit_note, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarAjusteStock(BuildContext context, WidgetRef ref) {
    final cantidadCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ajustar ${insumo.nombre}'),
        content: TextField(
          controller: cantidadCtrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Ej: -2 para descontar, 10 para sumar',
            suffixText: insumo.unidadMedida,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          ElevatedButton(
            onPressed: () {
              final val = double.tryParse(cantidadCtrl.text);
              if (val != null) {
                ref.read(insumosNotifierProvider.notifier).ajustarStock(insumo.id, val);
                Navigator.pop(context);
              }
            },
            child: const Text('AJUSTAR'),
          ),
        ],
      ),
    );
  }
}

class _VistaVaciaBodega extends StatelessWidget {
  const _VistaVaciaBodega();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text('Tu bodega está vacía', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            child: Text('Registra bultos de abono, purina o herramientas aquí.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

class _FormInsumoModal extends ConsumerStatefulWidget {
  const _FormInsumoModal();
  @override
  ConsumerState<_FormInsumoModal> createState() => _FormInsumoModalState();
}

class _FormInsumoModalState extends ConsumerState<_FormInsumoModal> {
  final _nombreCtrl = TextEditingController();
  final _stockCtrl = TextEditingController();
  final _umbralCtrl = TextEditingController(text: '5');
  String _unidad = 'Bultos';

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 32, 24, 32 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Nuevo Insumo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre (Ej: Urea, Purina)', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: TextField(controller: _stockCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Cantidad Inicial', border: OutlineInputBorder()))),
              const SizedBox(width: 12),
              Expanded(child: DropdownButtonFormField<String>(
                value: _unidad,
                items: ['Bultos', 'Kilos', 'Litros', 'Unidades'].map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                onChanged: (v) => setState(() => _unidad = v!),
                decoration: const InputDecoration(labelText: 'Unidad', border: OutlineInputBorder()),
              )),
            ],
          ),
          const SizedBox(height: 16),
          TextField(controller: _umbralCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Avisar cuando quede menos de:', border: OutlineInputBorder())),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_nombreCtrl.text.isNotEmpty && _stockCtrl.text.isNotEmpty) {
                ref.read(insumosNotifierProvider.notifier).registrarInsumo(
                  nombre: _nombreCtrl.text,
                  unidad: _unidad,
                  stockInicial: double.parse(_stockCtrl.text),
                  umbral: double.parse(_umbralCtrl.text),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('GUARDAR EN BODEGA'),
          ),
        ],
      ),
    );
  }
}
