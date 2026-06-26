import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../core/persistence/base_repository.dart';
import '../../../main.dart';
import '../domain/insumo_model.dart';
import 'insumo_isar_model.dart';

part 'repositorio_insumos.g.dart';

abstract class RepositorioInsumos {
  Future<Either<Fallo, List<InsumoEntity>>> obtenerInsumos({int? fincaId});
  Future<Either<Fallo, void>> guardarInsumo(InsumoEntity insumo);
  Future<Either<Fallo, void>> actualizarStock(String id, double cantidadCambio);
}

class RepositorioInsumosImpl extends BaseRepository implements RepositorioInsumos {
  RepositorioInsumosImpl(super.isar);

  @override
  Future<Either<Fallo, List<InsumoEntity>>> obtenerInsumos({int? fincaId}) async {
    return ejecutarLectura(() async {
      final query = isar.insumoIsarModels.where();
      final resultados = fincaId != null 
          ? await query.filter().fincaIdEqualTo(fincaId).findAll()
          : await query.findAll();
      return resultados.map((m) => m.toEntity()).toList();
    }, mensajeError: 'Error al obtener insumos');
  }

  @override
  Future<Either<Fallo, void>> guardarInsumo(InsumoEntity insumo) async {
    return ejecutarEscritura(() async {
      final modelo = InsumoIsarModel.fromEntity(insumo);
      await isar.insumoIsarModels.put(modelo);
    }, mensajeError: 'Error al guardar insumo');
  }

  @override
  Future<Either<Fallo, void>> actualizarStock(String id, double cantidadCambio) async {
    final idInt = int.tryParse(id);
    if (idInt == null) return const Left(FalloBaseDatos('ID no válido'));

    return ejecutarEscritura(() async {
      final actual = await isar.insumoIsarModels.get(idInt);
      if (actual != null) {
        actual.cantidadActual += cantidadCambio;
        if (actual.cantidadActual < 0) actual.cantidadActual = 0;
        actual.valorTotal = actual.cantidadActual * actual.valorUnitario;
        await isar.insumoIsarModels.put(actual);
      }
    }, mensajeError: 'Error al actualizar stock');
  }
}

@riverpod
RepositorioInsumos repositorioInsumos(RepositorioInsumosRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioInsumosImpl(isar);
}
