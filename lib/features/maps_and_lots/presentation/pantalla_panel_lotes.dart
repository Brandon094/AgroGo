import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/panel_lotes_notifier.dart';
import '../domain/lote_model.dart';
import '../../field_workers/presentation/providers/gestion_administrativa_orchestrator.dart';

class PantallaPanelLotes extends ConsumerWidget {
  const PantallaPanelLotes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoLotes = ref.watch(panelLotesNotifierProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF9FBF9), Colors.white],
            ),
          ),
          child: Column(
            children: [
              // HEADER CON TABS
              Container(
                padding: const EdgeInsets.fromLTRB(24, 70, 24, 16),
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
                          'Mis Zonas',
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
                    const SizedBox(height: 24),
                    const TabBar(
                      labelColor: Color(0xFF00695C),
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Color(0xFF00695C),
                      indicatorWeight: 4,
                      indicatorSize: TabBarIndicatorSize.label,
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(text: 'CULTIVOS'),
                        Tab(text: 'ESTRUCTURAS'),
                      ],
                    ),
                  ],
                ),
              ),

              // CONTENIDO DE TABS
              Expanded(
                child: TabBarView(
                  children: [
                    _ListaLotesFiltrada(
                      usoFiltro: const [TipoUsoLote.agricola, TipoUsoLote.pecuario, TipoUsoLote.forestal],
                      mensajeVacio: 'No hay lotes de cultivo dibujados',
                    ),
                    _ListaLotesFiltrada(
                      usoFiltro: const [TipoUsoLote.infraestructura, TipoUsoLote.perimetro],
                      mensajeVacio: 'No hay infraestructuras registradas',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: estadoLotes.maybeWhen(
        data: (lotes) {
          final tienePerimetro = lotes.any((l) => l.uso == TipoUsoLote.perimetro);
          
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (tienePerimetro) ...[
                FloatingActionButton.extended(
                  heroTag: 'add_infra',
                  onPressed: () => context.push('/lotes/nuevo-lote?tipo=infraestructura'),
                  backgroundColor: Colors.blueGrey.shade700,
                  foregroundColor: Colors.white,
                  label: const Text('INFRAESTRUCTURA', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                  icon: const Icon(Icons.factory_rounded, size: 20),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  heroTag: 'add_lote',
                  onPressed: () => context.push('/lotes/nuevo-lote?tipo=agricola'),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  label: const Text('DIBUJAR CULTIVO', style: TextStyle(fontWeight: FontWeight.w900)),
                  icon: const Icon(Icons.add_location_alt_rounded),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton.small(
                      heroTag: 'add_forestal',
                      onPressed: () => context.push('/lotes/nuevo-lote?tipo=forestal'),
                      backgroundColor: const Color(0xFF1B5E20),
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.park_rounded),
                    ),
                    const SizedBox(width: 12),
                    FloatingActionButton.small(
                      heroTag: 'add_ornamental',
                      onPressed: () => context.push('/lotes/nuevo-lote?tipo=ornamental'),
                      backgroundColor: Colors.deepOrange.shade300,
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.local_florist_rounded),
                    ),
                  ],
                ),
              ] else ...[
                FloatingActionButton.extended(
                  heroTag: 'add_perimetro',
                  onPressed: () => context.push('/lotes/nuevo-lote?tipo=perimetro'),
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  label: const Text('DIBUJAR PERÍMETRO', style: TextStyle(fontWeight: FontWeight.w900)),
                  icon: const Icon(Icons.architecture_rounded),
                ),
              ],
            ],
          );
        },
        orElse: () => const SizedBox.shrink(),
      ),
    ));
  }
}

class _ListaLotesFiltrada extends ConsumerWidget {
  final List<TipoUsoLote> usoFiltro;
  final String mensajeVacio;

  const _ListaLotesFiltrada({required this.usoFiltro, required this.mensajeVacio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoLotes = ref.watch(panelLotesNotifierProvider);

    return estadoLotes.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (lotes) {
        final filtrados = lotes.where((l) => usoFiltro.contains(l.uso)).toList();

        if (filtrados.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map_outlined, size: 80, color: Colors.grey.withOpacity(0.5)),
                const SizedBox(height: 16),
                Text(
                  mensajeVacio,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
          physics: const BouncingScrollPhysics(),
          itemCount: filtrados.length,
          itemBuilder: (context, index) => RepaintBoundary(
            child: _TarjetaLote(lote: filtrados[index]),
          ),
        );
      },
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

    if (lote.uso == TipoUsoLote.infraestructura) {
      final pecuarias = ['Cochera', 'Galpón', 'Estanque', 'Corral', 'Potrero'];
      final recreativas = ['Kiosco/Área Social', 'Piscina/Área Húmeda', 'Alojamiento/Casa en Árbol', 'Mirador/Observatorio'];

      if (pecuarias.contains(lote.subCategoria)) {
        iconoUso = Icons.pets_rounded;
        colorUso = Colors.orange;
      } else if (recreativas.contains(lote.subCategoria)) {
        iconoUso = Icons.celebration_rounded;
        colorUso = Colors.lightBlueAccent;
      } else {
        iconoUso = Icons.business_rounded;
        colorUso = Colors.purple;
      }
    } else {
      switch (lote.uso) {
        case TipoUsoLote.agricola: iconoUso = Icons.eco_rounded; colorUso = Colors.green; break;
        case TipoUsoLote.pecuario: iconoUso = Icons.pets_rounded; colorUso = Colors.orange; break;
        case TipoUsoLote.forestal: iconoUso = Icons.park_rounded; colorUso = const Color(0xFF1B5E20); break;
        case TipoUsoLote.ornamental: iconoUso = Icons.local_florist_rounded; colorUso = Colors.deepOrange.shade300; break;
        case TipoUsoLote.infraestructura: iconoUso = Icons.business_rounded; colorUso = Colors.purple; break; // No debería entrar aquí por el if de arriba
        case TipoUsoLote.perimetro: iconoUso = Icons.architecture_rounded; colorUso = Colors.brown; break;
      }
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
                    if (lote.uso == TipoUsoLote.agricola)
                      FutureBuilder<Map<int, double>>(
                        future: ref.read(gestionAdministrativaOrchestratorProvider.notifier).obtenerProductividadPorLote(),
                        builder: (context, snapshot) {
                          final kilos = snapshot.data?[int.tryParse(lote.id) ?? -1] ?? 0;
                          if (kilos == 0) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              children: [
                                const Icon(Icons.rebase_edit, size: 12, color: Colors.orange),
                                Text(' $kilos kg recolectados', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.orange)),
                              ],
                            ),
                          );
                        },
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
    final esPerimetro = lote.uso == TipoUsoLote.perimetro;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: esPerimetro ? Colors.red : Colors.orange),
            const SizedBox(width: 12),
            Text(esPerimetro ? '¡ADVERTENCIA CRÍTICA!' : '¿Eliminar zona?', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('¿Desea eliminar "${lote.nombre}"?'),
            if (esPerimetro) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red.shade200)),
                child: const Text(
                  'ATENCIÓN: Si elimina el Perímetro Maestro, se borrarán AUTOMÁTICAMENTE todos los lotes de cultivo e infraestructuras de esta finca.',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ] else 
              const Text('Esto borrará el polígono y las tareas asociadas.', style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          TextButton(
            onPressed: () async {
              if (esPerimetro) {
                await ref.read(panelLotesNotifierProvider.notifier).eliminarTodoElMapa();
              } else {
                await ref.read(panelLotesNotifierProvider.notifier).eliminarLote(lote.id);
              }
              if (context.mounted) Navigator.pop(context);
            },
            child: Text(
              esPerimetro ? 'BORRAR TODO' : 'ELIMINAR', 
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
            ),
          ),
        ],
      ),
    );
  }
}
