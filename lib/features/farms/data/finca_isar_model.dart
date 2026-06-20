import 'package:isar/isar.dart';
import '../domain/finca_model.dart';

part 'finca_isar_model.g.dart';

@collection
class FincaIsarModel {
  Id id = Isar.autoIncrement;

  late String nombre;
  String? veredaUbicacion;
  double? areaTotalHectareas;

  FincaEntity toEntity() {
    return FincaEntity(
      id: id.toString(),
      nombre: nombre,
      veredaUbicacion: veredaUbicacion,
      areaTotalHectareas: areaTotalHectareas,
    );
  }

  static FincaIsarModel fromEntity(FincaEntity entidad) {
    final modelo = FincaIsarModel()
      ..nombre = entidad.nombre
      ..veredaUbicacion = entidad.veredaUbicacion
      ..areaTotalHectareas = entidad.areaTotalHectareas;
    
    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}
