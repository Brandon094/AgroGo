import 'package:isar/isar.dart';
import '../domain/adelanto_model.dart';

part 'adelanto_isar_model.g.dart';

@collection
class AdelantoIsarModel {
  Id id = Isar.autoIncrement;

  int? fincaId;
  late int trabajadorId;
  late double monto;
  late DateTime fecha;
  String? motivo;
  late bool pagado;

  AdelantoEntity toEntity() {
    return AdelantoEntity(
      id: id.toString(),
      fincaId: fincaId?.toString(),
      trabajadorId: trabajadorId.toString(),
      monto: monto,
      fecha: fecha,
      motivo: motivo,
      pagado: pagado,
    );
  }

  static AdelantoIsarModel fromEntity(AdelantoEntity entidad) {
    final modelo = AdelantoIsarModel()
      ..fincaId = entidad.fincaId != null ? int.tryParse(entidad.fincaId!) : null
      ..trabajadorId = int.parse(entidad.trabajadorId)
      ..monto = entidad.monto
      ..fecha = entidad.fecha
      ..motivo = entidad.motivo
      ..pagado = entidad.pagado;

    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}
