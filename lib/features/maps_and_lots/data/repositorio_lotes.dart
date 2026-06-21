import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/errors/fallos.dart';
import '../../../main.dart';
import '../domain/lote_model.dart';
import 'lote_isar_model.dart';
import '../../farm_calendar/data/tarea_isar_model.dart';

part 'repositorio_lotes.g.dart';

@riverpod
RepositorioLotes repositorioLotes(RepositorioLotesRef ref) {
  final isar = ref.watch(isarProvider);
  return RepositorioLotesImpl(isar);
}

abstract class RepositorioLotes {
  Future<Either<Fallo, List<Lote>>> obtenerLotes({int? fincaId});
  Future<Either<Fallo, void>> guardarLote(Lote lote);
  Future<Either<Fallo, void>> guardarLoteCompleto({
    required Lote lote,
    required Map<String, DateTime?> fechasCronograma,
    int mesesFrecuenciaAbono = 3,
    int mesesFrecuenciaFumiga = 4,
  });
  Future<Either<Fallo, void>> eliminarLote(String id);
}

class RepositorioLotesImpl implements RepositorioLotes {
  final Isar isar;
  RepositorioLotesImpl(this.isar);

  @override
  Future<Either<Fallo, List<Lote>>> obtenerLotes({int? fincaId}) async {
    try {
      final query = isar.loteIsarModels.where();
      final lotesIsar = fincaId != null 
          ? await query.filter().fincaIdEqualTo(fincaId).findAll()
          : await query.findAll();
          
      return Right(lotesIsar.map((l) => l.toEntity()).toList());
    } catch (e) {
      return Left(FalloBaseDatos('Error al obtener los lotes', e));
    }
  }

  @override
  Future<Either<Fallo, void>> guardarLote(Lote lote) async {
    try {
      final modelo = LoteIsarModel.fromEntity(lote);
      await isar.writeTxn(() async => await isar.loteIsarModels.put(modelo));
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al guardar el lote', e));
    }
  }

  @override
  Future<Either<Fallo, void>> guardarLoteCompleto({
    required Lote lote,
    required Map<String, DateTime?> fechasCronograma,
    int mesesFrecuenciaAbono = 3,
    int mesesFrecuenciaFumiga = 4,
  }) async {
    try {
      await isar.writeTxn(() async {
        final modeloLote = LoteIsarModel.fromEntity(lote);
        final idLote = await isar.loteIsarModels.put(modeloLote);

        final List<TareaIsarModel> tareasNuevas = [];
        
        fechasCronograma.forEach((tipo, fecha) {
          if (fecha != null) {
            if (tipo == 'Próxima Abonada') {
              // Generar ciclos de abono (4 al año)
              for (int i = 0; i < 4; i++) {
                final fechaTarea = DateTime(fecha.year, fecha.month + (i * mesesFrecuenciaAbono), fecha.day);
                tareasNuevas.add(TareaIsarModel()
                  ..titulo = i == 0 ? 'Abonada Inicial: ${lote.nombre}' : 'Abonada de Refuerzo: ${lote.nombre}'
                  ..tipoActividad = 'Abonado'
                  ..fechaInicio = fechaTarea
                  ..fechaFinEstimada = fechaTarea.add(const Duration(days: 2))
                  ..estaCompletada = false
                  ..loteId = idLote
                  ..fincaId = modeloLote.fincaId);
              }
            } else if (tipo == 'Próxima Fumigación') {
              // Generar ciclos de fumigación (3-4 al año según frecuencia)
              int numCiclos = (12 / mesesFrecuenciaFumiga).floor();
              for (int i = 0; i < numCiclos; i++) {
                final fechaTarea = DateTime(fecha.year, fecha.month + (i * mesesFrecuenciaFumiga), fecha.day);
                tareasNuevas.add(TareaIsarModel()
                  ..titulo = i == 0 ? 'Fumigación Inicial: ${lote.nombre}' : 'Fumigación de Ciclo: ${lote.nombre}'
                  ..tipoActividad = 'Fumigación'
                  ..fechaInicio = fechaTarea
                  ..fechaFinEstimada = fechaTarea.add(const Duration(days: 2))
                  ..estaCompletada = false
                  ..loteId = idLote
                  ..fincaId = modeloLote.fincaId);
              }
            } else {
              // Cosechas y otros son eventos únicos
              tareasNuevas.add(TareaIsarModel()
                ..titulo = '$tipo: ${lote.nombre}'
                ..tipoActividad = _mapearTipoActividad(tipo)
                ..fechaInicio = fecha
                ..fechaFinEstimada = fecha.add(const Duration(days: 2))
                ..estaCompletada = false
                ..loteId = idLote
                ..fincaId = modeloLote.fincaId);
            }
          }
        });

        if (tareasNuevas.isNotEmpty) {
          await isar.tareaIsarModels.putAll(tareasNuevas);
        }
      });
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error en la transacción', e));
    }
  }

  @override
  Future<Either<Fallo, void>> eliminarLote(String id) async {
    try {
      final idInt = int.parse(id);
      await isar.writeTxn(() async {
        await isar.loteIsarModels.delete(idInt);
        // Opcional: Eliminar tareas asociadas a este lote
        await isar.tareaIsarModels.filter().loteIdEqualTo(idInt).deleteAll();
      });
      return const Right(null);
    } catch (e) {
      return Left(FalloBaseDatos('Error al eliminar lote', e));
    }
  }

  String _mapearTipoActividad(String clave) {
    switch (clave) {
      case 'Próxima Abonada': return 'Abonado';
      case 'Cosecha Principal': return 'Cosecha';
      case 'Temporada Mitaca': return 'Cosecha';
      case 'Próxima Fumigación': return 'Fumigación';
      case 'Próxima Guadañada': return 'Guadañada';
      default: return 'General';
    }
  }
}
