import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../core/persistence/base_repository.dart';
import '../../../main.dart';
import '../domain/finca_model.dart';
import '../domain/configuracion_finca_model.dart';
import 'finca_isar_model.dart';
import 'configuracion_finca_isar_model.dart';

part 'repositorio_fincas.g.dart';

abstract class RepositorioFincas {
  Future<Either<Fallo, List<FincaEntity>>> obtenerFincas();
  Future<Either<Fallo, String>> guardarFinca(FincaEntity finca);
  Future<Either<Fallo, void>> eliminarFinca(String id);

  Future<Either<Fallo, ConfiguracionFinca>> obtenerConfiguracion(int fincaId);
  Future<Either<Fallo, void>> guardarConfiguracion(ConfiguracionFinca config);
}

class RepositorioFincasImpl extends BaseRepository implements RepositorioFincas {
  RepositorioFincasImpl(super.isar);

  @override
  Future<Either<Fallo, List<FincaEntity>>> obtenerFincas() async {
    return ejecutarLectura(() async {
      final resultados = await isar.fincaIsarModels.where().findAll();
      return resultados.map((m) => m.toEntity()).toList();
    }, mensajeError: 'Error al obtener las fincas');
  }

  @override
  Future<Either<Fallo, String>> guardarFinca(FincaEntity finca) async {
    return ejecutarEscritura(() async {
      final modelo = FincaIsarModel.fromEntity(finca);
      final idInsertado = await isar.fincaIsarModels.put(modelo);
      return idInsertado.toString();
    }, mensajeError: 'Error al guardar la finca');
  }

  @override
  Future<Either<Fallo, void>> eliminarFinca(String id) async {
    final idInt = int.tryParse(id);
    if (idInt == null) return const Left(FalloBaseDatos('ID no válido'));
    
    return ejecutarEscritura(() async {
      await isar.fincaIsarModels.delete(idInt);
    }, mensajeError: 'Error al eliminar la finca');
  }

  @override
  Future<Either<Fallo, ConfiguracionFinca>> obtenerConfiguracion(int fincaId) async {
    return ejecutarLectura(() async {
      final config = await isar.configuracionFincaIsarModels.filter().fincaIdEqualTo(fincaId).findFirst();
      return config?.toEntity() ?? ConfiguracionFinca(id: '', fincaId: fincaId.toString());
    }, mensajeError: 'Error al obtener configuración');
  }

  @override
  Future<Either<Fallo, void>> guardarConfiguracion(ConfiguracionFinca config) async {
    return ejecutarEscritura(() async {
      final modelo = ConfiguracionFincaIsarModel.fromEntity(config);
      await isar.configuracionFincaIsarModels.put(modelo);
    }, mensajeError: 'Error al guardar configuración');
  }
}

@riverpod
RepositorioFincas repositorioFincas(RepositorioFincasRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioFincasImpl(isar);
}
