import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../core/persistence/base_repository.dart';
import '../../../main.dart';
import 'registro_labor_isar_model.dart';

part 'repositorio_labores.g.dart';

abstract class RepositorioLabores {
  Future<Either<Fallo, void>> guardarLabor(RegistroLaborIsarModel labor);
  Future<Either<Fallo, List<RegistroLaborIsarModel>>> obtenerLaboresSemana(int fincaId, DateTime desde);
  Future<double> obtenerKilosTotalesPorLote(int fincaId, int loteId);
  Future<double> obtenerKilosCerezaPendientes(int fincaId, DateTime desde);
  Future<Map<int, ResumenLaborDTO>> obtenerResumenNominaPorTrabajador(int fincaId, DateTime desde);
}

class ResumenLaborDTO {
  final double totalPagar;
  final double totalKilos;
  ResumenLaborDTO({required this.totalPagar, required this.totalKilos});
}

class RepositorioLaboresImpl extends BaseRepository implements RepositorioLabores {
  RepositorioLaboresImpl(super.isar);

  @override
  Future<Either<Fallo, void>> guardarLabor(RegistroLaborIsarModel labor) async {
    return ejecutarEscritura(() async {
      await isar.registroLaborIsarModels.put(labor);
    }, mensajeError: 'Error al guardar labor');
  }

  @override
  Future<Either<Fallo, List<RegistroLaborIsarModel>>> obtenerLaboresSemana(int fincaId, DateTime desde) async {
    return ejecutarLectura(() async {
      return await isar.registroLaborIsarModels
          .filter()
          .fincaIdEqualTo(fincaId)
          .fechaRegistroGreaterThan(desde)
          .findAll();
    }, mensajeError: 'Error al obtener labores');
  }

  @override
  Future<double> obtenerKilosTotalesPorLote(int fincaId, int loteId) async {
    return await isar.registroLaborIsarModels
        .filter()
        .fincaIdEqualTo(fincaId)
        .loteIdEqualTo(loteId)
        .and()
        .group((q) => q.tipoPagoEqualTo('porKilo').or().tipoPagoEqualTo('porArroba'))
        .cantidadKilosProperty()
        .sum();
  }

  @override
  Future<double> obtenerKilosCerezaPendientes(int fincaId, DateTime desde) async {
    return await isar.registroLaborIsarModels
        .filter()
        .fincaIdEqualTo(fincaId)
        .fechaRegistroGreaterThan(desde)
        .cantidadKilosProperty()
        .sum();
  }

  @override
  Future<Map<int, ResumenLaborDTO>> obtenerResumenNominaPorTrabajador(int fincaId, DateTime desde) async {
    final tIds = await isar.registroLaborIsarModels
        .filter()
        .fincaIdEqualTo(fincaId)
        .fechaRegistroGreaterThan(desde)
        .trabajadorIdProperty()
        .findAll();
    
    final tIdsUnicos = tIds.toSet();
    final mapa = <int, ResumenLaborDTO>{};

    for (final id in tIdsUnicos) {
      final query = isar.registroLaborIsarModels.filter()
          .fincaIdEqualTo(fincaId)
          .fechaRegistroGreaterThan(desde)
          .trabajadorIdEqualTo(id);

      final totalPagar = await query.totalPagarProperty().sum();
      final totalKilos = await query.cantidadKilosProperty().sum();
      
      mapa[id] = ResumenLaborDTO(totalPagar: totalPagar, totalKilos: totalKilos);
    }
    return mapa;
  }
}

@riverpod
RepositorioLabores repositorioLabores(RepositorioLaboresRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioLaboresImpl(isar);
}
