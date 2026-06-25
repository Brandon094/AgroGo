import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agrogo/features/inventory_costs/domain/item_costo_model.dart';
import 'package:agrogo/features/inventory_costs/data/item_costo_isar_model.dart';
import 'package:agrogo/features/inventory_costs/presentation/providers/costos_notifier.dart';

void main() {
  group('Pruebas de Integración Costos - Lotes', () {
    test('ItemCostoIsarModel conversión a Entidad y viceversa', () {
      final now = DateTime.now();
      final entidadConFecha = ItemCostoEntity(
        id: '123',
        nombreItem: 'Abono NPK',
        categoria: 'Abono',
        precioTotal: 150000.0,
        fechaCompra: now,
        loteId: '456',
      );

      // Entidad -> Isar Model
      final modeloIsar = ItemCostoIsarModel.fromEntity(entidadConFecha);
      expect(modeloIsar.id, 123);
      expect(modeloIsar.nombreItem, 'Abono NPK');
      expect(modeloIsar.categoria, 'Abono');
      expect(modeloIsar.precioTotal, 150000.0);
      expect(modeloIsar.fechaCompra, now);
      expect(modeloIsar.loteId, 456);

      // Isar Model -> Entidad
      final entidadReconvertida = modeloIsar.toEntity();
      expect(entidadReconvertida.id, '123');
      expect(entidadReconvertida.nombreItem, 'Abono NPK');
      expect(entidadReconvertida.categoria, 'Abono');
      expect(entidadReconvertida.precioTotal, 150000.0);
      expect(entidadReconvertida.fechaCompra, now);
      expect(entidadReconvertida.loteId, '456');
    });

    test('Mapeo de loteId nulo (Gasto General de la Finca)', () {
      final now = DateTime.now();
      final entidadGeneral = ItemCostoEntity(
        id: '789',
        nombreItem: 'Machete',
        categoria: 'Herramienta',
        precioTotal: 25000.0,
        fechaCompra: now,
        loteId: null,
      );

      final modeloIsar = ItemCostoIsarModel.fromEntity(entidadGeneral);
      expect(modeloIsar.loteId, isNull);

      final entidadReconvertida = modeloIsar.toEntity();
      expect(entidadReconvertida.loteId, isNull);
    });

    test('CostosNotifier guarda y recupera loteId en RepositorioCostosImpl', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(costosNotifierProvider.notifier);

      // Esperar a que cargue la lista vacía inicial
      var lista = await container.read(costosNotifierProvider.future);
      expect(lista, isEmpty);

      // Agregar un costo general
      await notifier.agregarCosto(
        nombre: 'Herramienta Pala',
        categoria: 'Herramienta',
        precioTotal: 45000.0,
        loteId: null,
      );

      // Agregar un costo asociado a un lote
      await notifier.agregarCosto(
        nombre: 'Fertilizante Urea',
        categoria: 'Abono',
        precioTotal: 180000.0,
        loteId: '10',
      );

      // Leer la lista actualizada
      lista = await container.read(costosNotifierProvider.future);
      expect(lista, hasLength(2));

      final costoGeneral = lista.firstWhere((c) => c.nombreItem == 'Herramienta Pala');
      expect(costoGeneral.loteId, isNull);

      final costoConLote = lista.firstWhere((c) => c.nombreItem == 'Fertilizante Urea');
      expect(costoConLote.loteId, equals('10'));
    });
  });
}
