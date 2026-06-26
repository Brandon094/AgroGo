import 'package:agrogo/features/livestock/presentation/providers/pecuario_notifier.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositorio_pecuario.dart';
import '../../domain/entidades_pecuario.dart';
import '../../../farm_calendar/presentation/providers/cronograma_notifier.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';
import '../../../inventory_management/presentation/providers/insumos_notifier.dart';
import '../../../inventory_costs/presentation/providers/costos_notifier.dart';

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
    String? insumoId,
    double cantidadInsumo = 0.0,
  }) async {
    state = const AsyncValue.loading();
    final repo = ref.read(repositorioPecuarioProvider);
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    
    double costoCalculado = 0.0;
    if (insumoId != null && cantidadInsumo > 0) {
      final insumos = ref.read(insumosNotifierProvider).valueOrNull ?? [];
      final insumo = insumos.firstWhere((i) => i.id == insumoId);
      costoCalculado = cantidadInsumo * insumo.valorUnitario;
      
      await ref.read(insumosNotifierProvider.notifier).ajustarStock(insumoId, -cantidadInsumo);
    }

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

    // Registrar como gasto en finanzas
    if (costoCalculado > 0) {
      await ref.read(costosNotifierProvider.notifier).agregarCosto(
        nombre: 'Salud ($tipo): $producto (Lote: $especieId)', 
        categoria: 'Pecuario', 
        precioTotal: costoCalculado,
      );
    }

    // Actualizar costo acumulado en la especie si hubo gasto
    if (costoCalculado > 0) {
      final pecuarioNotifier = ref.read(pecuarioNotifierProvider.notifier);
      final especies = ref.read(pecuarioNotifierProvider).valueOrNull ?? [];
      final especieActual = especies.firstWhere((e) => e.id == especieId);
      
      final especieActualizada = especieActual.copyWith(
        costoInsumosAcumulado: especieActual.costoInsumosAcumulado + costoCalculado,
      );
      await pecuarioNotifier.actualizarEspecie(especieActualizada);
    }

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
    String? insumoId,
  }) async {
    state = const AsyncValue.loading();
    final repo = ref.read(repositorioPecuarioProvider);
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);

    double costoCalculado = 0.0;
    if (insumoId != null) {
      final insumos = ref.read(insumosNotifierProvider).valueOrNull ?? [];
      final insumo = insumos.firstWhere((i) => i.id == insumoId);
      costoCalculado = kilos * insumo.valorUnitario;
      
      await ref.read(insumosNotifierProvider.notifier).ajustarStock(insumoId, -kilos);
    }

    final nuevaAlimentacion = AlimentacionEntity(
      id: '',
      fincaId: fincaIdStr,
      especieId: especieId,
      producto: producto,
      cantidadKilos: kilos,
      fecha: DateTime.now(),
      costoAsociado: costoCalculado,
    );

    await repo.guardarAlimentacion(nuevaAlimentacion);

    // Registrar como gasto en finanzas
    if (costoCalculado > 0) {
      await ref.read(costosNotifierProvider.notifier).agregarCosto(
        nombre: 'Alimento: $producto (Lote: $especieId)', 
        categoria: 'Pecuario', 
        precioTotal: costoCalculado,
      );
    }

    // Actualizar costo acumulado en la especie
    final pecuarioNotifier = ref.read(pecuarioNotifierProvider.notifier);
    final especies = ref.read(pecuarioNotifierProvider).valueOrNull ?? [];
    final especieActual = especies.firstWhere((e) => e.id == especieId);
    
    final especieActualizada = especieActual.copyWith(
      costoInsumosAcumulado: especieActual.costoInsumosAcumulado + costoCalculado,
    );
    await pecuarioNotifier.actualizarEspecie(especieActualizada);

    ref.invalidateSelf();
  }

  Future<void> registrarSalidaPecuaria({
    required TipoSalidaPecuaria tipo,
    required int cantidadASacar,
    required double kilos,
    required double precioTotal,
  }) async {
    state = const AsyncValue.loading();
    final pecuarioNotifier = ref.read(pecuarioNotifierProvider.notifier);
    final especies = ref.read(pecuarioNotifierProvider).valueOrNull ?? [];
    final especieActual = especies.firstWhere((e) => e.id == especieId);

    // Prorrateo: Calcular costo proporcional de los animales que salen
    final costoUnitario = especieActual.costoUnitarioActual;
    final costoProporcionalSalida = cantidadASacar * (especieActual.valorUnitario + (especieActual.costoInsumosAcumulado / especieActual.cantidadActual));
    
    // El costo de insumos que se "lleva" la tanda que sale
    final insumoProporcional = (especieActual.costoInsumosAcumulado / especieActual.cantidadActual) * cantidadASacar;

    final nuevaCantidadActual = especieActual.cantidadActual - cantidadASacar;
    final esCierreTotal = nuevaCantidadActual <= 0;

    final especieActualizada = especieActual.copyWith(
      cantidadActual: nuevaCantidadActual,
      estaActivo: !esCierreTotal,
      fechaSalida: DateTime.now(), // Se registra como la última salida
      tipoSalida: tipo,
      kilosSalida: kilos,
      precioVentaTotal: precioTotal,
      costoInsumosAcumulado: especieActual.costoInsumosAcumulado - insumoProporcional,
      utilidadesGeneradas: especieActual.utilidadesGeneradas + (precioTotal - costoProporcionalSalida),
    );

    await pecuarioNotifier.actualizarEspecie(especieActualizada);
    
    // Inyectar el ingreso al balance financiero general
    if (precioTotal > 0) {
      await ref.read(costosNotifierProvider.notifier).agregarIngreso(
        nombre: 'Venta Pecuaria (${cantidadASacar} ${especieActual.tipoEspecie}): ${especieActual.nombre}',
        categoria: 'Pecuario', 
        monto: precioTotal,
        loteId: especieActual.loteId,
      );
    }

    ref.invalidateSelf();
  }
}
