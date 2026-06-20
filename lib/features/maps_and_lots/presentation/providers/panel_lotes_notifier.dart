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

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
