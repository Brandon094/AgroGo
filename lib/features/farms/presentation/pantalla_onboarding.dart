import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/fincas_notifier.dart';
import '../../maps_and_lots/presentation/providers/panel_lotes_notifier.dart';
import '../../inventory_management/presentation/providers/insumos_notifier.dart';
import '../../farm_calendar/presentation/providers/cronograma_notifier.dart';
import '../../field_workers/presentation/providers/trabajadores_notifier.dart';

class PantallaOnboarding extends ConsumerStatefulWidget {
  const PantallaOnboarding({super.key});

  @override
  ConsumerState<PantallaOnboarding> createState() => _PantallaOnboardingState();
}

class _PantallaOnboardingState extends ConsumerState<PantallaOnboarding> {
  int _pasoActual = 0;

  @override
  Widget build(BuildContext context) {
    // Escuchamos los datos reales para saber si el usuario ya cumplió la misión
    final fincas = ref.watch(fincasNotifierProvider).valueOrNull ?? [];
    final lotes = ref.watch(panelLotesNotifierProvider).valueOrNull ?? [];
    final insumos = ref.watch(insumosNotifierProvider).valueOrNull ?? [];
    final tareas = ref.watch(cronogramaNotifierProvider).valueOrNull ?? [];
    final equipo = ref.watch(trabajadoresNotifierProvider).valueOrNull ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tutor de Configuración', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.green.shade50,
            child: Row(
              children: [
                const Icon(Icons.psychology, size: 40, color: Color(0xFF1B5E20)),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    '¡Bienvenido, Patrón! Lo guiaré para dejar su finca lista en 5 minutos.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stepper(
              type: StepperType.vertical,
              currentStep: _pasoActual,
              onStepTapped: (step) => setState(() => _pasoActual = step),
              controlsBuilder: (context, details) => const SizedBox.shrink(), // Quitamos botones por defecto
              steps: [
                _pasoFinca(fincas),
                _pasoLote(fincas, lotes),
                _pasoBodega(lotes, insumos),
                _pasoAgenda(insumos, tareas),
                _pasoEquipo(tareas, equipo),
              ],
            ),
          ),
          if (equipo.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E20),
                  minimumSize: const Size(double.infinity, 64),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () => context.go('/dashboard'),
                child: const Text('¡TERMINAR TUTORIAL Y IR AL INICIO!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
        ],
      ),
    );
  }

  Step _pasoFinca(List fincas) => Step(
    title: const Text('Misión 1: Registrar su Finca'),
    content: _ContenidoMision(
      descripcion: 'Toda gran administración empieza por darle nombre y ubicación a la tierra. Vamos a crear su primera propiedad.',
      icono: Icons.home_work,
      completado: fincas.isNotEmpty,
      botonLabel: 'CREAR MI FINCA',
      onTap: () => _mostrarDialogoFinca(),
    ),
    isActive: _pasoActual == 0,
    state: fincas.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  Step _pasoLote(List fincas, List lotes) => Step(
    title: const Text('Misión 2: El Mapa Satelital'),
    content: _ContenidoMision(
      descripcion: 'Dibuje su primer lote de café o potrero. AgroGo calculará las hectáreas exactas por usted.',
      icono: Icons.map,
      completado: lotes.isNotEmpty,
      botonLabel: 'IR AL MAPA Y DIBUJAR',
      onTap: () {
        if (fincas.isEmpty) return;
        ref.read(fincaSeleccionadaProvider.notifier).seleccionar(fincas.first.id);
        context.push('/lotes/nuevo-lote');
      },
    ),
    isActive: _pasoActual == 1,
    state: lotes.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  Step _pasoBodega(List lotes, List insumos) => Step(
    title: const Text('Misión 3: Cargar la Bodega'),
    content: _ContenidoMision(
      descripcion: 'Registre los bultos de abono o purina que tiene guardados para controlar su inventario.',
      icono: Icons.inventory,
      completado: insumos.isNotEmpty,
      botonLabel: 'INGRESAR A BODEGA',
      onTap: () => context.push('/bodega'),
    ),
    isActive: _pasoActual == 2,
    state: insumos.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  Step _pasoAgenda(List insumos, List tareas) => Step(
    title: const Text('Misión 4: Su primera Tarea'),
    content: _ContenidoMision(
      descripcion: 'Agende una fumigación o abonada. El sistema le avisará cuando llegue el día.',
      icono: Icons.calendar_month,
      completado: tareas.isNotEmpty,
      botonLabel: 'ABRIR AGENDA',
      onTap: () => context.go('/agenda'),
    ),
    isActive: _pasoActual == 3,
    state: tareas.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  Step _pasoEquipo(List tareas, List equipo) => Step(
    title: const Text('Misión 5: El Equipo de Trabajo'),
    content: _ContenidoMision(
      descripcion: 'Registre a sus trabajadores. Con ellos podrá llevar el control de kilos y jornales.',
      icono: Icons.people,
      completado: equipo.isNotEmpty,
      botonLabel: 'CONFIGURAR EQUIPO',
      onTap: () => context.push('/trabajadores'),
    ),
    isActive: _pasoActual == 4,
    state: equipo.isNotEmpty ? StepState.complete : StepState.indexed,
  );

  void _mostrarDialogoFinca() {
    final nombreCtrl = TextEditingController();
    final ubicacionCtrl = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registro de Finca'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nombreCtrl, 
              decoration: const InputDecoration(
                labelText: 'Nombre de su Finca',
                hintText: 'Ej: El Cafetal',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ubicacionCtrl, 
              decoration: const InputDecoration(
                labelText: 'Vereda / Ubicación',
                hintText: 'Ej: Vereda La Linda',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          ElevatedButton(
            onPressed: () async {
              if (nombreCtrl.text.isNotEmpty) {
                await ref.read(fincasNotifierProvider.notifier).agregarFinca(
                  nombre: nombreCtrl.text,
                  vereda: ubicacionCtrl.text,
                );
                if (mounted) {
                  Navigator.pop(context);
                  setState(() => _pasoActual = 1);
                }
              }
            },
            child: const Text('GUARDAR'),
          ),
        ],
      ),
    );
  }
}

class _ContenidoMision extends StatelessWidget {
  final String descripcion;
  final IconData icono;
  final bool completado;
  final String botonLabel;
  final VoidCallback onTap;

  const _ContenidoMision({
    required this.descripcion,
    required this.icono,
    required this.completado,
    required this.botonLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(descripcion, style: const TextStyle(fontSize: 15, color: Colors.black87)),
        const SizedBox(height: 16),
        if (completado)
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 30),
              const SizedBox(width: 12),
              const Text('¡Misión Cumplida!', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
            ],
          )
        else
          ElevatedButton.icon(
            onPressed: onTap,
            icon: Icon(icono),
            label: Text(botonLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade800,
              foregroundColor: Colors.white,
              minimumSize: const Size(200, 50),
            ),
          ),
      ],
    );
  }
}
