import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_pecuario.dart';
import '../../domain/entidades_pecuario.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';

part 'pecuario_notifier.g.dart';

@riverpod
class PecuarioNotifier extends _$PecuarioNotifier {
  @override
  FutureOr<List<EspecieEntity>> build() async {
    final fincaIdStr = ref.watch(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return [];

    final fincaId = int.parse(fincaIdStr);
    final repositorio = ref.watch(repositorioPecuarioProvider);
    final resultado = await repositorio.obtenerEspecies(fincaId: fincaId);
    return resultado.fold(
      (fallo) => throw Exception(fallo.mensaje),
      (especies) => especies,
    );
  }

  Future<void> agregarEspecie({
    required String nombre,
    required String tipoEspecie,
    required int cantidadActual,
    String? loteId,
  }) async {
    state = const AsyncValue.loading();
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    
    final nuevaEspecie = EspecieEntity(
      id: '',
      fincaId: fincaIdStr,
      nombre: nombre,
      tipoEspecie: tipoEspecie,
      cantidadActual: cantidadActual,
      loteId: loteId,
    );

    final repositorio = ref.read(repositorioPecuarioProvider);
    final resultado = await repositorio.guardarEspecie(nuevaEspecie);
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
