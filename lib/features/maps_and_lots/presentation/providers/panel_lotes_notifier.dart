import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_lotes.dart';
import '../../domain/lote_model.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';

part 'panel_lotes_notifier.g.dart';

@riverpod
class PanelLotesNotifier extends _$PanelLotesNotifier {
  @override
  FutureOr<List<Lote>> build() async {
    final fincaIdStr = ref.watch(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return [];

    final fincaId = int.parse(fincaIdStr);
    final repositorio = ref.watch(repositorioLotesProvider);
    final resultado = await repositorio.obtenerLotes(fincaId: fincaId);

    return resultado.fold(
      (fallo) => throw Exception(fallo.mensaje),
      (lotes) => lotes,
    );
  }

  Future<void> eliminarLote(String id) async {
    state = const AsyncValue.loading();
    final repositorio = ref.read(repositorioLotesProvider);
    final resultado = await repositorio.eliminarLote(id);
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
