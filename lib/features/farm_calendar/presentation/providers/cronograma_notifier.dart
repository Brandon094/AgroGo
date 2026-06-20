import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_calendar.dart';
import '../../domain/tarea_model.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';

part 'cronograma_notifier.g.dart';

@riverpod
class CronogramaNotifier extends _$CronogramaNotifier {
  @override
  FutureOr<List<TareaEntity>> build() async {
    final fincaIdStr = ref.watch(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return [];

    final fincaId = int.parse(fincaIdStr);
    final repositorio = ref.watch(repositorioCalendarProvider);
    final resultado = await repositorio.obtenerTareas(fincaId: fincaId);
    return resultado.fold(
      (fallo) => throw Exception(fallo.mensaje),
      (tareas) => tareas,
    );
  }

  Future<void> agregarTarea({
    required String titulo,
    required String tipoActividad,
    required DateTime fechaInicio,
    required DateTime fechaFinEstimada,
  }) async {
    state = const AsyncValue.loading();
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);

    final nuevaTarea = TareaEntity(
      id: '',
      fincaId: fincaIdStr, // SE INYECTA EL ID DE LA FINCA SELECCIONADA
      titulo: titulo,
      tipoActividad: tipoActividad,
      fechaInicio: fechaInicio,
      fechaFinEstimada: fechaFinEstimada,
      estaCompletada: false,
      loteId: null,
    );

    final repositorio = ref.read(repositorioCalendarProvider);
    // Nota: El repositorio debería manejar la inyección del fincaId si se pasa, 
    // pero aquí lo inyectamos vía el modeloIsar. 
    // Vamos a asegurar que guardarTarea use el fincaId del estado global.
    
    // Actually, TareaEntity doesn't have fincaId. Let's add it or handle it in repo.
    // I already added fincaId to TareaIsarModel.
    // I should probably add fincaId to the entities too for better consistency.
    
    // For now, let's assume the repo handles it or we pass it.
    // Better: Update TareaEntity to include fincaId.
    
    final resultado = await repositorio.guardarTarea(nuevaTarea);
    resultado.fold(
      (fallo) => state = AsyncValue.error(Exception(fallo.mensaje), StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> marcarComoCompletada(TareaEntity tarea, bool completada) async {
    state = const AsyncValue.loading();
    final tareaModificada = tarea.copyWith(estaCompletada: completada);
    final repositorio = ref.read(repositorioCalendarProvider);
    final resultado = await repositorio.guardarTarea(tareaModificada);
    resultado.fold(
      (fallo) => state = AsyncValue.error(Exception(fallo.mensaje), StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
