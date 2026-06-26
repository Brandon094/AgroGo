import 'package:dartz/dartz.dart';
import '../../../../core/errors/fallos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_insumos.dart';
import '../../domain/insumo_model.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';

part 'insumos_notifier.g.dart';

@riverpod
class InsumosNotifier extends _$InsumosNotifier {
  @override
  FutureOr<List<InsumoEntity>> build() async {
    final fincaIdStr = ref.watch(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return [];

    final fincaId = int.parse(fincaIdStr);
    final repositorio = ref.watch(repositorioInsumosProvider);
    final resultado = await repositorio.obtenerInsumos(fincaId: fincaId);
    return resultado.fold(
      (f) => throw Exception(f.mensaje),
      (l) => l,
    );
  }

  Future<Either<Fallo, void>> registrarInsumo({
    required String nombre,
    required String unidad,
    required double stockInicial,
    double umbral = 1.0,
    CategoriaInsumo categoria = CategoriaInsumo.operativo,
    bool esParaSecado = false,
    double valorUnitario = 0.0,
    String? loteId,
    String? beneficioId,
  }) async {
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);

    final nuevo = InsumoEntity(
      id: '',
      fincaId: fincaIdStr,
      nombre: nombre,
      unidadMedida: unidad,
      cantidadActual: stockInicial,
      umbralMinimo: umbral,
      categoria: categoria,
      esParaSecado: esParaSecado,
      valorUnitario: valorUnitario,
      valorTotal: stockInicial * valorUnitario,
      loteId: loteId,
      beneficioId: beneficioId,
    );

    final repo = ref.read(repositorioInsumosProvider);
    final res = await repo.guardarInsumo(nuevo);
    
    return res.fold(
      (f) => Left(f),
      (_) {
        ref.invalidateSelf();
        return const Right(null);
      },
    );
  }

  Future<Either<Fallo, void>> ajustarStock(String id, double cantidadCambio) async {
    final repo = ref.read(repositorioInsumosProvider);
    final res = await repo.actualizarStock(id, cantidadCambio);
    
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
