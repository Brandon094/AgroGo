import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../main.dart';
import '../domain/insumo_model.dart';
import 'insumo_isar_model.dart';

part 'repositorio_insumos.g.dart';

abstract class RepositorioInsumos {
  Future<Either<Fallo, List<InsumoEntity>>> obtenerInsumos({int? fincaId});
  Future<Either<Fallo, void>> guardarInsumo(InsumoEntity insumo);
  Future<Either<Fallo, void>> actualizarStock(String id, double cantidadCambio);
}

class RepositorioInsumosImpl implements RepositorioInsumos {
  final Isar isar;
  RepositorioInsumosImpl(this.isar);

  @override
  Future<Either<Fallo, List<InsumoEntity>>> obtenerInsumos({int? fincaId}) async {
    try {
      final query = isar.insumoIsarModels.where();
      final resultados = fincaId != null 
          ? await query.filter().fincaIdEqualTo(fincaId).findAll()
          : await query.findAll();
      return Right(resultados.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(FalloBaseDatos('Error al obtener insumos', e));
    }
  }

  @override
  Future<Either<Fallo, void>> guardarInsumo(InsumoEntity insumo) async {
    try {
      final modelo = InsumoIsarModel.fromEntity(insumo);
      await isar.writeTxn(() async => await isar.insumoIsarModels.put(modelo));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al guardar insumo', e));
    }
  }

  @override
  Future<Either<Fallo, void>> actualizarStock(String id, double cantidadCambio) async {
    try {
      final idInt = int.parse(id);
      await isar.writeTxn(() async {
        final actual = await isar.insumoIsarModels.get(idInt);
        if (actual != null) {
          actual.cantidadActual += cantidadCambio;
          if (actual.cantidadActual < 0) actual.cantidadActual = 0;
          // Recalcular valor total
          actual.valorTotal = actual.cantidadActual * actual.valorUnitario;
          await isar.insumoIsarModels.put(actual);
        }
      });
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al actualizar stock', e));
    }
  }
}

@riverpod
RepositorioInsumos repositorioInsumos(RepositorioInsumosRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioInsumosImpl(isar);
}
