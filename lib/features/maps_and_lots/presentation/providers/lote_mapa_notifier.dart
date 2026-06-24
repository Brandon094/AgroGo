import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mt;
import 'package:turf/turf.dart' as turf;
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
  final bool mostrarAdvertenciaPerimetro;
  final bool esCreacionDePerimetro;
  final bool estaArrastrando;
  final int? indicePuntoArrastrado;
  final bool tieneSuperposicion;

  const LoteMapaState({
    required this.puntos,
    required this.marcadores,
    required this.poligonos,
    required this.poligonosPasivos,
    required this.areaEnHectareas,
    this.modo = ModoMapeo.manual,
    this.ultimoMargenError,
    this.mostrarAdvertenciaGps = false,
    this.mostrarAdvertenciaPerimetro = false,
    this.esCreacionDePerimetro = false,
    this.estaArrastrando = false,
    this.indicePuntoArrastrado,
    this.tieneSuperposicion = false,
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
    bool? mostrarAdvertenciaPerimetro,
    bool? esCreacionDePerimetro,
    bool? estaArrastrando,
    int? indicePuntoArrastrado,
    bool? tieneSuperposicion,
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
      mostrarAdvertenciaPerimetro: mostrarAdvertenciaPerimetro ?? this.mostrarAdvertenciaPerimetro,
      esCreacionDePerimetro: esCreacionDePerimetro ?? this.esCreacionDePerimetro,
      estaArrastrando: estaArrastrando ?? this.estaArrastrando,
      indicePuntoArrastrado: indicePuntoArrastrado ?? this.indicePuntoArrastrado,
      tieneSuperposicion: tieneSuperposicion ?? this.tieneSuperposicion,
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
    state = state.copyWith(modo: nuevoModo, mostrarAdvertenciaGps: false, mostrarAdvertenciaPerimetro: false);
  }

  void configurarComoPerimetro(bool esPerimetro) {
    state = state.copyWith(esCreacionDePerimetro: esPerimetro);
  }

  /// Añade una coordenada capturada por GPS con filtro de precisión y validación de perímetro.
  /// Retorna true si el punto fue aceptado, false si el margen de error es muy alto o está fuera de los límites.
  bool agregarPuntoGps(LatLng punto, double accuracy) {
    if (accuracy > 5.0) {
      state = state.copyWith(
        ultimoMargenError: accuracy,
        mostrarAdvertenciaGps: true,
      );
      return false;
    }

    if (!_validarPuntoEnPerimetro(punto)) {
      state = state.copyWith(mostrarAdvertenciaPerimetro: true);
      return false;
    }

    final puntosActualizados = List<LatLng>.from(state.puntos)..add(punto);
    state = _calcularEstadoActualizado(puntosActualizados).copyWith(
      mostrarAdvertenciaGps: false,
      mostrarAdvertenciaPerimetro: false,
      ultimoMargenError: accuracy,
    );
    return true;
  }

  void ocultarAdvertencia() {
    state = state.copyWith(mostrarAdvertenciaGps: false, mostrarAdvertenciaPerimetro: false);
  }

  void agregarPunto(LatLng punto) {
    if (state.modo != ModoMapeo.manual) return;
    
    if (!_validarPuntoEnPerimetro(punto)) {
      state = state.copyWith(mostrarAdvertenciaPerimetro: true);
      return;
    }

    final puntosActualizados = List<LatLng>.from(state.puntos)..add(punto);
    state = _calcularEstadoActualizado(puntosActualizados).copyWith(mostrarAdvertenciaPerimetro: false);
  }

  void iniciarArrastre(int indice) {
    state = state.copyWith(
      estaArrastrando: true,
      indicePuntoArrastrado: indice,
    );
    // Redibujamos para que cambie el color del marcador inmediatamente
    state = _calcularEstadoActualizado(state.puntos);
  }

  void actualizarPunto(int indice, LatLng nuevoPunto) {
    if (indice < 0 || indice >= state.puntos.length) return;

    if (!_validarPuntoEnPerimetro(nuevoPunto)) {
      state = state.copyWith(
        mostrarAdvertenciaPerimetro: true,
        estaArrastrando: false,
        indicePuntoArrastrado: null,
      );
      // Revertimos la posición en la UI forzando un redibujado con los puntos actuales
      state = _calcularEstadoActualizado(List<LatLng>.from(state.puntos));
      return;
    }

    final puntosActualizados = List<LatLng>.from(state.puntos);
    puntosActualizados[indice] = nuevoPunto;
    state = _calcularEstadoActualizado(puntosActualizados).copyWith(
      mostrarAdvertenciaPerimetro: false,
      estaArrastrando: false,
      indicePuntoArrastrado: null,
    );
  }

  bool _validarPuntoEnPerimetro(LatLng punto) {
    // Si estamos creando el perímetro, no validamos contra nada
    if (state.esCreacionDePerimetro) return true;

    final lotesExistentes = ref.read(panelLotesNotifierProvider).valueOrNull ?? [];
    final perimetro = lotesExistentes.firstWhere(
      (l) => l.uso == TipoUsoLote.perimetro,
      orElse: () => Lote(id: '', nombre: '', uso: TipoUsoLote.perimetro, subCategoria: '', areaEnHectareas: 0, numeroMatas: 0, coordenadas: []),
    );

    // REGLA DE ORO: Si no hay perímetro guardado y NO estamos en modo creación de perímetro,
    // NO permitimos marcar puntos (estamos en el aire).
    if (perimetro.coordenadas.isEmpty) return false;

    final puntosPerimetro = perimetro.coordenadas.map((c) => mt.LatLng(c.latitud, c.longitud)).toList();
    return mt.PolygonUtil.containsLocation(
      mt.LatLng(punto.latitude, punto.longitude),
      puntosPerimetro,
      true, // Geodesic
    );
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
      final color = _obtenerColorLote(lote);
      final esPerimetro = lote.uso == TipoUsoLote.perimetro;
      final esInfra = lote.uso == TipoUsoLote.infraestructura;
      
      return Polygon(
        polygonId: PolygonId('pasivo_${lote.id}'),
        points: lote.coordenadas.map((c) => LatLng(c.latitud, c.longitud)).toList(),
        strokeWidth: esPerimetro ? 4 : 2,
        strokeColor: esPerimetro ? color : (esInfra ? Colors.white : color.withValues(alpha: 0.8)),
        fillColor: esPerimetro ? Colors.transparent : color.withValues(alpha: 0.4),
        consumeTapEvents: false,
      );
    }).toSet();
  }

  Color _obtenerColorLote(Lote lote) {
    if (lote.uso == TipoUsoLote.infraestructura) {
      final pecuarias = ['Cochera', 'Galpón', 'Estanque', 'Corral', 'Potrero'];
      if (pecuarias.contains(lote.subCategoria)) return Colors.orange;
      return Colors.purple;
    }
    switch (lote.uso) {
      case TipoUsoLote.agricola: return Colors.green;
      case TipoUsoLote.pecuario: return Colors.orange;
      case TipoUsoLote.forestal: return const Color(0xFF1B5E20); // Verde oscuro para bosque
      case TipoUsoLote.ornamental: return Colors.deepOrange.shade300; // Tono huerta/floral
      case TipoUsoLote.perimetro: return Colors.brown;
      default: return Colors.grey;
    }
  }

  bool _detectarSuperposicion(List<LatLng> puntosActuales) {
    if (puntosActuales.length < 3) return false;
    if (state.esCreacionDePerimetro) return false;

    final lotesExistentes = ref.read(panelLotesNotifierProvider).valueOrNull ?? [];
    
    // Preparar el polígono actual para turf
    final List<turf.Position> coordsActual = puntosActuales.map((p) => turf.Position(p.longitude, p.latitude)).toList();
    coordsActual.add(coordsActual.first); // Cerrar polígono
    final polyActual = turf.Polygon(coordinates: [coordsActual]);

    for (final lote in lotesExistentes) {
      if (lote.uso == TipoUsoLote.perimetro) continue;
      
      final List<turf.Position> coordsExistente = lote.coordenadas.map((c) => turf.Position(c.longitud, c.latitud)).toList();
      coordsExistente.add(coordsExistente.first); // Cerrar polígono
      final polyExistente = turf.Polygon(coordinates: [coordsExistente]);

      // Verificamos si hay intersección usando turf
      if (turf.booleanIntersects(polyActual, polyExistente)) {
        return true;
      }
    }
    return false;
  }

  LoteMapaState _calcularEstadoActualizado(List<LatLng> puntos) {
    final tieneSuperposicion = _detectarSuperposicion(puntos);
    
    final marcadores = puntos.asMap().entries.map((entrada) {
      final indice = entrada.key;
      final punto = entrada.value;
      final esArrastrado = state.estaArrastrando && state.indicePuntoArrastrado == indice;

      return Marker(
        markerId: MarkerId('marcador_$indice'),
        position: punto,
        draggable: state.modo == ModoMapeo.manual,
        onDragStart: (_) => iniciarArrastre(indice),
        onDragEnd: (nuevaPosicion) => actualizarPunto(indice, nuevaPosicion),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          esArrastrado ? BitmapDescriptor.hueAzure : BitmapDescriptor.hueOrange,
        ),
        infoWindow: InfoWindow(title: 'Esquina ${indice + 1}', snippet: 'Mantén presionado para mover'),
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
          strokeColor: tieneSuperposicion ? Colors.red : const Color(0xFF2E7D32),
          fillColor: tieneSuperposicion ? Colors.red.withValues(alpha: 0.3) : const Color(0x664CAF50),
          geodesic: true,
        ),
      );
    }

    return state.copyWith(
      puntos: puntos,
      marcadores: marcadores,
      poligonos: poligonos,
      areaEnHectareas: areaEnHectareas,
      tieneSuperposicion: tieneSuperposicion,
    );
  }
}
