import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'providers/fincas_resumen_provider.dart';
import 'providers/lotes_globales_provider.dart';
import '../domain/lote_model.dart';
import '../../farms/presentation/providers/fincas_notifier.dart';
import '../../livestock/presentation/providers/pecuario_notifier.dart';
import '../../inventory_management/presentation/providers/insumos_notifier.dart';

class PantallaMapaGlobal extends ConsumerStatefulWidget {
  const PantallaMapaGlobal({super.key});

  @override
  ConsumerState<PantallaMapaGlobal> createState() => _PantallaMapaGlobalState();
}

class _PantallaMapaGlobalState extends ConsumerState<PantallaMapaGlobal> {
  GoogleMapController? _mapController;
  String? _fincaSeleccionadaId;

  void _ajustarCamaraAResumenes(List<FincaResumenGeografico> resumenes) {
    if (resumenes.isEmpty || _mapController == null) return;

    double minLat = resumenes.first.centroide.latitude;
    double maxLat = resumenes.first.centroide.latitude;
    double minLng = resumenes.first.centroide.longitude;
    double maxLng = resumenes.first.centroide.longitude;

    for (final r in resumenes) {
      if (r.centroide.latitude < minLat) minLat = r.centroide.latitude;
      if (r.centroide.latitude > maxLat) maxLat = r.centroide.latitude;
      if (r.centroide.longitude < minLng) minLng = r.centroide.longitude;
      if (r.centroide.longitude > maxLng) maxLng = r.centroide.longitude;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 120));
  }

  Color _obtenerColorLote(Lote lote) {
    if (lote.uso == TipoUsoLote.infraestructura) {
      final pecuarias = ['Cochera', 'Galpón', 'Estanque', 'Corral', 'Potrero'];
      final recreativas = ['Kiosco/Área Social', 'Piscina/Área Húmeda', 'Alojamiento/Casa en Árbol', 'Mirador/Observatorio'];

      if (pecuarias.contains(lote.subCategoria)) return Colors.orange;
      if (recreativas.contains(lote.subCategoria)) return Colors.lightBlueAccent;
      return Colors.purple;
    }
    switch (lote.uso) {
      case TipoUsoLote.agricola: return Colors.green;
      case TipoUsoLote.pecuario: return Colors.orange;
      case TipoUsoLote.forestal: return Colors.teal;
      case TipoUsoLote.perimetro: return Colors.brown;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final resumenesAsync = ref.watch(fincasResumenProvider);
    final lotesAsync = ref.watch(lotesGlobalesProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Portafolio de Fincas',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: resumenesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (resumenes) {
          final Set<Marker> marcadores = resumenes.map((finca) {
            return Marker(
              markerId: MarkerId('finca_${finca.fincaId}'),
              position: finca.centroide,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
              onTap: () {
                setState(() => _fincaSeleccionadaId = finca.fincaId);
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(finca.centroide, 15.5),
                );
                _mostrarPanelResumen(finca);
              },
            );
          }).toSet();

          // Polígonos solo para la finca seleccionada (Semantic Zoom)
          final Set<Polygon> poligonos = lotesAsync.maybeWhen(
            data: (lotes) {
              if (_fincaSeleccionadaId == null) return <Polygon>{};
              return lotes
                  .where((l) => l.fincaId == _fincaSeleccionadaId)
                  .map((lote) {
                final color = _obtenerColorLote(lote);
                return Polygon(
                  polygonId: PolygonId('poly_${lote.id}'),
                  points: lote.coordenadas.map((c) => LatLng(c.latitud, c.longitud)).toList(),
                  fillColor: color.withValues(alpha: 0.4),
                  strokeColor: color,
                  strokeWidth: 2,
                  consumeTapEvents: false,
                );
              }).toSet();
            },
            orElse: () => <Polygon>{},
          );

          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(4.9816, -75.6033),
              zoom: 10,
            ),
            mapType: MapType.hybrid,
            markers: marcadores,
            polygons: poligonos,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: (controller) {
              _mapController = controller;
              if (resumenes.isNotEmpty) {
                _ajustarCamaraAResumenes(resumenes);
              }
            },
            onTap: (_) => setState(() => _fincaSeleccionadaId = null),
          );
        },
      ),
    );
  }

  void _mostrarPanelResumen(FincaResumenGeografico finca) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      builder: (context) => _PanelResumenFinca(
        finca: finca,
        onAdministrar: () => _entrarAFinca(finca),
      ),
    );
  }

  void _entrarAFinca(FincaResumenGeografico finca) {
    ref.read(fincaSeleccionadaProvider.notifier).seleccionar(finca.fincaId);
    context.go('/dashboard');
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String valor;
  final IconData icono;
  final Color color;

  const _MiniStat({required this.label, required this.valor, required this.icono, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icono, color: color, size: 20),
        ),
        const SizedBox(height: 6),
        Text(valor, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _PanelResumenFinca extends ConsumerWidget {
  final FincaResumenGeografico finca;
  final VoidCallback onAdministrar;

  const _PanelResumenFinca({required this.finca, required this.onAdministrar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lotesAsync = ref.watch(lotesGlobalesProvider);
    final animalesAsync = ref.watch(pecuarioNotifierProvider);
    final insumosAsync = ref.watch(insumosNotifierProvider);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.agriculture, color: Color(0xFF1B5E20), size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(finca.nombre, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                    Text('${finca.cantidadLotes} Zonas registradas', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // RESUMEN TÉCNICO (NUEVO)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MiniStat(
                label: 'Animales', 
                valor: animalesAsync.maybeWhen(
                  data: (a) => a.where((x) => x.loteId != null).fold(0, (sum, x) => sum + x.cantidadActual).toString(),
                  orElse: () => '...',
                ),
                icono: Icons.pets_rounded,
                color: Colors.purple,
              ),
              _MiniStat(
                label: 'Bodega', 
                valor: insumosAsync.maybeWhen(
                  data: (i) => i.length.toString(),
                  orElse: () => '...',
                ),
                icono: Icons.inventory_2_rounded,
                color: Colors.indigo,
              ),
              _MiniStat(
                label: 'Tierra', 
                valor: '${finca.areaTotal.toStringAsFixed(1)}Ha',
                icono: Icons.landscape_rounded,
                color: Colors.green,
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Text('DISTRIBUCIÓN DE TIERRA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.grey)),
          const SizedBox(height: 12),
          lotesAsync.maybeWhen(
            data: (lotes) {
              final lotesFinca = lotes.where((l) => l.fincaId == finca.fincaId).toList();
              final Map<TipoUsoLote, double> areas = {};
              for (var l in lotesFinca) {
                areas[l.uso] = (areas[l.uso] ?? 0.0) + l.areaEnHectareas;
              }

              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: areas.entries.map((e) {
                  return Chip(
                    label: Text('${e.key.name.toUpperCase()}: ${e.area.toStringAsFixed(1)} Ha'),
                    backgroundColor: _getColorUso(e.key).withOpacity(0.1),
                    side: BorderSide(color: _getColorUso(e.key).withOpacity(0.5)),
                    labelStyle: TextStyle(color: _getColorUso(e.key), fontWeight: FontWeight.bold, fontSize: 12),
                  );
                }).toList(),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onAdministrar();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B5E20),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 64),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('ADMINISTRAR ESTA FINCA', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
          ),
        ],
      ),
    );
  }

  Color _getColorUso(TipoUsoLote uso) {
    switch (uso) {
      case TipoUsoLote.agricola: return Colors.green.shade800;
      case TipoUsoLote.pecuario: return Colors.orange.shade800;
      case TipoUsoLote.forestal: return const Color(0xFF1B5E20);
      case TipoUsoLote.ornamental: return Colors.deepOrange.shade300;
      case TipoUsoLote.infraestructura: return Colors.blueGrey;
      case TipoUsoLote.perimetro: return Colors.brown;
    }
  }
}

extension on MapEntry<TipoUsoLote, double> {
  double get area => value;
}
