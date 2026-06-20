import 'package:isar/isar.dart';
import '../domain/insumo_model.dart';

part 'insumo_isar_model.g.dart';

@collection
class InsumoIsarModel {
  Id id = Isar.autoIncrement;
  int? fincaId;
  late String nombre;
  late String unidadMedida;
  late double cantidadActual;
  late double umbralMinimo;

  InsumoEntity toEntity() {
    return InsumoEntity(
      id: id.toString(),
      fincaId: fincaId?.toString(),
      nombre: nombre,
      unidadMedida: unidadMedida,
      cantidadActual: cantidadActual,
      umbralMinimo: umbralMinimo,
    );
  }

  static InsumoIsarModel fromEntity(InsumoEntity entidad) {
    final modelo = InsumoIsarModel()
      ..fincaId = entidad.fincaId != null ? int.tryParse(entidad.fincaId!) : null
      ..nombre = entidad.nombre
      ..unidadMedida = entidad.unidadMedida
      ..cantidadActual = entidad.cantidadActual
      ..umbralMinimo = entidad.umbralMinimo;
    
    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}
