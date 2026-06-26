import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../core/persistence/base_repository.dart';
import '../../../main.dart';
import '../domain/beneficio_model.dart';
import 'beneficio_isar_model.dart';

part 'repositorio_beneficio.g.dart';

abstract class RepositorioBeneficio {
  Future<Either<Fallo, List<BeneficioEntity>>> obtenerBeneficios(int fincaId);
  Future<Either<Fallo, void>> guardarBeneficio(BeneficioEntity beneficio);
  Future<Either<Fallo, void>> eliminarBeneficio(String id);
}

class RepositorioBeneficioImpl extends BaseRepository implements RepositorioBeneficio {
  RepositorioBeneficioImpl(super.isar);

  @override
  Future<Either<Fallo, List<BeneficioEntity>>> obtenerBeneficios(int fincaId) async {
    return ejecutarLectura(() async {
      final resultados = await isar.beneficioIsarModels
          .filter()
          .fincaIdEqualTo(fincaId)
          .sortByFechaInicioDesc()
          .findAll();
      return resultados.map((m) => m.toEntity()).toList();
    }, mensajeError: 'Error al obtener beneficios');
  }

  @override
  Future<Either<Fallo, void>> guardarBeneficio(BeneficioEntity beneficio) async {
    return ejecutarEscritura(() async {
      final modelo = BeneficioIsarModel.fromEntity(beneficio);
      await isar.beneficioIsarModels.put(modelo);
    }, mensajeError: 'Error al persistir beneficio');
  }

  @override
  Future<Either<Fallo, void>> eliminarBeneficio(String id) async {
    final idInt = int.tryParse(id);
    if (idInt == null) return const Left(FalloBaseDatos('ID no válido'));

    return ejecutarEscritura(() async {
      await isar.beneficioIsarModels.delete(idInt);
    }, mensajeError: 'Error al eliminar beneficio');
  }
}

@riverpod
RepositorioBeneficio repositorioBeneficio(RepositorioBeneficioRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioBeneficioImpl(isar);
}
