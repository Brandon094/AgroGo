import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_pecuario.dart';
import '../../domain/entidades_pecuario.dart';
import '../../../farm_calendar/presentation/providers/cronograma_notifier.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';

part 'especie_detalle_notifier.g.dart';

class EspecieDetalleState {
  final List<ControlSanitarioEntity> controles;
  final List<AlimentacionEntity> alimentacion;
  final bool cargando;

  EspecieDetalleState({
    required this.controles,
    required this.alimentacion,
    this.cargando = false,
  });
}

@riverpod
class EspecieDetalle extends _$EspecieDetalle {
  @override
  FutureOr<EspecieDetalleState> build(String especieId) async {
    final repo = ref.watch(repositorioPecuarioProvider);
    
    final resControles = await repo.obtenerControlesPorEspecie(especieId);
    final resAlimentacion = await repo.obtenerAlimentacionPorEspecie(especieId);

    return EspecieDetalleState(
      controles: resControles.getOrElse(() => []),
      alimentacion: resAlimentacion.getOrElse(() => []),
    );
  }

  Future<void> registrarSalud({
    required String tipo,
    required String producto,
    required DateTime fecha,
    DateTime? proxima,
    required String nombreEspecie,
  }) async {
    state = const AsyncValue.loading();
    final repo = ref.read(repositorioPecuarioProvider);
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    
    final nuevoControl = ControlSanitarioEntity(
      id: '',
      fincaId: fincaIdStr,
      especieId: especieId,
      tipo: tipo,
      producto: producto,
      fechaAplicacion: fecha,
      proximaDosis: proxima ?? fecha.add(const Duration(days: 90)),
    );

    await repo.guardarControlSanitario(nuevoControl);

    // Si hay próxima dosis, agendar en el calendario automáticamente
    if (proxima != null) {
      await ref.read(cronogramaNotifierProvider.notifier).agregarTarea(
        titulo: '$tipo: $nombreEspecie ($producto)',
        tipoActividad: 'Sanidad Animal',
        fechaInicio: proxima,
        fechaFinEstimada: proxima.add(const Duration(days: 1)),
      );
    }

    ref.invalidateSelf();
  }

  Future<void> registrarComida({
    required String producto,
    required double kilos,
  }) async {
    state = const AsyncValue.loading();
    final repo = ref.read(repositorioPecuarioProvider);
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);

    final nuevaAlimentacion = AlimentacionEntity(
      id: '',
      fincaId: fincaIdStr,
      especieId: especieId,
      producto: producto,
      cantidadKilos: kilos,
      fecha: DateTime.now(),
    );

    await repo.guardarAlimentacion(nuevaAlimentacion);
    ref.invalidateSelf();
  }
}
