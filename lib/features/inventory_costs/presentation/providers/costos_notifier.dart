import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_costos.dart';
import '../../domain/item_costo_model.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';

part 'costos_notifier.g.dart';

@riverpod
class CostosNotifier extends _$CostosNotifier {
  @override
  FutureOr<List<ItemCostoEntity>> build() async {
    final fincaIdStr = ref.watch(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return [];

    final fincaId = int.parse(fincaIdStr);
    final repositorio = ref.watch(repositorioCostosProvider);
    final resultado = await repositorio.obtenerCostos(fincaId: fincaId);
    return resultado.fold(
      (fallo) => throw Exception(fallo.mensaje),
      (costos) => costos,
    );
  }

  double obtenerTotalAcumulado() {
    final costos = state.valueOrNull ?? [];
    return costos.fold(0.0, (suma, c) => suma + c.precioTotal);
  }

  Future<void> agregarCosto({
    required String nombreItem,
    required String categoria,
    required double precioTotal,
    String? loteId,
  }) async {
    state = const AsyncValue.loading();
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);

    final nuevoCosto = ItemCostoEntity(
      id: '',
      fincaId: fincaIdStr,
      nombreItem: nombreItem,
      categoria: categoria,
      precioTotal: precioTotal,
      fechaCompra: DateTime.now(),
      loteId: loteId,
    );

    final repositorio = ref.read(repositorioCostosProvider);
    final resultado = await repositorio.guardarCosto(nuevoCosto);
    resultado.fold(
      (fallo) => state = AsyncValue.error(Exception(fallo.mensaje), StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> eliminarCosto(String id) async {
    state = const AsyncValue.loading();
    final repositorio = ref.read(repositorioCostosProvider);
    final resultado = await repositorio.eliminarCosto(id);
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
