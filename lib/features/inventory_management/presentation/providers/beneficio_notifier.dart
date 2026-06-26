import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:isar/isar.dart';
import '../../../../main.dart';
import '../../domain/beneficio_model.dart';
import '../../data/beneficio_isar_model.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';
import '../../../field_workers/data/registro_labor_isar_model.dart';
import 'insumos_notifier.dart';
import '../../domain/insumo_model.dart';
import '../../../inventory_costs/presentation/providers/costos_notifier.dart';
import '../../../maps_and_lots/domain/lote_model.dart';
import '../../../maps_and_lots/presentation/providers/panel_lotes_notifier.dart';

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

  Future<void> iniciarNuevoBeneficio(double kilos, {String? loteId, String? beneficiaderoId}) async {
    state = const AsyncValue.loading();
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    
    // Si tenemos loteId, intentamos obtener su nombre para el registro
    String? nombreLote;
    final lotes = ref.read(panelLotesNotifierProvider).valueOrNull ?? [];
    if (loteId != null) {
      final lote = lotes.firstWhere((l) => l.id == loteId, orElse: () => const Lote(id: '', nombre: 'Lote Desconocido', uso: TipoUsoLote.agricola, subCategoria: '', areaEnHectareas: 0, numeroMatas: 0, coordenadas: []));
      if (lote.id.isNotEmpty) nombreLote = lote.nombre;
    }

    String? nombreBeneficiadero;
    if (beneficiaderoId != null) {
      final infra = lotes.firstWhere((l) => l.id == beneficiaderoId, orElse: () => const Lote(id: '', nombre: 'Desconocido', uso: TipoUsoLote.infraestructura, subCategoria: '', areaEnHectareas: 0, numeroMatas: 0, coordenadas: []));
      nombreBeneficiadero = infra.nombre;
    }

    final nuevo = BeneficioEntity(
      id: '',
      fincaId: fincaIdStr,
      fechaInicio: DateTime.now(),
      kilosCereza: kilos,
      estado: EstadoBeneficio.cereza,
      loteOrigenNombre: nombreLote,
      beneficiaderoId: beneficiaderoId,
      beneficiaderoNombre: nombreBeneficiadero,
    );

    final isar = ref.read(isarProvider);
    await isar.writeTxn(() async {
      await isar.beneficioIsarModels.put(BeneficioIsarModel.fromEntity(nuevo));
    });
    
    ref.invalidateSelf();
  }

  Future<void> avanzarEstado(BeneficioEntity beneficio, {double? kilosFinales, double? costoAdicional, String? secaderoId}) async {
    final isar = ref.read(isarProvider);
    final lotes = ref.read(panelLotesNotifierProvider).valueOrNull ?? [];
    
    EstadoBeneficio nuevoEstado = beneficio.estado;
    bool estaTostado = beneficio.estaTostado;
    bool estaMolido = beneficio.estaMolido;
    double costoProcesamiento = beneficio.costoProcesamiento + (costoAdicional ?? 0.0);
    String? secaderoNombre = beneficio.secaderoNombre;

    if (beneficio.estado == EstadoBeneficio.cereza) {
      nuevoEstado = EstadoBeneficio.lavado;
    } else if (beneficio.estado == EstadoBeneficio.lavado) {
      nuevoEstado = EstadoBeneficio.secado;
      if (secaderoId != null) {
        final infra = lotes.firstWhere((l) => l.id == secaderoId, orElse: () => const Lote(id: '', nombre: 'Desconocido', uso: TipoUsoLote.infraestructura, subCategoria: '', areaEnHectareas: 0, numeroMatas: 0, coordenadas: []));
        secaderoNombre = infra.nombre;
      }
    } else if (beneficio.estado == EstadoBeneficio.secado) {
      nuevoEstado = EstadoBeneficio.listo;
    } else if (beneficio.estado == EstadoBeneficio.listo) {
      nuevoEstado = EstadoBeneficio.tostado;
      estaTostado = true;
    } else if (beneficio.estado == EstadoBeneficio.tostado) {
      nuevoEstado = EstadoBeneficio.molido;
      estaMolido = true;
    }

    // Registrar gasto adicional si aplica (tostado/molienda)
    if (costoAdicional != null && costoAdicional > 0) {
      await ref.read(costosNotifierProvider.notifier).agregarCosto(
        nombre: 'Procesamiento Lote ${beneficio.id}: ${nuevoEstado.name}', 
        categoria: 'Operativos', 
        precioTotal: costoAdicional,
      );
    }

    final actualizado = beneficio.copyWith(
      estado: nuevoEstado,
      kilosFinales: kilosFinales ?? beneficio.kilosFinales,
      estaTostado: estaTostado,
      estaMolido: estaMolido,
      costoProcesamiento: costoProcesamiento,
      secaderoId: secaderoId ?? beneficio.secaderoId,
      secaderoNombre: secaderoNombre,
    );

    await isar.writeTxn(() async {
      await isar.beneficioIsarModels.put(BeneficioIsarModel.fromEntity(actualizado));
    });

    // Sincronizar con Bodega si el estado es final o avanzado (listo, tostado, molido)
    if (nuevoEstado == EstadoBeneficio.listo || nuevoEstado == EstadoBeneficio.tostado || nuevoEstado == EstadoBeneficio.molido) {
      String nombreBodega = 'Café Pergamino Seco';
      if (estaMolido) nombreBodega = 'Café Molido';
      else if (estaTostado) nombreBodega = 'Café Tostado';

      String metadata = '';
      if (beneficio.loteOrigenNombre != null) metadata += ' (Origen: ${beneficio.loteOrigenNombre})';
      if (beneficio.beneficiaderoNombre != null) metadata += ' (Beneficiadero: ${beneficio.beneficiaderoNombre})';
      if (secaderoNombre != null) metadata += ' (Secadero: $secaderoNombre)';

      await ref.read(insumosNotifierProvider.notifier).registrarInsumo(
        nombre: '$nombreBodega (Lote ${beneficio.id})$metadata',
        unidad: 'Kilos',
        stockInicial: kilosFinales ?? beneficio.kilosFinales ?? 0.0,
        categoria: CategoriaInsumo.cosecha,
      );
    }
    
    ref.invalidateSelf();
  }

  Future<void> venderLote(BeneficioEntity beneficio, double kilosVendidos) async {
    final isar = ref.read(isarProvider);
    
    final actualizado = beneficio.copyWith(
      estado: EstadoBeneficio.vendido,
      kilosFinales: kilosVendidos,
    );

    await isar.writeTxn(() async {
      await isar.beneficioIsarModels.put(BeneficioIsarModel.fromEntity(actualizado));
    });
    
    ref.invalidateSelf();
  }
}
