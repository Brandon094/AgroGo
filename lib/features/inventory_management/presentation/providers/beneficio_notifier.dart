import 'package:dartz/dartz.dart';
import '../../../../core/errors/fallos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/beneficio_model.dart';
import '../../data/repositorio_beneficio.dart';
import '../../../farms/presentation/providers/fincas_notifier.dart';
import '../../../field_workers/data/repositorio_labores.dart';
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
    
    final fincaId = int.parse(fincaIdStr);
    final repositorio = ref.watch(repositorioBeneficioProvider);
    
    final resultado = await repositorio.obtenerBeneficios(fincaId);
    return resultado.fold(
      (fallo) => throw Exception(fallo.mensaje),
      (beneficios) => beneficios,
    );
  }

  /// Suma los kilos recolectados en la semana actual que aún no han sido procesados.
  Future<double> calcularKilosCerezaPendientes() async {
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    if (fincaIdStr == null) return 0;
    final fincaId = int.parse(fincaIdStr);
    
    final hoy = DateTime.now();
    final inicioSemana = hoy.subtract(Duration(days: hoy.weekday - 1));
    final fechaLunes = DateTime(inicioSemana.year, inicioSemana.month, inicioSemana.day);
    
    return await ref.read(repositorioLaboresProvider).obtenerKilosCerezaPendientes(fincaId, fechaLunes);
  }

  Future<Either<Fallo, void>> iniciarNuevoBeneficio(double kilos, {String? loteId, String? beneficiaderoId}) async {
    final fincaIdStr = ref.read(fincaSeleccionadaProvider);
    
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

    final repositorio = ref.read(repositorioBeneficioProvider);
    final resultado = await repositorio.guardarBeneficio(nuevo);
    
    return resultado.fold(
      (fallo) => Left(fallo),
      (_) {
        ref.invalidateSelf();
        return const Right(null);
      },
    );
  }

  Future<Either<Fallo, void>> avanzarEstado(BeneficioEntity beneficio, {double? kilosFinales, double? costoAdicional, String? secaderoId}) async {
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

    final repositorio = ref.read(repositorioBeneficioProvider);
    final resultado = await repositorio.guardarBeneficio(actualizado);

    return await resultado.fold(
      (fallo) async => Left(fallo),
      (_) async {
        if (nuevoEstado == EstadoBeneficio.listo || nuevoEstado == EstadoBeneficio.tostado || nuevoEstado == EstadoBeneficio.molido) {
          await _sincronizarConBodega(actualizado);
        }
        ref.invalidateSelf();
        return const Right(null);
      },
    );
  }

  Future<void> _sincronizarConBodega(BeneficioEntity beneficio) async {
    String nombreBodega = 'Café Pergamino Seco';
    if (beneficio.estaMolido) nombreBodega = 'Café Molido';
    else if (beneficio.estaTostado) nombreBodega = 'Café Tostado';

    // LIMPIEZA ARQUITECTÓNICA: Ya no inyectamos metadata en el String del nombre.
    // Usamos los campos técnicos beneficioId y loteId del InsumoEntity.
    await ref.read(insumosNotifierProvider.notifier).registrarInsumo(
      nombre: '$nombreBodega (Lote ${beneficio.id})',
      unidad: 'Kilos',
      stockInicial: beneficio.kilosFinales ?? 0.0,
      categoria: CategoriaInsumo.cosecha,
      beneficioId: beneficio.id,
    );
  }

  Future<Either<Fallo, void>> venderLote(BeneficioEntity beneficio, double kilosVendidos) async {
    final actualizado = beneficio.copyWith(
      estado: EstadoBeneficio.vendido,
      kilosFinales: kilosVendidos,
    );

    final repositorio = ref.read(repositorioBeneficioProvider);
    final res = await repositorio.guardarBeneficio(actualizado);
    
    return res.fold(
      (f) => Left(f),
      (_) {
        ref.invalidateSelf();
        return const Right(null);
      },
    );
  }
}
