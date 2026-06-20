import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_lotes.dart';
import '../../domain/lote_model.dart';

part 'lotes_globales_provider.g.dart';

@riverpod
Future<List<Lote>> lotesGlobales(LotesGlobalesRef ref) async {
  final repositorio = ref.watch(repositorioLotesProvider);
  final resultado = await repositorio.obtenerLotes(); // Sin filtro de fincaId

  return resultado.fold(
    (fallo) => throw Exception(fallo.mensaje),
    (lotes) => lotes,
  );
}
