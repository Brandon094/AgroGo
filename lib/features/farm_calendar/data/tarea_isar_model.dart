import 'package:isar/isar.dart';
import '../domain/tarea_model.dart';

part 'tarea_isar_model.g.dart';

@collection
class TareaIsarModel {
  Id id = Isar.autoIncrement;
  int? fincaId;
  late String titulo;
  late String tipoActividad;
  late DateTime fechaInicio;
  late DateTime fechaFinEstimada;
  late bool estaCompletada;
  int? loteId;

  TareaEntity toEntity() {
    return TareaEntity(
      id: id.toString(),
      fincaId: fincaId?.toString(),
      titulo: titulo,
      tipoActividad: tipoActividad,
      fechaInicio: fechaInicio,
      fechaFinEstimada: fechaFinEstimada,
      estaCompletada: estaCompletada,
      loteId: loteId?.toString(),
    );
  }

  static TareaIsarModel fromEntity(TareaEntity entidad) {
    final modelo = TareaIsarModel()
      ..fincaId = entidad.fincaId != null ? int.tryParse(entidad.fincaId!) : null
      ..titulo = entidad.titulo
      ..tipoActividad = entidad.tipoActividad
      ..fechaInicio = entidad.fechaInicio
      ..fechaFinEstimada = entidad.fechaFinEstimada
      ..estaCompletada = entidad.estaCompletada
      ..loteId = entidad.loteId != null ? int.tryParse(entidad.loteId!) : null;

    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}
