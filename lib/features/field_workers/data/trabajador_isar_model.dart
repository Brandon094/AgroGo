import 'package:isar/isar.dart';
import '../domain/trabajador_model.dart';

part 'trabajador_isar_model.g.dart';

@collection
class TrabajadorIsarModel {
  Id id = Isar.autoIncrement;
  int? fincaId;
  late String nombreCompleto;
  late String tipoTrabajador;
  late double tarifaBase;
  late DateTime fechaIngreso;

  TrabajadorEntity toEntity() {
    return TrabajadorEntity(
      id: id.toString(),
      fincaId: fincaId?.toString(),
      nombreCompleto: nombreCompleto,
      tipoTrabajador: tipoTrabajador,
      tarifaBase: tarifaBase,
      fechaIngreso: fechaIngreso,
    );
  }

  static TrabajadorIsarModel fromEntity(TrabajadorEntity entidad) {
    final modelo = TrabajadorIsarModel()
      ..fincaId = entidad.fincaId != null ? int.tryParse(entidad.fincaId!) : null
      ..nombreCompleto = entidad.nombreCompleto
      ..tipoTrabajador = entidad.tipoTrabajador
      ..tarifaBase = entidad.tarifaBase
      ..fechaIngreso = entidad.fechaIngreso;

    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}
