import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../main.dart';
import '../domain/trabajador_model.dart';
import 'trabajador_isar_model.dart';

part 'repositorio_trabajadores.g.dart';

abstract class RepositorioTrabajadores {
  Future<Either<Fallo, List<TrabajadorEntity>>> obtenerTrabajadores({int? fincaId});
  Future<Either<Fallo, void>> guardarTrabajador(TrabajadorEntity trabajador);
  Future<Either<Fallo, void>> eliminarTrabajador(String id);
}

class RepositorioTrabajadoresImpl implements RepositorioTrabajadores {
  final Isar isar;
  RepositorioTrabajadoresImpl(this.isar);

  @override
  Future<Either<Fallo, List<TrabajadorEntity>>> obtenerTrabajadores({int? fincaId}) async {
    try {
      final query = isar.trabajadorIsarModels.where();
      final resultados = fincaId != null 
          ? await query.filter().fincaIdEqualTo(fincaId).findAll()
          : await query.findAll();
      return Right(resultados.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(FalloBaseDatos('Error al obtener los trabajadores', e));
    }
  }

  @override
  Future<Either<Fallo, void>> guardarTrabajador(TrabajadorEntity trabajador) async {
    try {
      final modelo = TrabajadorIsarModel.fromEntity(trabajador);
      await isar.writeTxn(() async => await isar.trabajadorIsarModels.put(modelo));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al guardar el trabajador', e));
    }
  }

  @override
  Future<Either<Fallo, void>> eliminarTrabajador(String id) async {
    try {
      final idInt = int.tryParse(id);
      if (idInt == null) return Left(FalloBaseDatos('ID no válido: $id'));
      await isar.writeTxn(() async => await isar.trabajadorIsarModels.delete(idInt));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al eliminar el trabajador', e));
    }
  }
}

@riverpod
RepositorioTrabajadores repositorioTrabajadores(RepositorioTrabajadoresRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioTrabajadoresImpl(isar);
}
