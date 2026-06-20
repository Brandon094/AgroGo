import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_fincas.dart';
import '../../domain/finca_model.dart';

part 'fincas_notifier.g.dart';

@riverpod
class FincasNotifier extends _$FincasNotifier {
  @override
  FutureOr<List<FincaEntity>> build() async {
    final repo = ref.watch(repositorioFincasProvider);
    final res = await repo.obtenerFincas();
    return res.fold(
      (f) => throw Exception(f.mensaje),
      (l) => l,
    );
  }

  Future<void> agregarFinca({
    required String nombre,
    String? vereda,
    double? area,
  }) async {
    state = const AsyncValue.loading();
    final repo = ref.read(repositorioFincasProvider);
    final nueva = FincaEntity(id: '', nombre: nombre, veredaUbicacion: vereda, areaTotalHectareas: area);
    final res = await repo.guardarFinca(nueva);
    res.fold(
      (f) => state = AsyncValue.error(f.mensaje, StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

/// Provider para mantener el ID de la finca seleccionada actualmente
@Riverpod(keepAlive: true)
class FincaSeleccionada extends _$FincaSeleccionada {
  @override
  String? build() => null;

  void seleccionar(String id) => state = id;
  void deseleccionar() => state = null;
  void limpiarFinca() => state = null;
}

@riverpod
Future<FincaEntity?> fincaActual(FincaActualRef ref) async {
  final id = ref.watch(fincaSeleccionadaProvider);
  if (id == null) return null;
  
  final fincas = await ref.watch(fincasNotifierProvider.future);
  return fincas.firstWhere((f) => f.id == id);
}
