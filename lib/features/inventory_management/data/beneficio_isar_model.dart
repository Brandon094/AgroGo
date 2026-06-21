import 'package:isar/isar.dart';
import '../domain/beneficio_model.dart';

part 'beneficio_isar_model.g.dart';

@collection
class BeneficioIsarModel {
  Id id = Isar.autoIncrement;
  int? fincaId;
  late DateTime fechaInicio;
  late double kilosCereza;
  double? kilosFinales;
  
  @enumerated
  late EstadoBeneficio estado;
  
  String? loteOrigenNombre;

  BeneficioEntity toEntity() {
    return BeneficioEntity(
      id: id.toString(),
      fincaId: fincaId?.toString(),
      fechaInicio: fechaInicio,
      kilosCereza: kilosCereza,
      kilosFinales: kilosFinales,
      estado: estado,
      loteOrigenNombre: loteOrigenNombre,
    );
  }

  static BeneficioIsarModel fromEntity(BeneficioEntity entidad) {
    final modelo = BeneficioIsarModel()
      ..fincaId = entidad.fincaId != null ? int.tryParse(entidad.fincaId!) : null
      ..fechaInicio = entidad.fechaInicio
      ..kilosCereza = entidad.kilosCereza
      ..kilosFinales = entidad.kilosFinales
      ..estado = entidad.estado
      ..loteOrigenNombre = entidad.loteOrigenNombre;
    
    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}
