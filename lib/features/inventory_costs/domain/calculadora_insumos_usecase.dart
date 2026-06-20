/// Caso de uso que agrupa la lógica matemática de negocio para proyectar
/// los insumos requeridos en base al número de matas de un lote.
class CalculadoraInsumosUseCase {
  /// Método 1 (Abono): Calcula la cantidad exacta de bultos a comprar redondeando hacia arriba.
  int calcularBultosAbono({
    required int numeroMatas,
    required double gramosPorMata,
    required double kilosPorBulto,
  }) {
    if (numeroMatas <= 0 || gramosPorMata <= 0 || kilosPorBulto <= 0) return 0;
    final totalKilos = (numeroMatas * gramosPorMata) / 1000.0;
    return (totalKilos / kilosPorBulto).ceil();
  }

  /// Método 2 (Fumigación): Calcula cuántas bombas de agua y el total de mezcla (en Litros) requeridos.
  ResultadoFumigacion calcularFumigacion({
    required int numeroMatas,
    required int rendimientoMatasPorBomba,
    required double capacidadBombaLitros,
  }) {
    if (numeroMatas <= 0 || rendimientoMatasPorBomba <= 0 || capacidadBombaLitros <= 0) {
      return const ResultadoFumigacion(bombas: 0, litrosMezcla: 0.0);
    }
    final bombas = (numeroMatas / rendimientoMatasPorBomba).ceil();
    final litrosMezcla = bombas * capacidadBombaLitros;
    return ResultadoFumigacion(bombas: bombas, litrosMezcla: litrosMezcla);
  }
}

/// Estructura de retorno para el cálculo de fumigación.
class ResultadoFumigacion {
  final int bombas;
  final double litrosMezcla;

  const ResultadoFumigacion({
    required this.bombas,
    required this.litrosMezcla,
  });
}
