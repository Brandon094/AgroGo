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

  Future<void> registrarInsumo({
    required String nombre,
    required String unidad,
    required double stockInicial,
    double umbral = 1.0,
    CategoriaInsumo categoria = CategoriaInsumo.operativo,
    bool esParaSecado = false,
    double valorUnitario = 0.0,
  }) async {
    state = const AsyncValue.loading();
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
    );

    final repo = ref.read(repositorioInsumosProvider);
    await repo.guardarInsumo(nuevo);
    ref.invalidateSelf();
  }

  Future<void> ajustarStock(String id, double cantidadCambio) async {
    final repo = ref.read(repositorioInsumosProvider);
    await repo.actualizarStock(id, cantidadCambio);
    ref.invalidateSelf();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
