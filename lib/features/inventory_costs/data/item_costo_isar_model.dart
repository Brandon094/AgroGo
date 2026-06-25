import 'package:isar/isar.dart';
import '../domain/item_costo_model.dart';

part 'item_costo_isar_model.g.dart';

@collection
class ItemCostoIsarModel {
  Id id = Isar.autoIncrement;
  int? fincaId;
  late String nombreItem;
  late String categoria;
  late double precioTotal;
  late DateTime fechaCompra;
  int? loteId;
  late bool esIngreso;

  ItemCostoEntity toEntity() {
    return ItemCostoEntity(
      id: id.toString(),
      fincaId: fincaId?.toString(),
      nombreItem: nombreItem,
      categoria: categoria,
      precioTotal: precioTotal,
      fechaCompra: fechaCompra,
      loteId: loteId?.toString(),
      esIngreso: esIngreso,
    );
  }

  static ItemCostoIsarModel fromEntity(ItemCostoEntity entidad) {
    final modelo = ItemCostoIsarModel()
      ..fincaId = entidad.fincaId != null ? int.tryParse(entidad.fincaId!) : null
      ..nombreItem = entidad.nombreItem
      ..categoria = entidad.categoria
      ..precioTotal = entidad.precioTotal
      ..fechaCompra = entidad.fechaCompra
      ..loteId = entidad.loteId != null ? int.tryParse(entidad.loteId!) : null
      ..esIngreso = entidad.esIngreso;

    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}
