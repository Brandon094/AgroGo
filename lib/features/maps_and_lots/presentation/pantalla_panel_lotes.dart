import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/panel_lotes_notifier.dart';
import '../domain/lote_model.dart';

/// Pantalla del panel de control principal de lotes.
/// Muestra un listado de los lotes de la finca y permite iniciar la creación de uno nuevo.
class PantallaPanelLotes extends ConsumerWidget {
  const PantallaPanelLotes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoLotes = ref.watch(panelLotesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Lotes - AgroGo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 28.0),
            tooltip: 'Recargar listado',
            onPressed: () => ref.read(panelLotesNotifierProvider.notifier).refresh(),
          ),
        ],
      ),
      body: estadoLotes.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            strokeWidth: 4.0,
          ),
        ),
        error: (error, pilaExcepcion) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 64.0),
                const SizedBox(height: 16.0),
                Text(
                  'Ocurrió un error al cargar tus lotes:\n${error.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton.icon(
                  onPressed: () => ref.read(panelLotesNotifierProvider.notifier).refresh(),
                  icon: const Icon(Icons.replay),
                  label: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
        data: (lotes) {
          if (lotes.isEmpty) {
            return _VistaVaciaLotes(onNuevo: () => context.push('/lotes/nuevo-lote'));
          }

          final areaTotal = lotes.fold(0.0, (sum, item) => sum + item.areaEnHectareas);
          final totalMatas = lotes.fold(0, (sum, item) => sum + item.numeroMatas);

          return Column(
            children: [
              // Resumen de la Finca con Gradiente
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
                child: Row(
                  children: [
                    Expanded(
                      child: _DatoResumen(
                        titulo: 'ÁREA TOTAL',
                        valor: '${areaTotal.toStringAsFixed(2)} Ha',
                        icono: Icons.straighten,
                      ),
                    ),
                    Container(width: 1, height: 40, color: Colors.white24),
                    Expanded(
                      child: _DatoResumen(
                        titulo: 'TOTAL MATAS',
                        valor: totalMatas.toString(),
                        icono: Icons.grid_view,
                      ),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 80.0),
                  itemCount: lotes.length,
                  itemBuilder: (context, indice) {
                    final lote = lotes[indice];
                    return _TarjetaLote(lote: lote);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/lotes/nuevo-lote'),
        icon: const Icon(Icons.add_location_alt_outlined, size: 28.0),
        label: const Text(
          'Nuevo Lote',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _DatoResumen extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;

  const _DatoResumen({
    required this.titulo,
    required this.valor,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icono, color: Colors.white70, size: 24),
        const SizedBox(height: 4),
        Text(
          valor,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _TarjetaLote extends StatelessWidget {
  final Lote lote;

  const _TarjetaLote({required this.lote});

  @override
  Widget build(BuildContext context) {
    IconData iconoUso;
    Color colorUso;

    switch (lote.uso) {
      case TipoUsoLote.agricola:
        iconoUso = Icons.eco;
        colorUso = Colors.green;
        break;
      case TipoUsoLote.pecuario:
        iconoUso = Icons.pets;
        colorUso = Colors.orange;
        break;
      case TipoUsoLote.forestal:
        iconoUso = Icons.forest;
        colorUso = Colors.teal;
        break;
      case TipoUsoLote.infraestructura:
        iconoUso = Icons.business;
        colorUso = Colors.grey;
        break;
    }

    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Avatar con inicial o ícono
            CircleAvatar(
              radius: 28,
              backgroundColor: colorUso.withOpacity(0.1),
              child: Icon(iconoUso, color: colorUso, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lote.nombre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        lote.subCategoria,
                        style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.bold),
                      ),
                      if (lote.uso == TipoUsoLote.agricola) ...[
                        const SizedBox(width: 12),
                        const Icon(Icons.pin_drop, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          '${lote.numeroMatas} matas',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                      if (lote.uso == TipoUsoLote.pecuario && lote.capacidadAnimales != null) ...[
                        const SizedBox(width: 12),
                        const Icon(Icons.group, size: 16, color: Colors.blue),
                        const SizedBox(width: 4),
                        Text(
                          'Cap. ${lote.capacidadAnimales}',
                          style: TextStyle(color: Colors.grey.shade700),
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
                Text(
                  '${lote.areaEnHectareas.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: colorUso,
                  ),
                ),
                const Text(
                  'Ha',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _VistaVaciaLotes extends StatelessWidget {
  final VoidCallback onNuevo;

  const _VistaVaciaLotes({required this.onNuevo});

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
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.map_outlined,
                size: 80.0,
                color: Colors.green.shade800,
              ),
            ),
            const SizedBox(height: 32.0),
            const Text(
              '¡Comienza a mapear!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Dibuja tus lotes en el mapa para calcular hectáreas y proyectar tus insumos automáticamente.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton.icon(
              onPressed: onNuevo,
              icon: const Icon(Icons.add_location_alt),
              label: const Text('Crear Mi Primer Lote'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
