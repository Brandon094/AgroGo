import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../main.dart';
import '../domain/beneficio_model.dart';
import 'beneficio_isar_model.dart';

part 'repositorio_beneficio.g.dart';

abstract class RepositorioBeneficio {
  Future<Either<Fallo, List<BeneficioEntity>>> obtenerBeneficios(int fincaId);
  Future<Either<Fallo, void>> guardarBeneficio(BeneficioEntity beneficio);
  Future<Either<Fallo, void>> eliminarBeneficio(String id);
}

class RepositorioBeneficioImpl implements RepositorioBeneficio {
  final Isar isar;
  RepositorioBeneficioImpl(this.isar);

  @override
  Future<Either<Fallo, List<BeneficioEntity>>> obtenerBeneficios(int fincaId) async {
    try {
      final resultados = await isar.beneficioIsarModels
          .filter()
          .fincaIdEqualTo(fincaId)
          .sortByFechaInicioDesc()
          .findAll();
      return Right(resultados.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(FalloBaseDatos('Error al obtener beneficios', e));
    }
  }

  @override
  Future<Either<Fallo, void>> guardarBeneficio(BeneficioEntity beneficio) async {
    try {
      final modelo = BeneficioIsarModel.fromEntity(beneficio);
      await isar.writeTxn(() async => await isar.beneficioIsarModels.put(modelo));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al persistir beneficio', e));
    }
  }

  @override
  Future<Either<Fallo, void>> eliminarBeneficio(String id) async {
    try {
      final idInt = int.tryParse(id);
      if (idInt == null) return Left(FalloBaseDatos('ID no válido'));
      await isar.writeTxn(() async => await isar.beneficioIsarModels.delete(idInt));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al eliminar beneficio', e));
    }
  }
}

@riverpod
RepositorioBeneficio repositorioBeneficio(RepositorioBeneficioRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioBeneficioImpl(isar);
}
