import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_trabajadores.dart';
import '../../domain/trabajador_model.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';

part 'trabajadores_notifier.g.dart';

@riverpod
class TrabajadoresNotifier extends _$TrabajadoresNotifier {
  @override
  FutureOr<List<TrabajadorEntity>> build() async {
    final fincaIdStr = ref.watch(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return [];

    final fincaId = int.parse(fincaIdStr);
    final repositorio = ref.watch(repositorioTrabajadoresProvider);
    final resultado = await repositorio.obtenerTrabajadores(fincaId: fincaId);
    return resultado.fold(
      (fallo) => throw Exception(fallo.mensaje),
      (trabajadores) => trabajadores,
    );
  }

  Future<void> agregarTrabajador({
    required String nombreCompleto,
    required String tipoTrabajador,
    required double tarifaBase,
  }) async {
    state = const AsyncValue.loading();
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    
    final nuevoTrabajador = TrabajadorEntity(
      id: '',
      fincaId: fincaIdStr,
      nombreCompleto: nombreCompleto,
      tipoTrabajador: tipoTrabajador,
      tarifaBase: tarifaBase,
      fechaIngreso: DateTime.now(),
    );

    final repositorio = ref.read(repositorioTrabajadoresProvider);
    final resultado = await repositorio.guardarTrabajador(nuevoTrabajador);

    resultado.fold(
      (fallo) => state = AsyncValue.error(Exception(fallo.mensaje), StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> eliminarTrabajador(String id) async {
    state = const AsyncValue.loading();
    final repositorio = ref.read(repositorioTrabajadoresProvider);
    final resultado = await repositorio.eliminarTrabajador(id);
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
