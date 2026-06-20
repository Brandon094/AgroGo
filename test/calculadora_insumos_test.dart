import 'package:flutter_test/flutter_test.dart';
import 'package:agrogo/features/inventory_costs/domain/calculadora_insumos_usecase.dart';

void main() {
  group('Pruebas unitarias de CalculadoraInsumosUseCase', () {
    final calculadora = CalculadoraInsumosUseCase();

    group('Cálculo de Abono / Fertilización', () {
      test('Valores típicos (1000 matas, 50g/mata, 50kg/bulto)', () {
        final bultos = calculadora.calcularBultosAbono(
          numeroMatas: 1000,
          gramosPorMata: 50.0,
          kilosPorBulto: 50.0,
        );
        // 1000 * 50 = 50,000 gramos = 50 kg.
        // 50 kg / 50 kg/bulto = 1 bulto exacto.
        expect(bultos, equals(1));
      });

      test('Redondeo hacia arriba (1200 matas, 50g/mata, 50kg/bulto)', () {
        final bultos = calculadora.calcularBultosAbono(
          numeroMatas: 1200,
          gramosPorMata: 50.0,
          kilosPorBulto: 50.0,
        );
        // 1200 * 50 = 60,000 gramos = 60 kg.
        // 60 kg / 50 kg/bulto = 1.2 bultos -> Redondea a 2 bultos.
        expect(bultos, equals(2));
      });

      test('Retorna 0 con valores inválidos o nulos/vacíos', () {
        expect(calculadora.calcularBultosAbono(numeroMatas: 0, gramosPorMata: 50.0, kilosPorBulto: 50.0), equals(0));
        expect(calculadora.calcularBultosAbono(numeroMatas: 1000, gramosPorMata: -1.0, kilosPorBulto: 50.0), equals(0));
        expect(calculadora.calcularBultosAbono(numeroMatas: 1000, gramosPorMata: 50.0, kilosPorBulto: 0), equals(0));
      });
    });

    group('Cálculo de Fumigación', () {
      test('Valores típicos (1500 matas, 200 matas/bomba, 20L capacidad)', () {
        final resultado = calculadora.calcularFumigacion(
          numeroMatas: 1500,
          rendimientoMatasPorBomba: 200,
          capacidadBombaLitros: 20.0,
        );
        // 1500 / 200 = 7.5 bombas -> Redondea a 8 bombas.
        // 8 bombas * 20L = 160.0 Litros de mezcla.
        expect(resultado.bombas, equals(8));
        expect(resultado.litrosMezcla, equals(160.0));
      });

      test('Retorna 0 con valores inválidos', () {
        final resultado = calculadora.calcularFumigacion(
          numeroMatas: 0,
          rendimientoMatasPorBomba: 200,
          capacidadBombaLitros: 20.0,
        );
        expect(resultado.bombas, equals(0));
        expect(resultado.litrosMezcla, equals(0.0));
      });
    });
  });
}
