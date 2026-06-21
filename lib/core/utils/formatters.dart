import 'package:intl/intl.dart';

class Formateadores {
  static final _moneda = NumberFormat.currency(
    locale: 'es_CO',
    symbol: '\$',
    decimalDigits: 0,
  );

  /// Formatea un valor numérico a moneda COP con separadores de miles (puntos).
  /// Ejemplo: 1500000 -> $1.500.000 COP
  static String formatearMoneda(double valor) {
    final str = _moneda.format(valor);
    return '$str COP';
  }

  /// Formatea valores grandes para el Dashboard (ej: 1.5M o 10.2k).
  static String formatearMonedaCompacta(double valor) {
    if (valor >= 1000000) {
      return '\$${(valor / 1000000).toStringAsFixed(1)}M';
    } else if (valor >= 1000) {
      return '\$${(valor / 1000).toStringAsFixed(0)}k';
    }
    return _moneda.format(valor);
  }
}
