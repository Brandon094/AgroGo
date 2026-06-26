import 'package:dartz/dartz.dart';
import '../../../../core/errors/fallos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/registro_labor_isar_model.dart';
import '../../data/repositorio_labores.dart';
import '../../data/repositorio_trabajadores.dart';
import '../../domain/usecases/liquidar_labor_usecase.dart';
import '../../../farms/data/repositorio_fincas.dart';
import '../../../inventory_costs/data/item_costo_isar_model.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';
import '../../../inventory_costs/presentation/providers/costos_notifier.dart';
import '../../../maps_and_lots/presentation/providers/panel_lotes_notifier.dart';

part 'gestion_administrativa_orchestrator.g.dart';

@riverpod
class GestionAdministrativaOrchestrator extends _$GestionAdministrativaOrchestrator {
  @override
  void build() {}

  /// Liquida la labor del día y coordina los asientos contables.
  Future<Either<Fallo, double>> liquidarLaborDiaria({
    required int trabajadorId,
    required int loteId,
    required String tipoPago,
    double? kilos,
    required double tarifaBase,
    required bool conAlimentacion,
  }) async {
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return Left(FalloBaseDatos('Finca no seleccionada'));
    final fincaId = int.parse(fincaIdStr);

    final useCase = ref.read(liquidarLaborUseCaseProvider.notifier);
    
    return await useCase.ejecutar(
      LiquidarLaborParams(
        trabajadorId: trabajadorId,
        loteId: loteId,
        tipoPago: tipoPago,
        kilos: kilos,
        tarifaBase: tarifaBase,
        conAlimentacion: conAlimentacion,
      ),
      fincaId,
    );
  }

  /// Obtiene el resumen de nómina consolidado (Labores + Adelantos).
  Future<List<ResumenTrabajadorNomina>> obtenerResumenNominaSemanal() async {
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return [];
    final fincaId = int.parse(fincaIdStr);

    final hoy = DateTime.now();
    final inicioSemana = hoy.subtract(Duration(days: hoy.weekday - 1));
    final fechaLunes = DateTime(inicioSemana.year, inicioSemana.month, inicioSemana.day);

    // OPTIMIZACIÓN SENIOR: Delegamos el agrupamiento y suma a los Repositorios (Isar native sums)
    final mapaLabores = await ref.read(repositorioLaboresProvider).obtenerResumenNominaPorTrabajador(fincaId, fechaLunes);
    final mapaAdelantos = await ref.read(repositorioTrabajadoresProvider).obtenerTotalAdelantosPendientesPorTrabajador(fincaId);

    // Unificamos los mapas en la lista final de Resumen
    final todosLosTrabajadores = {...mapaLabores.keys, ...mapaAdelantos.keys};
    
    return todosLosTrabajadores.map((id) {
      final labor = mapaLabores[id];
      final adelanto = mapaAdelantos[id] ?? 0.0;

      return ResumenTrabajadorNomina(
        trabajadorId: id,
        totalPagar: labor?.totalPagar ?? 0.0,
        totalKilos: labor?.totalKilos ?? 0.0,
        totalAdelantos: adelanto,
      );
    }).toList();
  }

  /// Calcula la productividad por lote usando optimización Isar.
  Future<Map<int, double>> obtenerProductividadPorLote() async {
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return {};
    final fincaId = int.parse(fincaIdStr);
    
    final repoLabores = ref.read(repositorioLaboresProvider);
    final lotesAsync = ref.read(panelLotesNotifierProvider);
    final idsLotes = lotesAsync.valueOrNull?.map((l) => int.tryParse(l.id)).whereType<int>().toList() ?? [];

    final mapaProductividad = <int, double>{};
    
    for (final id in idsLotes) {
      final totalKilos = await repoLabores.obtenerKilosTotalesPorLote(fincaId, id);
      if (totalKilos > 0) {
        mapaProductividad[id] = totalKilos;
      }
    }
    
    return mapaProductividad;
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
