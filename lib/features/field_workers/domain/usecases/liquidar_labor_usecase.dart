import 'package:dartz/dartz.dart';
import '../../../../core/errors/fallos.dart';
import '../../data/registro_labor_isar_model.dart';
import '../../data/repositorio_labores.dart';
import '../../../farms/data/repositorio_fincas.dart';
import '../../../inventory_costs/presentation/providers/costos_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'liquidar_labor_usecase.g.dart';

class LiquidarLaborParams {
  final int trabajadorId;
  final int loteId;
  final String tipoPago;
  final double? kilos;
  final double tarifaBase;
  final bool conAlimentacion;

  LiquidarLaborParams({
    required this.trabajadorId,
    required this.loteId,
    required this.tipoPago,
    this.kilos,
    required this.tarifaBase,
    required this.conAlimentacion,
  });
}

@riverpod
class LiquidarLaborUseCase extends _$LiquidarLaborUseCase {
  @override
  void build() {}

  /// Ejecuta la lógica de negocio para liquidar una labor diaria.
  Future<Either<Fallo, double>> ejecutar(LiquidarLaborParams params, int fincaId) async {
    final repoFincas = ref.read(repositorioFincasProvider);
    final repoLabores = ref.read(repositorioLaboresProvider);
    
    // 1. Obtener reglas de negocio dinámicas (Configuración)
    final resConfig = await repoFincas.obtenerConfiguracion(fincaId);
    
    return await resConfig.fold(
      (fallo) async => Left(fallo),
      (config) async {
        // 2. Calcular el pago (Lógica de Dominio)
        final totalPagar = RegistroLaborIsarModel.calcularPago(
          tipo: params.tipoPago,
          kilos: params.kilos,
          tarifaBase: params.tarifaBase,
          conAlimentacion: params.conAlimentacion,
          costoComida: config.costoAlimentacion,
        );

        // 3. Persistir la labor
        final registro = RegistroLaborIsarModel()
          ..fincaId = fincaId
          ..trabajadorId = params.trabajadorId
          ..loteId = params.loteId
          ..fechaRegistro = DateTime.now()
          ..tipoPago = params.tipoPago
          ..cantidadKilos = params.kilos
          ..incluyeAlimentacion = params.conAlimentacion
          ..totalPagar = totalPagar;
        
        await repoLabores.guardarLabor(registro);

        // 4. Si hubo alimentación, disparar el registro de costo
        if (params.conAlimentacion) {
          await ref.read(costosNotifierProvider.notifier).agregarCosto(
            nombre: 'Alimentación Trabajador (Lote ${params.loteId})',
            categoria: 'Operativos',
            precioTotal: config.costoAlimentacion,
            loteId: params.loteId.toString(),
          );
        }

        return Right(totalPagar);
      },
    );
  }
}
