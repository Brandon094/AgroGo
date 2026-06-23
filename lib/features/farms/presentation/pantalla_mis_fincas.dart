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
      backgroundColor: const Color(0xFFF9FBF9),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(32, 90, 32, 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF00695C), Color(0xFF2E7D32)],
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Bienvenido a', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w500)),
                  const Text('AgroGo', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w900, letterSpacing: -1)),
                  const SizedBox(height: 12),
                  const Text('Seleccione una propiedad para administrar su producción.', style: TextStyle(color: Colors.white60, fontSize: 16)),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () => context.push('/mapa-global'),
                    icon: const Icon(Icons.map_rounded),
                    label: const Text('VISOR GLOBAL'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white12,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 56),
                      side: const BorderSide(color: Colors.white30),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.house_siding_rounded, size: 80, color: Colors.grey.withOpacity(0.5)),
                          const SizedBox(height: 16),
                          const Text(
                            'No tiene fincas registradas',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Presione el botón + para empezar su primer proyecto.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final finca = fincas[index];
                      return _TarjetaFincaPremium(
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormFinca(context),
        label: const Text('NUEVA FINCA', style: TextStyle(fontWeight: FontWeight.w900)),
        icon: const Icon(Icons.add_business_rounded),
        backgroundColor: const Color(0xFF00695C),
        foregroundColor: Colors.white,
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

class _TarjetaFincaPremium extends StatelessWidget {
  final FincaEntity finca;
  final VoidCallback onTap;
  const _TarjetaFincaPremium({required this.finca, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFF00695C).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.home_work_rounded, color: Color(0xFF00695C), size: 32),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(finca.nombre, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
                      const SizedBox(height: 4),
                      Text(finca.veredaUbicacion ?? 'Ubicación no definida', style: TextStyle(color: Colors.grey.shade600, fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 18),
              ],
            ),
          ),
        ),
      ),
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
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Nueva Finca', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
          const SizedBox(height: 24),
          TextField(
            controller: _nombreCtrl,
            decoration: const InputDecoration(labelText: 'Nombre de la Finca', prefixIcon: Icon(Icons.business_rounded)),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _veredaCtrl,
            decoration: const InputDecoration(labelText: 'Vereda / Ubicación', prefixIcon: Icon(Icons.location_on_rounded)),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () async {
              if (_nombreCtrl.text.isNotEmpty) {
                await ref.read(fincasNotifierProvider.notifier).agregarFinca(
                  nombre: _nombreCtrl.text, 
                  vereda: _veredaCtrl.text
                );
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('¡Finca guardada con éxito!'),
                      backgroundColor: Color(0xFF00695C),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
            child: const Text('GUARDAR PROPIEDAD'),
          ),
        ],
      ),
    );
  }
}
