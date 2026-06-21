enum CategoriaInsumo {
  operativo,    // Abono, Purina, Veneno
  maquinaria,   // Gasolina, Aceite, Cuchillas, Repuestos, Equipos (Guadaña, Motosierra)
  cosecha,      // Café, Plátano, Cacao (Lo que genera remuneración)
}

class InsumoEntity {
  final String id;
  final String? fincaId;
  final String nombre;
  final String unidadMedida; 
  final double cantidadActual;
  final double umbralMinimo;
  final CategoriaInsumo categoria;
  final bool esParaSecado; // Especial para Café

  const InsumoEntity({
    required this.id,
    this.fincaId,
    required this.nombre,
    required this.unidadMedida,
    required this.cantidadActual,
    required this.umbralMinimo,
    this.categoria = CategoriaInsumo.operativo,
    this.esParaSecado = false,
  });

  InsumoEntity copyWith({
    String? id,
    String? fincaId,
    String? nombre,
    String? unidadMedida,
    double? cantidadActual,
    double? umbralMinimo,
    CategoriaInsumo? categoria,
    bool? esParaSecado,
  }) {
    return InsumoEntity(
      id: id ?? this.id,
      fincaId: fincaId ?? this.fincaId,
      nombre: nombre ?? this.nombre,
      unidadMedida: unidadMedida ?? this.unidadMedida,
      cantidadActual: cantidadActual ?? this.cantidadActual,
      umbralMinimo: umbralMinimo ?? this.umbralMinimo,
      categoria: categoria ?? this.categoria,
      esParaSecado: esParaSecado ?? this.esParaSecado,
    );
  }

  bool get esEscaso => cantidadActual <= umbralMinimo;
}
