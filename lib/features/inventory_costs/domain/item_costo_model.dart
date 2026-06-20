class ItemCostoEntity {
  final String id;
  final String? fincaId;
  final String nombreItem;
  final String categoria;
  final double precioTotal;
  final DateTime fechaCompra;
  final String? loteId;

  const ItemCostoEntity({
    required this.id,
    this.fincaId,
    required this.nombreItem,
    required this.categoria,
    required this.precioTotal,
    required this.fechaCompra,
    this.loteId,
  });
}
