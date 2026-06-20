import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../main.dart';
import '../../data/registro_labor_isar_model.dart';
import '../../../inventory_costs/data/item_costo_isar_model.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';
import '../../../inventory_costs/presentation/providers/costos_notifier.dart';

part 'gestion_administrativa_orchestrator.g.dart';

@riverpod
class GestionAdministrativaOrchestrator extends _$GestionAdministrativaOrchestrator {
  @override
  void build() {}

  /// Liquida la labor del día y genera los asientos contables cruzados.
  Future<void> liquidarLaborDiaria({
    required int trabajadorId,
    required int loteId,
    required String tipoPago,
    double? kilos,
    required double tarifaBase,
    required bool conAlimentacion,
  }) async {
    final isar = ref.read(isarProvider);
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return;
    final fincaId = int.parse(fincaIdStr);

    const double COSTO_ALIMENTACION = 15000;

    await isar.writeTxn(() async {
      // 1. Calcular el pago neto del trabajador
      final totalPagar = RegistroLaborIsarModel.calcularPago(
        tipo: tipoPago,
        kilos: kilos,
        tarifaBase: tarifaBase,
        conAlimentacion: conAlimentacion,
        costoComida: COSTO_ALIMENTACION,
      );

      // 2. Registrar la labor en nómina
      final registro = RegistroLaborIsarModel()
        ..fincaId = fincaId
        ..trabajadorId = trabajadorId
        ..loteId = loteId
        ..fechaRegistro = DateTime.now()
        ..tipoPago = tipoPago
        ..cantidadKilos = kilos
        ..incluyeAlimentacion = conAlimentacion
        ..totalPagar = totalPagar;
      
      await isar.registroLaborIsarModels.put(registro);

      // 3. Si hubo alimentación, inyectar el gasto en el módulo financiero
      if (conAlimentacion) {
        final gastoComida = ItemCostoIsarModel()
          ..fincaId = fincaId
          ..loteId = loteId
          ..nombreItem = 'Alimentación Trabajador (Descuento Nómina)'
          ..categoria = 'Operativos'
          ..precioTotal = COSTO_ALIMENTACION
          ..fechaCompra = DateTime.now();
        
        await isar.itemCostoIsarModels.put(gastoComida);
      }
    });

    // Invalida los costos para que el dashboard se actualice si hubo alimentación
    if (conAlimentacion) {
      ref.invalidate(costosNotifierProvider);
    }
  }

  /// Obtiene el total acumulado por un trabajador en la semana actual.
  Future<double> obtenerLiquidacionSemanal(int trabajadorId) async {
    final isar = ref.read(isarProvider);
    final hoy = DateTime.now();
    // Calcular el lunes de esta semana
    final inicioSemana = hoy.subtract(Duration(days: hoy.weekday - 1));
    final fechaLunes = DateTime(inicioSemana.year, inicioSemana.month, inicioSemana.day);

    final labores = await isar.registroLaborIsarModels
        .filter()
        .trabajadorIdEqualTo(trabajadorId)
        .fechaRegistroGreaterThan(fechaLunes)
        .findAll();

    return labores.fold<double>(0.0, (sum, labor) => sum + labor.totalPagar);
  }

  /// PROYECCIÓN FASE 3: Interoperabilidad con ServiCarga
  /// Este método conectará AgroGo con la plataforma de transporte logístico.
  Future<void> solicitarTransporteLogistico({
    required String cargaNombre,
    required double cantidadBultos,
  }) async {
    // TODO: Implementar url_launcher
    // final fincaId = ref.read(fincaSeleccionadaProvider);
    // final url = 'https://servicarga.web.app/solicitar?origen=$fincaId&carga=$cargaNombre&cantidad=$cantidadBultos';
    
    // ignore: avoid_print
    print('LOGÍSTICA: Simulando solicitud a ServiCarga para $cantidadBultos bultos de $cargaNombre');
  }
}
