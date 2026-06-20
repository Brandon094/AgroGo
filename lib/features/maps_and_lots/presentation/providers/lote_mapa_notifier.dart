import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mt;
import 'panel_lotes_notifier.dart';
import '../../domain/lote_model.dart';

part 'lote_mapa_notifier.g.dart';

enum ModoMapeo { manual, gpsCampo }

/// Estado inmutable que representa el mapa interactivo de dibujo de lotes.
class LoteMapaState {
  final List<LatLng> puntos;
  final Set<Marker> marcadores;
  final Set<Polygon> poligonos;
  final Set<Polygon> poligonosPasivos;
  final double areaEnHectareas;
  final ModoMapeo modo;
  final double? ultimoMargenError;
  final bool mostrarAdvertenciaGps;

  const LoteMapaState({
    required this.puntos,
    required this.marcadores,
    required this.poligonos,
    required this.poligonosPasivos,
    required this.areaEnHectareas,
    this.modo = ModoMapeo.manual,
    this.ultimoMargenError,
    this.mostrarAdvertenciaGps = false,
  });

  LoteMapaState copyWith({
    List<LatLng>? puntos,
    Set<Marker>? marcadores,
    Set<Polygon>? poligonos,
    Set<Polygon>? poligonosPasivos,
    double? areaEnHectareas,
    ModoMapeo? modo,
    double? ultimoMargenError,
    bool? mostrarAdvertenciaGps,
  }) {
    return LoteMapaState(
      puntos: puntos ?? this.puntos,
      marcadores: marcadores ?? this.marcadores,
      poligonos: poligonos ?? this.poligonos,
      poligonosPasivos: poligonosPasivos ?? this.poligonosPasivos,
      areaEnHectareas: areaEnHectareas ?? this.areaEnHectareas,
      modo: modo ?? this.modo,
      ultimoMargenError: ultimoMargenError ?? this.ultimoMargenError,
      mostrarAdvertenciaGps: mostrarAdvertenciaGps ?? this.mostrarAdvertenciaGps,
    );
  }
}

@riverpod
class LoteMapaNotifier extends _$LoteMapaNotifier {
  @override
  LoteMapaState build() {
    final lotesExistentes = ref.watch(panelLotesNotifierProvider).valueOrNull ?? [];
    final pasivos = _generarPoligonosPasivos(lotesExistentes);

    return LoteMapaState(
      puntos: [],
      marcadores: {},
      poligonos: {},
      poligonosPasivos: pasivos,
      areaEnHectareas: 0.0,
      modo: ModoMapeo.manual,
    );
  }

  void cambiarModo(ModoMapeo nuevoModo) {
    state = state.copyWith(modo: nuevoModo, mostrarAdvertenciaGps: false);
  }

  /// Añade una coordenada capturada por GPS con filtro de precisión.
  /// Retorna true si el punto fue aceptado, false si el margen de error es muy alto.
  bool agregarPuntoGps(LatLng punto, double accuracy) {
    if (accuracy > 5.0) {
      state = state.copyWith(
        ultimoMargenError: accuracy,
        mostrarAdvertenciaGps: true,
      );
      return false;
    }

    final puntosActualizados = List<LatLng>.from(state.puntos)..add(punto);
    state = _calcularEstadoActualizado(puntosActualizados).copyWith(
      mostrarAdvertenciaGps: false,
      ultimoMargenError: accuracy,
    );
    return true;
  }

  void ocultarAdvertencia() {
    state = state.copyWith(mostrarAdvertenciaGps: false);
  }

  void agregarPunto(LatLng punto) {
    if (state.modo != ModoMapeo.manual) return;
    final puntosActualizados = List<LatLng>.from(state.puntos)..add(punto);
    state = _calcularEstadoActualizado(puntosActualizados);
  }

  void actualizarPunto(int indice, LatLng nuevoPunto) {
    if (indice < 0 || indice >= state.puntos.length) return;
    final puntosActualizados = List<LatLng>.from(state.puntos);
    puntosActualizados[indice] = nuevoPunto;
    state = _calcularEstadoActualizado(puntosActualizados);
  }

  void deshacerUltimoPunto() {
    if (state.puntos.isEmpty) return;
    final puntosActualizados = List<LatLng>.from(state.puntos)..removeLast();
    state = _calcularEstadoActualizado(puntosActualizados);
  }

  void limpiarMapa() {
    state = state.copyWith(
      puntos: [],
      marcadores: {},
      poligonos: {},
      areaEnHectareas: 0.0,
      mostrarAdvertenciaGps: false,
    );
  }

  Set<Polygon> _generarPoligonosPasivos(List<Lote> lotes) {
    return lotes.map((lote) {
      final color = _obtenerColorUso(lote.uso);
      return Polygon(
        polygonId: PolygonId('pasivo_${lote.id}'),
        points: lote.coordenadas.map((c) => LatLng(c.latitud, c.longitud)).toList(),
        strokeWidth: 1,
        strokeColor: color.withOpacity(0.6),
        fillColor: color.withOpacity(0.2),
        consumeTapEvents: false,
      );
    }).toSet();
  }

  Color _obtenerColorUso(TipoUsoLote uso) {
    switch (uso) {
      case TipoUsoLote.agricola: return Colors.green;
      case TipoUsoLote.pecuario: return Colors.orange;
      case TipoUsoLote.forestal: return Colors.teal;
      case TipoUsoLote.infraestructura: return Colors.grey;
    }
  }

  LoteMapaState _calcularEstadoActualizado(List<LatLng> puntos) {
    final marcadores = puntos.asMap().entries.map((entrada) {
      final indice = entrada.key;
      final punto = entrada.value;
      return Marker(
        markerId: MarkerId('marcador_$indice'),
        position: punto,
        draggable: state.modo == ModoMapeo.manual,
        onDragEnd: (nuevaPosicion) => actualizarPunto(indice, nuevaPosicion),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: 'Esquina ${indice + 1}', snippet: 'Ajuste manual permitido'),
      );
    }).toSet();

    double areaEnHectareas = 0.0;
    final Set<Polygon> poligonos = {};

    if (puntos.length >= 3) {
      final puntosMt = puntos.map((p) => mt.LatLng(p.latitude, p.longitude)).toList();
      final areaEnMetrosCuadrados = mt.SphericalUtil.computeArea(puntosMt);
      areaEnHectareas = areaEnMetrosCuadrados / 10000.0;

      poligonos.add(
        Polygon(
          polygonId: const PolygonId('poligono_lote_activo'),
          points: puntos,
          strokeWidth: 4,
          strokeColor: const Color(0xFF2E7D32),
          fillColor: const Color(0x664CAF50),
          geodesic: true,
        ),
      );
    }

    return state.copyWith(
      puntos: puntos,
      marcadores: marcadores,
      poligonos: poligonos,
      areaEnHectareas: areaEnHectareas,
    );
  }
}
