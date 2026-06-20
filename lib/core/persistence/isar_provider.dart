import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/maps_and_lots/data/lote_isar_model.dart';
import '../../features/field_workers/data/trabajador_isar_model.dart';
import '../../features/inventory_costs/data/item_costo_isar_model.dart';
import '../../features/farm_calendar/data/tarea_isar_model.dart';
import '../../features/livestock/data/modelos_pecuario_isar.dart';
import '../../features/farms/data/finca_isar_model.dart';
import '../../features/inventory_management/data/insumo_isar_model.dart';

part 'isar_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isarInstance(IsarInstanceRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  
  return Isar.open(
    [
      LoteIsarModelSchema,
      TrabajadorIsarModelSchema,
      ItemCostoIsarModelSchema,
      TareaIsarModelSchema,
      EspecieIsarModelSchema,
      ControlSanitarioIsarModelSchema,
      AlimentacionIsarModelSchema,
      FincaIsarModelSchema,
      InsumoIsarModelSchema,
    ],
    directory: dir.path,
  );
}
