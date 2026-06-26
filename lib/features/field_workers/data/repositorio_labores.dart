import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../main.dart';
import 'registro_labor_isar_model.dart';

part 'repositorio_labores.g.dart';

abstract class RepositorioLabores {
  Future<void> guardarLabor(RegistroLaborIsarModel labor);
  Future<List<RegistroLaborIsarModel>> obtenerLaboresSemana(int fincaId, DateTime desde);
  Future<double> obtenerKilosTotalesPorLote(int fincaId, int loteId);
}

class RepositorioLaboresImpl implements RepositorioLabores {
  final Isar isar;
  RepositorioLaboresImpl(this.isar);

  @override
  Future<void> guardarLabor(RegistroLaborIsarModel labor) async {
    await isar.writeTxn(() async => await isar.registroLaborIsarModels.put(labor));
  }

  @override
  Future<List<RegistroLaborIsarModel>> obtenerLaboresSemana(int fincaId, DateTime desde) async {
    return await isar.registroLaborIsarModels
        .filter()
        .fincaIdEqualTo(fincaId)
        .fechaRegistroGreaterThan(desde)
        .findAll();
  }

  @override
  Future<double> obtenerKilosTotalesPorLote(int fincaId, int loteId) async {
    // OPTIMIZACIÓN ARQUITECTÓNICA: Usamos agregación nativa de Isar (C++) en lugar de sumar en Dart
    return await isar.registroLaborIsarModels
        .filter()
        .fincaIdEqualTo(fincaId)
        .loteIdEqualTo(loteId)
        .and()
        .group((q) => q.tipoPagoEqualTo('porKilo').or().tipoPagoEqualTo('porArroba'))
        .cantidadKilosProperty()
        .sum();
  }
}

@riverpod
RepositorioLabores repositorioLabores(RepositorioLaboresRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioLaboresImpl(isar);
}
