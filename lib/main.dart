import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/routing/enrutador_app.dart';
import 'core/theme/tema_app.dart';

// Importación de modelos Isar
import 'features/maps_and_lots/data/lote_isar_model.dart';
import 'features/field_workers/data/trabajador_isar_model.dart';
import 'features/inventory_costs/data/item_costo_isar_model.dart';
import 'features/farm_calendar/data/tarea_isar_model.dart';
import 'features/livestock/data/modelos_pecuario_isar.dart';
import 'features/farms/data/finca_isar_model.dart';
import 'features/inventory_management/data/insumo_isar_model.dart';
import 'features/field_workers/data/registro_labor_isar_model.dart';

// Provider global para la instancia de Isar
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('El provider de Isar debe ser sobreescrito en el main');
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_CO', null);
  
  // Inicialización de la base de datos Isar
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
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
      RegistroLaborIsarModelSchema,
    ],
    directory: dir.path,
  );

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: const AgroGoApp(),
    ),
  );
}

class AgroGoApp extends StatelessWidget {
  const AgroGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AgroGo',
      theme: TemaApp.temaClaro,
      routerConfig: EnrutadorApp.enrutador,
      debugShowCheckedModeBanner: false,
    );
  }
}
