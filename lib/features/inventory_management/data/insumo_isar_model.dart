import 'package:isar/isar.dart';
import '../domain/insumo_model.dart';

part 'insumo_isar_model.g.dart';

@collection
class InsumoIsarModel {
  Id id = Isar.autoIncrement;
  int? fincaId;
  late String nombre;
  late String unidadMedida;
  late double cantidadActual;
  late double umbralMinimo;

  @enumerated
  late CategoriaInsumo categoria;
  
  late bool esParaSecado;

  late double valorUnitario;
  late double valorTotal;

  InsumoEntity toEntity() {
    return InsumoEntity(
      id: id.toString(),
      fincaId: fincaId?.toString(),
      nombre: nombre,
      unidadMedida: unidadMedida,
      cantidadActual: cantidadActual,
      umbralMinimo: umbralMinimo,
      categoria: categoria,
      esParaSecado: esParaSecado,
      valorUnitario: valorUnitario,
      valorTotal: valorTotal,
    );
  }

  static InsumoIsarModel fromEntity(InsumoEntity entidad) {
    final modelo = InsumoIsarModel()
      ..fincaId = entidad.fincaId != null ? int.tryParse(entidad.fincaId!) : null
      ..nombre = entidad.nombre
      ..unidadMedida = entidad.unidadMedida
      ..cantidadActual = entidad.cantidadActual
      ..umbralMinimo = entidad.umbralMinimo
      ..categoria = entidad.categoria
      ..esParaSecado = entidad.esParaSecado
      ..valorUnitario = entidad.valorUnitario
      ..valorTotal = entidad.valorTotal;
    
    if (entidad.id.isNotEmpty && entidad.id != '0') {
      modelo.id = int.parse(entidad.id);
    }
    return modelo;
  }
}
