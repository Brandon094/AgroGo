import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/pecuario_notifier.dart';
import '../domain/entidades_pecuario.dart';

/// Pantalla principal del módulo pecuario.
/// Permite gestionar las especies animales de la finca con una interfaz de alta visibilidad.
class PantallaPanelPecuario extends ConsumerWidget {
  const PantallaPanelPecuario({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoEspecies = ref.watch(pecuarioNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Animales',
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 28.0),
            tooltip: 'Actualizar lista',
            onPressed: () => ref.read(pecuarioNotifierProvider.notifier).refresh(),
          ),
        ],
      ),
      body: estadoEspecies.when(
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 4.0)),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 80.0),
                const SizedBox(height: 16.0),
                Text(
                  'Error al cargar animales:\n$error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () => ref.read(pecuarioNotifierProvider.notifier).refresh(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
        data: (especies) {
          final totalAnimales = especies.fold(0, (sum, item) => sum + item.cantidadActual);

          return Column(
            children: [
              // Header con Gradiente y Resumen Pecuario
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'TOTAL DE ANIMALES',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white70,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '$totalAnimales',
                      style: const TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Distribuidos en ${especies.length} grupos',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: especies.isEmpty
                    ? const _VistaVaciaPecuario()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 80.0),
                        itemCount: especies.length,
                        itemBuilder: (context, index) {
                          final especie = especies[index];
                          return _TarjetaAnimal(especie: especie);
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
        label: const Text(
          'Nuevo Grupo',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add_circle_outline, size: 28.0),
      ),
    );
  }

  void _mostrarFormularioNuevaEspecie(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
      builder: (context) => const _FormularioEspecieModal(),
    );
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
      case 'Cerdo':
        icono = Icons.savings;
        color = Colors.pink;
        break;
      case 'Gallina':
      case 'Pollo':
        icono = Icons.egg;
        color = Colors.orange;
        break;
      case 'Pez':
        icono = Icons.set_meal;
        color = Colors.blue;
        break;
      default:
        icono = Icons.pets;
        color = Colors.brown;
    }

    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        onTap: () => context.push('/animales/detalle/${especie.id}'),
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icono, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      especie.nombre,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          especie.tipoEspecie,
                          style: TextStyle(
                            color: color.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.numbers, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${especie.cantidadActual} cabezas',
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
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
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.pets_outlined,
                size: 80.0,
                color: Colors.orange.shade800,
              ),
            ),
            const SizedBox(height: 32.0),
            const Text(
              'Aún no hay animales',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Registra tus marraneras, galpones o estanques para llevar el control sanitario y de alimentación.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormularioEspecieModal extends ConsumerStatefulWidget {
  const _FormularioEspecieModal();

  @override
  ConsumerState<_FormularioEspecieModal> createState() => _FormularioEspecieModalState();
}

class _FormularioEspecieModalState extends ConsumerState<_FormularioEspecieModal> {
  final _formularioKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _cantidadCtrl = TextEditingController();
  String _tipoSeleccionado = 'Cerdo';

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _cantidadCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paddingTeclado = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 24 + paddingTeclado),
      child: Form(
        key: _formularioKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Nuevo Grupo Animal',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nombreCtrl,
              decoration: const InputDecoration(
                labelText: '¿Cómo se llama el grupo?',
                hintText: 'Ej: Galpón Norte, Estanque 2',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.drive_file_rename_outline),
              ),
              validator: (v) => v!.isEmpty ? 'Ingresa un nombre' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _tipoSeleccionado,
              decoration: const InputDecoration(
                labelText: 'Tipo de Animal',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: ['Cerdo', 'Gallina', 'Pollo', 'Pez']
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _tipoSeleccionado = v!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cantidadCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '¿Cuántos animales hay?',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              validator: (v) => v!.isEmpty ? 'Ingresa la cantidad' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formularioKey.currentState!.validate()) {
                  ref.read(pecuarioNotifierProvider.notifier).agregarEspecie(
                        nombre: _nombreCtrl.text.trim(),
                        tipoEspecie: _tipoSeleccionado,
                        cantidadActual: int.tryParse(_cantidadCtrl.text) ?? 0,
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text('GUARDAR GRUPO ANIMAL'),
            ),
          ],
        ),
      ),
    );
  }
}
