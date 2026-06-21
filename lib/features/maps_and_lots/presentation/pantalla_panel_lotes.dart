import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/panel_lotes_notifier.dart';
import '../domain/lote_model.dart';

class PantallaPanelLotes extends ConsumerWidget {
  const PantallaPanelLotes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoLotes = ref.watch(panelLotesNotifierProvider);

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
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 70, 24, 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mis Lotes',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF37474F)),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.map_rounded, color: Colors.green),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    estadoLotes.maybeWhen(
                      data: (lotes) {
                        final areaTotal = lotes.fold<double>(0.0, (a, b) => a + b.areaEnHectareas);
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
                                'Área Total',
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${areaTotal.toStringAsFixed(1)} Ha',
                                style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
            estadoLotes.when(
              loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
              error: (error, stack) => SliverFillRemaining(child: Center(child: Text('Error: $error'))),
              data: (lotes) {
                if (lotes.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map_outlined, size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('No hay lotes dibujados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                        ],
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => RepaintBoundary(
                        child: _TarjetaLote(lote: lotes[index]),
                      ),
                      childCount: lotes.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/lotes/nuevo-lote'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        label: const Text('DIBUJAR LOTE', style: TextStyle(fontWeight: FontWeight.w900)),
        icon: const Icon(Icons.add_location_alt_rounded),
      ),
    );
  }
}

class _TarjetaLote extends ConsumerWidget {
  final Lote lote;
  const _TarjetaLote({required this.lote});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    IconData iconoUso;
    Color colorUso;

    switch (lote.uso) {
      case TipoUsoLote.agricola: iconoUso = Icons.eco_rounded; colorUso = Colors.green; break;
      case TipoUsoLote.pecuario: iconoUso = Icons.pets_rounded; colorUso = Colors.orange; break;
      case TipoUsoLote.forestal: iconoUso = Icons.forest_rounded; colorUso = Colors.teal; break;
      case TipoUsoLote.infraestructura: iconoUso = Icons.business_rounded; colorUso = Colors.grey; break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: colorUso.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
              child: Icon(iconoUso, color: colorUso, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lote.nombre, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
                  Row(
                    children: [
                      Text(lote.subCategoria, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 13)),
                      if (lote.etapaCultivo != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(6)),
                          child: Text(lote.etapaCultivo!, style: TextStyle(color: Colors.green.shade800, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${lote.areaEnHectareas.toStringAsFixed(2)} Ha', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: colorUso)),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 22),
                  onPressed: () => _confirmarEliminacion(context, ref, lote),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref, Lote lote) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar lote?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('¿Desea eliminar el lote "${lote.nombre}"? Esto no se puede deshacer.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          TextButton(
            onPressed: () async {
              await ref.read(panelLotesNotifierProvider.notifier).eliminarLote(lote.id);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('ELIMINAR', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
