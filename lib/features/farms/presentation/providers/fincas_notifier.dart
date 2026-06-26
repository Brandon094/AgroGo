import 'package:dartz/dartz.dart';
import '../../../../core/errors/fallos.dart';
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

  Future<Either<Fallo, String>> agregarFinca({
    required String nombre,
    String? vereda,
    double? area,
  }) async {
    final repo = ref.read(repositorioFincasProvider);
    final nueva = FincaEntity(id: '', nombre: nombre, veredaUbicacion: vereda, areaTotalHectareas: area);
    final res = await repo.guardarFinca(nueva);
    
    return res.fold(
      (f) => Left(f),
      (id) {
        ref.invalidateSelf();
        return Right(id);
      },
    );
  }

  Future<Either<Fallo, void>> eliminarFinca(String id) async {
    final repo = ref.read(repositorioFincasProvider);
    final res = await repo.eliminarFinca(id);
    
    return res.fold(
      (f) => Left(f),
      (_) {
        ref.invalidateSelf();
        return const Right(null);
      },
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
