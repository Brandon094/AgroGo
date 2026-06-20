import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/fincas_notifier.dart';
import '../domain/finca_model.dart';

class PantallaMisFincas extends ConsumerWidget {
  const PantallaMisFincas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fincasAsync = ref.watch(fincasNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Bienvenido a', style: TextStyle(color: Colors.white70, fontSize: 18)),
                  const Text('AgroGo', style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  const Text('Selecciona una finca para empezar', style: TextStyle(color: Colors.white60, fontSize: 16)),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => context.push('/mapa-global'),
                    icon: const Icon(Icons.map_outlined),
                    label: const Text('MAPA GLOBAL DE PROPIEDADES'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 50),
                      side: const BorderSide(color: Colors.white38),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: fincasAsync.when(
              data: (fincas) {
                if (fincas.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: _VistaVaciaFincas(onCrear: () => _mostrarFormFinca(context)),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final finca = fincas[index];
                      return _TarjetaFinca(
                        finca: finca,
                        onTap: () {
                          ref.read(fincaSeleccionadaProvider.notifier).seleccionar(finca.id);
                          context.go('/dashboard');
                        },
                      );
                    },
                    childCount: fincas.length,
                  ),
                );
              },
              loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
              error: (e, _) => SliverFillRemaining(child: Center(child: Text('Error: $e'))),
            ),
          ),
        ],
      ),
      floatingActionButton: fincasAsync.maybeWhen(
        data: (l) => l.isNotEmpty ? FloatingActionButton.extended(
          onPressed: () => _mostrarFormFinca(context),
          label: const Text('Nueva Finca'),
          icon: const Icon(Icons.add),
          backgroundColor: const Color(0xFF1B5E20),
        ) : null,
        orElse: () => null,
      ),
    );
  }

  void _mostrarFormFinca(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => const _FormFincaModal(),
    );
  }
}

class _TarjetaFinca extends StatelessWidget {
  final FincaEntity finca;
  final VoidCallback onTap;
  const _TarjetaFinca({required this.finca, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.agriculture, color: Color(0xFF1B5E20), size: 32),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(finca.nombre, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(finca.veredaUbicacion ?? 'Ubicación no definida', style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _VistaVaciaFincas extends StatelessWidget {
  final VoidCallback onCrear;
  const _VistaVaciaFincas({required this.onCrear});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.landscape_outlined, size: 100, color: Colors.grey),
        const SizedBox(height: 24),
        const Text('No tienes fincas registradas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const Text('Registra tu primera finca para empezar a gestionar lotes, gastos y tareas.', 
          textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: onCrear,
          style: ElevatedButton.styleFrom(minimumSize: const Size(250, 60)),
          child: const Text('CREAR MI PRIMERA FINCA'),
        ),
      ],
    );
  }
}

class _FormFincaModal extends ConsumerStatefulWidget {
  const _FormFincaModal();
  @override
  ConsumerState<_FormFincaModal> createState() => _FormFincaModalState();
}

class _FormFincaModalState extends ConsumerState<_FormFincaModal> {
  final _nombreCtrl = TextEditingController();
  final _veredaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 32, 24, 32 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Nueva Finca', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          TextField(
            controller: _nombreCtrl,
            decoration: const InputDecoration(labelText: 'Nombre de la Finca', border: OutlineInputBorder(), prefixIcon: Icon(Icons.home)),
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _veredaCtrl,
            decoration: const InputDecoration(labelText: 'Vereda / Ubicación', border: OutlineInputBorder(), prefixIcon: Icon(Icons.location_on)),
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (_nombreCtrl.text.isNotEmpty) {
                ref.read(fincasNotifierProvider.notifier).agregarFinca(
                  nombre: _nombreCtrl.text,
                  vereda: _veredaCtrl.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('GUARDAR FINCA'),
          ),
        ],
      ),
    );
  }
}
