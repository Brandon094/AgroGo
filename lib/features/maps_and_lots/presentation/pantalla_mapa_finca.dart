import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'providers/panel_lotes_notifier.dart';
import '../domain/lote_model.dart';
import '../../livestock/presentation/providers/pecuario_notifier.dart';
import '../../inventory_management/presentation/providers/beneficio_notifier.dart';
import '../../inventory_management/domain/beneficio_model.dart';

class PantallaMapaFinca extends ConsumerStatefulWidget {
  const PantallaMapaFinca({super.key});

  @override
  ConsumerState<PantallaMapaFinca> createState() => _PantallaMapaFincaState();
}

class _PantallaMapaFincaState extends ConsumerState<PantallaMapaFinca> {
  GoogleMapController? _mapController;
  MapType _tipoMapa = MapType.hybrid;

  void _ajustarCamaraALotes(List<Lote> lotes) {
    if (lotes.isEmpty || _mapController == null) return;
    double? minLat, maxLat, minLng, maxLong;
    for (final lote in lotes) {
      for (final punto in lote.coordenadas) {
        if (minLat == null || punto.latitud < minLat) minLat = punto.latitud;
        if (maxLat == null || punto.latitud > maxLat) maxLat = punto.latitud;
        if (minLng == null || punto.longitud < minLng) minLng = punto.longitud;
        if (maxLong == null || punto.longitud > maxLong) maxLong = punto.longitud;
      }
    }
    if (minLat != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(LatLngBounds(southwest: LatLng(minLat, minLng!), northeast: LatLng(maxLat!, maxLong!)), 80));
    }
  }

  LatLng _obtenerCentroLote(List<CoordenadaLote> coordenadas) {
    double sLat = 0, sLng = 0;
    for (final c in coordenadas) { sLat += c.latitud; sLng += c.longitud; }
    return LatLng(sLat / coordenadas.length, sLng / coordenadas.length);
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
      case TipoUsoLote.forestal: return const Color(0xFF1B5E20);
      case TipoUsoLote.ornamental: return Colors.deepOrange.shade300;
      case TipoUsoLote.perimetro: return Colors.brown;
      default: return Colors.grey;
    }
  }

  double _obtenerHueLote(Lote lote) {
    if (lote.uso == TipoUsoLote.infraestructura) {
      final pecuarias = ['Cochera', 'Galpón', 'Estanque', 'Corral', 'Potrero'];
      final recreativas = ['Kiosco/Área Social', 'Piscina/Área Húmeda', 'Alojamiento/Casa en Árbol', 'Mirador/Observatorio'];

      if (pecuarias.contains(lote.subCategoria)) return BitmapDescriptor.hueOrange;
      if (recreativas.contains(lote.subCategoria)) return BitmapDescriptor.hueAzure;
      return BitmapDescriptor.hueViolet;
    }
    switch (lote.uso) {
      case TipoUsoLote.agricola: return BitmapDescriptor.hueGreen;
      case TipoUsoLote.pecuario: return BitmapDescriptor.hueOrange;
      case TipoUsoLote.forestal: return 140.0; // Hue para verde oscuro
      case TipoUsoLote.ornamental: return BitmapDescriptor.hueRed;
      case TipoUsoLote.perimetro: return BitmapDescriptor.hueRose;
      default: return BitmapDescriptor.hueCyan;
    }
  }

  @override
  Widget build(BuildContext context) {
    final estadoLotes = ref.watch(panelLotesNotifierProvider);
    final estadoAnimales = ref.watch(pecuarioNotifierProvider);
    final estadoBeneficio = ref.watch(beneficioNotifierProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Mapa de mi Finca', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black.withOpacity(0.7), Colors.transparent]))),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: estadoLotes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (lotes) {
          final animales = estadoAnimales.valueOrNull ?? [];
          final beneficios = estadoBeneficio.valueOrNull ?? [];

          final poligonos = lotes.map((l) => Polygon(
            polygonId: PolygonId(l.id), 
            points: l.coordenadas.map((c) => LatLng(c.latitud, c.longitud)).toList(), 
            fillColor: _obtenerColorLote(l).withValues(alpha: 0.35),
            strokeColor: _obtenerColorLote(l), 
            strokeWidth: l.uso == TipoUsoLote.perimetro ? 4 : 2
          )).toSet();

          final marcadores = lotes.map((l) {
            String infoAdicional = '';
            
            // Si es pecuario, buscar animales
            if (l.uso == TipoUsoLote.pecuario || l.uso == TipoUsoLote.infraestructura) {
              final animalesAqui = animales.where((a) => a.loteId == l.id).toList();
              if (animalesAqui.isNotEmpty) {
                final total = animalesAqui.fold(0, (sum, a) => sum + a.cantidadActual);
                infoAdicional = '\n🐾 $total animales (${animalesAqui.map((a) => a.tipoEspecie).toSet().join(', ')})';
              }
            }

            // Si es agrícola, buscar beneficio activo o censo
            if (l.uso == TipoUsoLote.agricola) {
              final beneficioLote = beneficios.where((b) => b.loteOrigenNombre == l.nombre && b.estado != EstadoBeneficio.listo).toList();
              infoAdicional = '\n🌳 ${l.numeroMatas} matas | ${l.etapaCultivo ?? 'En levante'}';
              if (beneficioLote.isNotEmpty) {
                infoAdicional += '\n☕ Beneficio en curso: ${beneficioLote.length} lotes';
              }
            }

            return Marker(
              markerId: MarkerId(l.id), 
              position: _obtenerCentroLote(l.coordenadas), 
              infoWindow: InfoWindow(
                title: l.nombre, 
                snippet: '${l.subCategoria} • ${l.areaEnHectareas.toStringAsFixed(2)} Ha$infoAdicional'
              ), 
              icon: BitmapDescriptor.defaultMarkerWithHue(_obtenerHueLote(l))
            );
          }).toSet();
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(target: LatLng(4.9816, -75.6033), zoom: 15), 
                mapType: _tipoMapa, 
                polygons: poligonos, 
                markers: marcadores, 
                myLocationEnabled: true, 
                myLocationButtonEnabled: false, 
                onMapCreated: (c) { _mapController = c; _ajustarCamaraALotes(lotes); }
              ),
              Positioned(
                bottom: 30,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () => setState(() {
                    _tipoMapa = _tipoMapa == MapType.hybrid ? MapType.normal : MapType.hybrid;
                  }),
                  backgroundColor: Colors.white,
                  child: Icon(
                    _tipoMapa == MapType.hybrid ? Icons.layers_outlined : Icons.layers,
                    color: const Color(0xFF00695C),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
