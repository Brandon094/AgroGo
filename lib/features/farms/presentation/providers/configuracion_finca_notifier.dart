import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_fincas.dart';
import '../../domain/configuracion_finca_model.dart';
import 'fincas_notifier.dart';

part 'configuracion_finca_notifier.g.dart';

@riverpod
class ConfiguracionFincaNotifier extends _$ConfiguracionFincaNotifier {
  @override
  FutureOr<ConfiguracionFinca> build() async {
    final fincaIdStr = ref.watch(fincaSeleccionadaProvider);
    if (fincaIdStr == null) throw Exception('Finca no seleccionada');

    final fincaId = int.parse(fincaIdStr);
    final repositorio = ref.watch(repositorioFincasProvider);
    
    final resultado = await repositorio.obtenerConfiguracion(fincaId);
    return resultado.fold(
      (fallo) => throw Exception(fallo.mensaje),
      (config) => config,
    );
  }

  Future<void> actualizarCostoAlimentacion(double nuevoCosto) async {
    final configActual = state.valueOrNull;
    if (configActual == null) return;

    final nuevaConfig = configActual.copyWith(costoAlimentacion: nuevoCosto);
    
    final repositorio = ref.read(repositorioFincasProvider);
    final resultado = await repositorio.guardarConfiguracion(nuevaConfig);
    
    resultado.fold(
      (fallo) => state = AsyncValue.error(Exception(fallo.mensaje), StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }
}
