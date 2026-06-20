import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/pecuario_notifier.dart';
import '../domain/entidades_pecuario.dart';

/// Pantalla principal del módulo pecuario.
class PantallaPanelPecuario extends ConsumerWidget {
  const PantallaPanelPecuario({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoEspecies = ref.watch(pecuarioNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Animales', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: estadoEspecies.when(
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 4.0)),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (especies) {
          final totalAnimales = especies.fold(0, (sum, item) => sum + item.cantidadActual);

          return Column(
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
                      const Text('TOTAL DE ANIMALES', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w900, color: Colors.white70)),
                      const SizedBox(height: 8.0),
                      Text('$totalAnimales', style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.w900, color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: especies.isEmpty
                    ? const _VistaVaciaPecuario()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 80.0),
                        itemCount: especies.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return RepaintBoundary(
                            child: _TarjetaAnimal(especie: especies[index]),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormularioNuevaEspecie(context, ref),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        label: const Text('Nuevo Grupo', style: TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add_circle_outline),
      ),
    );
  }

  void _mostrarFormularioNuevaEspecie(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(context: context, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28.0))), builder: (context) => const _FormularioEspecieModal());
  }
}

class _TarjetaAnimal extends StatelessWidget {
  final EspecieEntity especie;
  const _TarjetaAnimal({required this.especie});

  @override
  Widget build(BuildContext context) {
    IconData icono;
    Color color;

    switch (especie.tipoEspecie) {
      case 'Cerdo': icono = Icons.savings; color = Colors.pink; break;
      case 'Gallina':
      case 'Pollo': icono = Icons.egg; color = Colors.orange; break;
      case 'Pez': icono = Icons.set_meal; color = Colors.blue; break;
      default: icono = Icons.pets; color = Colors.brown;
    }

    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: () => context.push('/dashboard/animales/detalle/${especie.id}'),
        borderRadius: BorderRadius.circular(20.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(radius: 32, backgroundColor: color.withOpacity(0.1), child: Icon(icono, color: color, size: 32)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(especie.nombre, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('${especie.cantidadActual} ${especie.tipoEspecie}', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _VistaVaciaPecuario extends StatelessWidget {
  const _VistaVaciaPecuario();
  @override
  Widget build(BuildContext context) { return const Center(child: Text('Sin animales registrados')); }
}

class _FormularioEspecieModal extends ConsumerStatefulWidget {
  const _FormularioEspecieModal();
  @override
  ConsumerState<_FormularioEspecieModal> createState() => _FormularioEspecieModalState();
}

class _FormularioEspecieModalState extends ConsumerState<_FormularioEspecieModal> {
  final _nombreCtrl = TextEditingController();
  final _cantCtrl = TextEditingController();
  String _tipo = 'Cerdo';
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + padding), child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre')),
      TextField(controller: _cantCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Cantidad')),
      ElevatedButton(onPressed: () { ref.read(pecuarioNotifierProvider.notifier).agregarEspecie(nombre: _nombreCtrl.text, tipoEspecie: _tipo, cantidadActual: int.parse(_cantCtrl.text)); Navigator.pop(context); }, child: const Text('GUARDAR'))
    ]));
  }
}
