import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'providers/panel_lotes_notifier.dart';
import '../domain/lote_model.dart';

/// Pantalla de visualización global de la finca.
/// Muestra todos los lotes guardados como polígonos de colores sobre el mapa satelital.
class PantallaMapaFinca extends ConsumerStatefulWidget {
  const PantallaMapaFinca({super.key});

  @override
  ConsumerState<PantallaMapaFinca> createState() => _PantallaMapaFincaState();
}

class _PantallaMapaFincaState extends ConsumerState<PantallaMapaFinca> {
  GoogleMapController? _mapController;

  /// Calcula los límites del mapa (Bounds) para que todos los lotes sean visibles.
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

    if (minLat != null && maxLat != null && minLng != null && maxLong != null) {
      final bounds = LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLong),
      );

      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
    }
  }

  /// Calcula el punto central aproximado de un lote para colocar el marcador.
  LatLng _obtenerCentroLote(List<CoordenadaLote> coordenadas) {
    double sumLat = 0;
    double sumLng = 0;
    for (final c in coordenadas) {
      sumLat += c.latitud;
      sumLng += c.longitud;
    }
    return LatLng(sumLat / coordenadas.length, sumLng / coordenadas.length);
  }

  /// Define un color según el tipo de uso para diferenciar los polígonos.
  Color _obtenerColorUso(TipoUsoLote uso) {
    switch (uso) {
      case TipoUsoLote.agricola:
        return Colors.green;
      case TipoUsoLote.pecuario:
        return Colors.orange;
      case TipoUsoLote.forestal:
        return Colors.teal;
      case TipoUsoLote.infraestructura:
        return Colors.grey;
    }
  }

  /// Devuelve el ícono (Pin) de color correspondiente al tipo de uso.
  double _obtenerHueUso(TipoUsoLote uso) {
    switch (uso) {
      case TipoUsoLote.agricola:
        return BitmapDescriptor.hueGreen;
      case TipoUsoLote.pecuario:
        return BitmapDescriptor.hueOrange;
      case TipoUsoLote.forestal:
        return BitmapDescriptor.hueAzure;
      case TipoUsoLote.infraestructura:
        return BitmapDescriptor.hueViolet;
    }
  }

  @override
  Widget build(BuildContext context) {
    final estadoLotes = ref.watch(panelLotesNotifierProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Mapa Global de la Finca',
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
      body: estadoLotes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error al cargar el mapa: $err')),
        data: (lotes) {
          // Generar Polígonos
          final Set<Polygon> poligonos = lotes.map((lote) {
            final color = _obtenerColorUso(lote.uso);
            return Polygon(
              polygonId: PolygonId(lote.id),
              points: lote.coordenadas.map((c) => LatLng(c.latitud, c.longitud)).toList(),
              fillColor: color.withOpacity(0.35),
              strokeColor: color,
              strokeWidth: 3,
            );
          }).toSet();

          // Generar Marcadores informativos en el centro de cada lote
          final Set<Marker> marcadores = lotes.map((lote) {
            return Marker(
              markerId: MarkerId('marker_${lote.id}'),
              position: _obtenerCentroLote(lote.coordenadas),
              infoWindow: InfoWindow(
                title: lote.nombre,
                snippet: '${lote.subCategoria} • ${lote.areaEnHectareas.toStringAsFixed(2)} Ha',
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(_obtenerHueUso(lote.uso)),
            );
          }).toSet();

          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(4.9816, -75.6033),
              zoom: 15,
            ),
            mapType: MapType.hybrid,
            polygons: poligonos,
            markers: marcadores,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              _mapController = controller;
              _ajustarCamaraALotes(lotes);
            },
          );
        },
      ),
    );
  }
}
