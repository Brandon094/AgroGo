import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../main.dart'; 
import '../domain/tarea_model.dart';
import 'tarea_isar_model.dart';

part 'repositorio_calendar.g.dart';

abstract class RepositorioCalendar {
  Future<Either<Fallo, List<TareaEntity>>> obtenerTareas({int? fincaId});
  Future<Either<Fallo, void>> guardarTarea(TareaEntity tarea);
  Future<Either<Fallo, void>> eliminarTarea(String id);
}

class RepositorioCalendarImpl implements RepositorioCalendar {
  final Isar isar;
  RepositorioCalendarImpl(this.isar);

  @override
  Future<Either<Fallo, List<TareaEntity>>> obtenerTareas({int? fincaId}) async {
    try {
      final query = isar.tareaIsarModels.where();
      final tareasIsar = fincaId != null 
          ? await query.filter().fincaIdEqualTo(fincaId).findAll()
          : await query.findAll();
      
      final entidades = tareasIsar.map((m) => m.toEntity()).toList()
        ..sort((a, b) => a.fechaInicio.compareTo(b.fechaInicio));
        
      return Right(entidades);
    } catch (e) {
      return Left(FalloBaseDatos('Error al obtener la agenda', e));
    }
  }

  @override
  Future<Either<Fallo, void>> guardarTarea(TareaEntity tarea) async {
    try {
      final modelo = TareaIsarModel.fromEntity(tarea);
      await isar.writeTxn(() async => await isar.tareaIsarModels.put(modelo));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al guardar la tarea', e));
    }
  }

  @override
  Future<Either<Fallo, void>> eliminarTarea(String id) async {
    try {
      final idInt = int.tryParse(id);
      if (idInt == null) return Left(FalloBaseDatos('ID no válido: $id'));
      await isar.writeTxn(() async => await isar.tareaIsarModels.delete(idInt));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al eliminar la tarea', e));
    }
  }
}

@riverpod
RepositorioCalendar repositorioCalendar(RepositorioCalendarRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioCalendarImpl(isar);
}
