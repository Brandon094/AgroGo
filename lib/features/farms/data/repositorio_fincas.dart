import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../main.dart';
import '../domain/finca_model.dart';
import 'finca_isar_model.dart';

part 'repositorio_fincas.g.dart';

abstract class RepositorioFincas {
  Future<Either<Fallo, List<FincaEntity>>> obtenerFincas();
  Future<Either<Fallo, String>> guardarFinca(FincaEntity finca);
  Future<Either<Fallo, void>> eliminarFinca(String id);
}

class RepositorioFincasImpl implements RepositorioFincas {
  final Isar isar;
  RepositorioFincasImpl(this.isar);

  @override
  Future<Either<Fallo, List<FincaEntity>>> obtenerFincas() async {
    try {
      final resultados = await isar.fincaIsarModels.where().findAll();
      return Right(resultados.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(FalloBaseDatos('Error al obtener las fincas', e));
    }
  }

  @override
  Future<Either<Fallo, String>> guardarFinca(FincaEntity finca) async {
    try {
      final modelo = FincaIsarModel.fromEntity(finca);
      late int idInsertado;
      await isar.writeTxn(() async {
        idInsertado = await isar.fincaIsarModels.put(modelo);
      });
      return Right(idInsertado.toString());
    } catch (e) {
      return Left(FalloBaseDatos('Error al guardar la finca', e));
    }
  }

  @override
  Future<Either<Fallo, void>> eliminarFinca(String id) async {
    try {
      final idInt = int.parse(id);
      await isar.writeTxn(() async {
        await isar.fincaIsarModels.delete(idInt);
      });
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al eliminar la finca', e));
    }
  }
}

@riverpod
RepositorioFincas repositorioFincas(RepositorioFincasRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioFincasImpl(isar);
}
