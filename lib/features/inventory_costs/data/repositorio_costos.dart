import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../main.dart';
import '../domain/item_costo_model.dart';
import 'item_costo_isar_model.dart';

part 'repositorio_costos.g.dart';

abstract class RepositorioCostos {
  Future<Either<Fallo, List<ItemCostoEntity>>> obtenerCostos({int? fincaId});
  Future<Either<Fallo, void>> guardarCosto(ItemCostoEntity costo);
  Future<Either<Fallo, void>> eliminarCosto(String id);
}

class RepositorioCostosImpl implements RepositorioCostos {
  final Isar isar;
  RepositorioCostosImpl(this.isar);

  @override
  Future<Either<Fallo, List<ItemCostoEntity>>> obtenerCostos({int? fincaId}) async {
    try {
      final query = isar.itemCostoIsarModels.where();
      final resultados = fincaId != null 
          ? await query.filter().fincaIdEqualTo(fincaId).findAll()
          : await query.findAll();
      return Right(resultados.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(FalloBaseDatos('Error al obtener los costos', e));
    }
  }

  @override
  Future<Either<Fallo, void>> guardarCosto(ItemCostoEntity costo) async {
    try {
      final modelo = ItemCostoIsarModel.fromEntity(costo);
      await isar.writeTxn(() async => await isar.itemCostoIsarModels.put(modelo));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al guardar el costo', e));
    }
  }

  @override
  Future<Either<Fallo, void>> eliminarCosto(String id) async {
    try {
      final idInt = int.tryParse(id);
      if (idInt == null) return Left(FalloBaseDatos('ID no válido: $id'));
      await isar.writeTxn(() async => await isar.itemCostoIsarModels.delete(idInt));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al eliminar el costo', e));
    }
  }
}

@riverpod
RepositorioCostos repositorioCostos(RepositorioCostosRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioCostosImpl(isar);
}
