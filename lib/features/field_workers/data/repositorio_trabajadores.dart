import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../core/persistence/base_repository.dart';
import '../../../main.dart';
import '../domain/trabajador_model.dart';
import '../domain/adelanto_model.dart';
import 'trabajador_isar_model.dart';
import 'adelanto_isar_model.dart';

part 'repositorio_trabajadores.g.dart';

abstract class RepositorioTrabajadores {
  Future<Either<Fallo, List<TrabajadorEntity>>> obtenerTrabajadores({int? fincaId});
  Future<Either<Fallo, void>> guardarTrabajador(TrabajadorEntity trabajador);
  Future<Either<Fallo, void>> eliminarTrabajador(String id);

  Future<Either<Fallo, List<AdelantoEntity>>> obtenerAdelantos({int? fincaId, int? trabajadorId, bool? pagado});
  Future<Either<Fallo, void>> guardarAdelanto(AdelantoEntity adelanto);
  Future<Either<Fallo, void>> eliminarAdelanto(String id);
  Future<Map<int, double>> obtenerTotalAdelantosPendientesPorTrabajador(int fincaId);
}

class RepositorioTrabajadoresImpl extends BaseRepository implements RepositorioTrabajadores {
  RepositorioTrabajadoresImpl(super.isar);

  @override
  Future<Either<Fallo, List<TrabajadorEntity>>> obtenerTrabajadores({int? fincaId}) async {
    return ejecutarLectura(() async {
      final query = isar.trabajadorIsarModels.where();
      final resultados = fincaId != null 
          ? await query.filter().fincaIdEqualTo(fincaId).findAll()
          : await query.findAll();
      return resultados.map((m) => m.toEntity()).toList();
    }, mensajeError: 'Error al obtener los trabajadores');
  }

  @override
  Future<Either<Fallo, void>> guardarTrabajador(TrabajadorEntity trabajador) async {
    return ejecutarEscritura(() async {
      final modelo = TrabajadorIsarModel.fromEntity(trabajador);
      await isar.trabajadorIsarModels.put(modelo);
    }, mensajeError: 'Error al guardar el trabajador');
  }

  @override
  Future<Either<Fallo, void>> eliminarTrabajador(String id) async {
    final idInt = int.tryParse(id);
    if (idInt == null) return const Left(FalloBaseDatos('ID no válido'));
    
    return ejecutarEscritura(() async {
      await isar.trabajadorIsarModels.delete(idInt);
    }, mensajeError: 'Error al eliminar el trabajador');
  }

  @override
  Future<Either<Fallo, List<AdelantoEntity>>> obtenerAdelantos({int? fincaId, int? trabajadorId, bool? pagado}) async {
    return ejecutarLectura(() async {
      final query = isar.adelantoIsarModels.where();
      final resultados = await query.filter()
          .optional(fincaId != null, (q) => q.fincaIdEqualTo(fincaId!))
          .optional(trabajadorId != null, (q) => q.trabajadorIdEqualTo(trabajadorId!))
          .optional(pagado != null, (q) => q.pagadoEqualTo(pagado!))
          .findAll();
      return resultados.map((m) => m.toEntity()).toList();
    }, mensajeError: 'Error al obtener adelantos');
  }

  @override
  Future<Either<Fallo, void>> guardarAdelanto(AdelantoEntity adelanto) async {
    return ejecutarEscritura(() async {
      final modelo = AdelantoIsarModel.fromEntity(adelanto);
      await isar.adelantoIsarModels.put(modelo);
    }, mensajeError: 'Error al guardar adelanto');
  }

  @override
  Future<Either<Fallo, void>> eliminarAdelanto(String id) async {
    final idInt = int.tryParse(id);
    if (idInt == null) return const Left(FalloBaseDatos('ID no válido'));

    return ejecutarEscritura(() async {
      await isar.adelantoIsarModels.delete(idInt);
    }, mensajeError: 'Error al eliminar adelanto');
  }

  @override
  Future<Map<int, double>> obtenerTotalAdelantosPendientesPorTrabajador(int fincaId) async {
    // Nota: Este método no usa ejecutarLectura porque devuelve un Map, 
    // pero internamente delegamos a Isar las sumas pesadas.
    final tIds = await isar.adelantoIsarModels
        .filter()
        .fincaIdEqualTo(fincaId)
        .pagadoEqualTo(false)
        .trabajadorIdProperty()
        .findAll();
    
    final tIdsUnicos = tIds.toSet();
    final mapa = <int, double>{};

    for (final id in tIdsUnicos) {
      final suma = await isar.adelantoIsarModels
          .filter()
          .fincaIdEqualTo(fincaId)
          .trabajadorIdEqualTo(id)
          .pagadoEqualTo(false)
          .montoProperty()
          .sum();
      mapa[id] = suma;
    }
    return mapa;
  }
}

@riverpod
RepositorioTrabajadores repositorioTrabajadores(RepositorioTrabajadoresRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioTrabajadoresImpl(isar);
}
