import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:isar/isar.dart';
import '../../../../main.dart';
import '../../domain/beneficio_model.dart';
import '../../data/beneficio_isar_model.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';
import '../../../field_workers/data/registro_labor_isar_model.dart';
import 'insumos_notifier.dart';
import '../../domain/insumo_model.dart';

part 'beneficio_notifier.g.dart';

@riverpod
class BeneficioNotifier extends _$BeneficioNotifier {
  @override
  FutureOr<List<BeneficioEntity>> build() async {
    final fincaIdStr = ref.watch(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return [];
    
    final isar = ref.read(isarProvider);
    final fincaId = int.parse(fincaIdStr);
    
    final resultados = await isar.beneficioIsarModels
        .filter()
        .fincaIdEqualTo(fincaId)
        .sortByFechaInicioDesc()
        .findAll();
        
    return resultados.map((m) => m.toEntity()).toList();
  }

  /// Suma los kilos recolectados en la semana actual que aún no han sido procesados.
  Future<double> calcularKilosCerezaPendientes() async {
    final isar = ref.read(isarProvider);
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return 0;
    
    // Obtenemos los kilos de recolección de la semana
    final hoy = DateTime.now();
    final inicioSemana = hoy.subtract(Duration(days: hoy.weekday - 1));
    
    final labores = await isar.registroLaborIsarModels
        .filter()
        .fincaIdEqualTo(int.parse(fincaIdStr))
        .fechaRegistroGreaterThan(DateTime(inicioSemana.year, inicioSemana.month, inicioSemana.day))
        .findAll();
        
    return labores.fold<double>(0, (sum, l) => sum + (l.cantidadKilos ?? 0));
  }

  Future<void> iniciarNuevoBeneficio(double kilos) async {
    state = const AsyncValue.loading();
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    
    final nuevo = BeneficioEntity(
      id: '',
      fincaId: fincaIdStr,
      fechaInicio: DateTime.now(),
      kilosCereza: kilos,
      estado: EstadoBeneficio.cereza,
    );

    final isar = ref.read(isarProvider);
    await isar.writeTxn(() async {
      await isar.beneficioIsarModels.put(BeneficioIsarModel.fromEntity(nuevo));
    });
    
    ref.invalidateSelf();
  }

  Future<void> avanzarEstado(BeneficioEntity beneficio, double? kilosFinales) async {
    final isar = ref.read(isarProvider);
    
    EstadoBeneficio nuevoEstado = beneficio.estado;
    if (beneficio.estado == EstadoBeneficio.cereza) nuevoEstado = EstadoBeneficio.lavado;
    else if (beneficio.estado == EstadoBeneficio.lavado) nuevoEstado = EstadoBeneficio.secado;
    else if (beneficio.estado == EstadoBeneficio.secado) {
      nuevoEstado = EstadoBeneficio.listo;
      // Si está listo, lo inyectamos en la Bodega de Producción
      if (kilosFinales != null) {
        await ref.read(insumosNotifierProvider.notifier).registrarInsumo(
          nombre: 'Café Pergamino Seco (Lote ${beneficio.id})',
          unidad: 'Kilos',
          stockInicial: kilosFinales,
          categoria: CategoriaInsumo.cosecha,
        );
      }
    }

    final actualizado = beneficio.copyWith(
      estado: nuevoEstado,
      kilosFinales: kilosFinales,
    );

    await isar.writeTxn(() async {
      await isar.beneficioIsarModels.put(BeneficioIsarModel.fromEntity(actualizado));
    });
    
    ref.invalidateSelf();
  }
}
