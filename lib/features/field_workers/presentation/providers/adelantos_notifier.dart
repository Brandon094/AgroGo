import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_trabajadores.dart';
import '../../domain/adelanto_model.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';

part 'adelantos_notifier.g.dart';

@riverpod
class AdelantosNotifier extends _$AdelantosNotifier {
  @override
  FutureOr<List<AdelantoEntity>> build() async {
    final fincaIdStr = ref.watch(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return [];

    final fincaId = int.parse(fincaIdStr);
    final repositorio = ref.watch(repositorioTrabajadoresProvider);
    final resultado = await repositorio.obtenerAdelantos(fincaId: fincaId);
    return resultado.fold(
      (fallo) => throw Exception(fallo.mensaje),
      (adelantos) => adelantos,
    );
  }

  Future<void> agregarAdelanto({
    required String trabajadorId,
    required double monto,
    String? motivo,
  }) async {
    state = const AsyncValue.loading();
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);

    final nuevo = AdelantoEntity(
      id: '',
      fincaId: fincaIdStr,
      trabajadorId: trabajadorId,
      monto: monto,
      fecha: DateTime.now(),
      motivo: motivo,
      pagado: false,
    );

    final repositorio = ref.read(repositorioTrabajadoresProvider);
    final resultado = await repositorio.guardarAdelanto(nuevo);
    resultado.fold(
      (fallo) => state = AsyncValue.error(Exception(fallo.mensaje), StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> marcarComoPagado(String id) async {
    final adelantos = state.valueOrNull ?? [];
    final adelanto = adelantos.firstWhere((a) => a.id == id);
    
    final actualizado = adelanto.copyWith(pagado: true);
    
    final repositorio = ref.read(repositorioTrabajadoresProvider);
    await repositorio.guardarAdelanto(actualizado);
    ref.invalidateSelf();
  }

  Future<void> eliminarAdelanto(String id) async {
    state = const AsyncValue.loading();
    final repositorio = ref.read(repositorioTrabajadoresProvider);
    final resultado = await repositorio.eliminarAdelanto(id);
    resultado.fold(
      (fallo) => state = AsyncValue.error(Exception(fallo.mensaje), StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }
}
