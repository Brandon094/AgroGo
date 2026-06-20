import 'package:isar/isar.dart';

part 'registro_labor_isar_model.g.dart';

@collection
class RegistroLaborIsarModel {
  Id id = Isar.autoIncrement;

  int? fincaId;
  late int trabajadorId;
  late int loteId;
  late DateTime fechaRegistro;
  
  /// 'jornalFijo', 'porKilo' o 'porArroba'
  late String tipoPago; 
  
  double? cantidadKilos;
  late bool incluyeAlimentacion;
  late double totalPagar;

  /// Método de conveniencia para cálculos rápidos
  static double calcularPago({
    required String tipo,
    double? kilos,
    required double tarifaBase,
    required bool conAlimentacion,
    double costoComida = 15000, 
  }) {
    double subtotal = 0;
    
    if (tipo == 'porKilo' && kilos != null) {
      subtotal = kilos * tarifaBase;
    } else if (tipo == 'porArroba' && kilos != null) {
      // 1 Arroba = 12.5 Kilos. La tarifaBase aquí sería el precio por arroba.
      double arrobas = kilos / 12.5;
      subtotal = arrobas * tarifaBase;
    } else {
      subtotal = tarifaBase; // Jornal completo
    }

    return conAlimentacion ? (subtotal - costoComida) : subtotal;
  }
}
