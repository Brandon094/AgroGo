import 'package:isar/isar.dart';
import '../domain/lote_model.dart';

part 'lote_isar_model.g.dart';

@embedded
class CoordenadaLoteIsarModel {
  double? latitud;
  double? longitud;
  CoordenadaLoteIsarModel({this.latitud, this.longitud});
}

@collection
class LoteIsarModel {
  Id id = Isar.autoIncrement;
  int? fincaId;
  late String nombre;

  @enumerated
  late TipoUsoLote uso;

  late String subCategoria;
  late double areaEnHectareas;
  late int numeroMatas;
  int? capacidadAnimales;
  late List<CoordenadaLoteIsarModel> coordenadas;
  String? etapaCultivo;

  Lote toEntity() {
    return Lote(
      id: id.toString(),
      fincaId: fincaId?.toString(),
      nombre: nombre,
      uso: uso,
      subCategoria: subCategoria,
      areaEnHectareas: areaEnHectareas,
      numeroMatas: numeroMatas,
      capacidadAnimales: capacidadAnimales,
      coordenadas: coordenadas.map((c) => CoordenadaLote(latitud: c.latitud ?? 0.0, longitud: c.longitud ?? 0.0)).toList(),
      etapaCultivo: etapaCultivo,
    );
  }

  static LoteIsarModel fromEntity(Lote entidad) {
    final modelo = LoteIsarModel()
      ..fincaId = entidad.fincaId != null ? int.tryParse(entidad.fincaId!) : null
      ..nombre = entidad.nombre
      ..uso = entidad.uso
      ..subCategoria = entidad.subCategoria
      ..areaEnHectareas = entidad.areaEnHectareas
      ..numeroMatas = entidad.numeroMatas
      ..capacidadAnimales = entidad.capacidadAnimales
      ..coordenadas = entidad.coordenadas.map((c) => CoordenadaLoteIsarModel(latitud: c.latitud, longitud: c.longitud)).toList()
      ..etapaCultivo = entidad.etapaCultivo;

    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}
