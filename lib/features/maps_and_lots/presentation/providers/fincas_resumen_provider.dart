import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'lotes_globales_provider.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';
import '../../domain/lote_model.dart';

part 'fincas_resumen_provider.g.dart';

/// Modelo que representa la información consolidada de una finca en el mapa global.
class FincaResumenGeografico {
  final String fincaId;
  final String nombre;
  final LatLng centroide;
  final double areaTotal;
  final int cantidadLotes;

  FincaResumenGeografico({
    required this.fincaId,
    required this.nombre,
    required this.centroide,
    required this.areaTotal,
    required this.cantidadLotes,
  });
}

@riverpod
Future<List<FincaResumenGeografico>> fincasResumen(FincasResumenRef ref) async {
  // Obtenemos todos los lotes y todas las fincas
  final lotes = await ref.watch(lotesGlobalesProvider.future);
  final fincas = await ref.watch(fincasNotifierProvider.future);

  final Map<String, List<Lote>> lotesPorFinca = {};
  for (var lote in lotes) {
    if (lote.fincaId != null) {
      lotesPorFinca.putIfAbsent(lote.fincaId!, () => []).add(lote);
    }
  }

  final List<FincaResumenGeografico> resumenes = [];

  for (var finca in fincas) {
    final lotesDeFinca = lotesPorFinca[finca.id] ?? [];
    if (lotesDeFinca.isEmpty) continue;

    double sumaLat = 0;
    double sumaLng = 0;
    double areaAcumulada = 0;
    int puntosTotales = 0;

    for (var lote in lotesDeFinca) {
      areaAcumulada += lote.areaEnHectareas;
      // Calculamos el centro de cada lote para promediarlos
      for (var coord in lote.coordenadas) {
        sumaLat += coord.latitud;
        sumaLng += coord.longitud;
        puntosTotales++;
      }
    }

    resumenes.add(FincaResumenGeografico(
      fincaId: finca.id,
      nombre: finca.nombre,
      centroide: LatLng(sumaLat / puntosTotales, sumaLng / puntosTotales),
      areaTotal: areaAcumulada,
      cantidadLotes: lotesDeFinca.length,
    ));
  }

  return resumenes;
}
