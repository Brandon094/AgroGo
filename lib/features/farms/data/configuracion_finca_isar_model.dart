import 'package:isar/isar.dart';
import '../domain/configuracion_finca_model.dart';

part 'configuracion_finca_isar_model.g.dart';

@collection
class ConfiguracionFincaIsarModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int fincaId;
  
  late double costoAlimentacion;

  ConfiguracionFinca toEntity() {
    return ConfiguracionFinca(
      id: id.toString(),
      fincaId: fincaId.toString(),
      costoAlimentacion: costoAlimentacion,
    );
  }

  static ConfiguracionFincaIsarModel fromEntity(ConfiguracionFinca entidad) {
    final modelo = ConfiguracionFincaIsarModel()
      ..fincaId = int.parse(entidad.fincaId)
      ..costoAlimentacion = entidad.costoAlimentacion;
    
    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}
