import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../main.dart';
import '../../data/registro_labor_isar_model.dart';
import '../../data/adelanto_isar_model.dart';
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

  /// Obtiene el resumen de nómina de todos los trabajadores para la semana actual.
  Future<List<ResumenTrabajadorNomina>> obtenerResumenNominaSemanal() async {
    final isar = ref.read(isarProvider);
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return [];
    final fincaId = int.parse(fincaIdStr);

    final hoy = DateTime.now();
    final inicioSemana = hoy.subtract(Duration(days: hoy.weekday - 1));
    final fechaLunes = DateTime(inicioSemana.year, inicioSemana.month, inicioSemana.day);

    final labores = await isar.registroLaborIsarModels
        .filter()
        .fincaIdEqualTo(fincaId)
        .fechaRegistroGreaterThan(fechaLunes)
        .findAll();

    // Obtener adelantos no pagados
    final adelantos = await isar.adelantoIsarModels
        .filter()
        .fincaIdEqualTo(fincaId)
        .pagadoEqualTo(false)
        .findAll();

    // Agrupar por trabajador
    final mapaResumen = <int, _AcumuladoNomina>{};
    for (final labor in labores) {
      final actual = mapaResumen[labor.trabajadorId] ?? _AcumuladoNomina();
      mapaResumen[labor.trabajadorId] = _AcumuladoNomina(
        totalPagar: actual.totalPagar + labor.totalPagar,
        totalKilos: actual.totalKilos + (labor.cantidadKilos ?? 0.0),
        totalAdelantos: actual.totalAdelantos,
      );
    }

    for (final adelanto in adelantos) {
      final actual = mapaResumen[adelanto.trabajadorId] ?? _AcumuladoNomina();
      mapaResumen[adelanto.trabajadorId] = _AcumuladoNomina(
        totalPagar: actual.totalPagar,
        totalKilos: actual.totalKilos,
        totalAdelantos: actual.totalAdelantos + adelanto.monto,
      );
    }

    return mapaResumen.entries.map((e) => ResumenTrabajadorNomina(
      trabajadorId: e.key,
      totalPagar: e.value.totalPagar,
      totalKilos: e.value.totalKilos,
      totalAdelantos: e.value.totalAdelantos,
    )).toList();
  }

  /// Calcula los kilos de cereza recolectados por lote para el ciclo actual.
  Future<Map<int, double>> obtenerProductividadPorLote() async {
    final isar = ref.read(isarProvider);
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return {};
    final fincaId = int.parse(fincaIdStr);

    final labores = await isar.registroLaborIsarModels
        .filter()
        .fincaIdEqualTo(fincaId)
        .tipoPagoEqualTo('porKilo')
        .or()
        .tipoPagoEqualTo('porArroba')
        .findAll();

    final mapaProductividad = <int, double>{};
    for (final labor in labores) {
      if (labor.cantidadKilos != null) {
        mapaProductividad[labor.loteId] = (mapaProductividad[labor.loteId] ?? 0.0) + labor.cantidadKilos!;
      }
    }
    return mapaProductividad;
  }

  /// PROYECCIÓN FASE 3: Interoperabilidad con ServiCarga
  /// Este método conectará AgroGo con la plataforma de transporte logístico.
  Future<void> solicitarTransporteLogistico({
    required String cargaNombre,
    required double cantidadBultos,
  }) async {
    // TODO: Implementar url_launcher
    // ignore: avoid_print
    print('LOGÍSTICA: Simulando solicitud a ServiCarga para $cantidadBultos bultos de $cargaNombre');
  }
}

class ResumenTrabajadorNomina {
  final int trabajadorId;
  final double totalPagar;
  final double totalKilos;
  final double totalAdelantos;

  const ResumenTrabajadorNomina({
    required this.trabajadorId,
    required this.totalPagar,
    required this.totalKilos,
    required this.totalAdelantos,
  });

  double get netoAPagar => totalPagar - totalAdelantos;
}

class _AcumuladoNomina {
  final double totalPagar;
  final double totalKilos;
  final double totalAdelantos;
  _AcumuladoNomina({this.totalPagar = 0.0, this.totalKilos = 0.0, this.totalAdelantos = 0.0});
}
