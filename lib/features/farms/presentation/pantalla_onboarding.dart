import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/fincas_notifier.dart';

class PantallaOnboarding extends ConsumerStatefulWidget {
  const PantallaOnboarding({super.key});

  @override
  ConsumerState<PantallaOnboarding> createState() => _PantallaOnboardingState();
}

class _PantallaOnboardingState extends ConsumerState<PantallaOnboarding> {
  int _pasoActual = 0;
  
  // Datos temporales para la creación inicial
  final _nombreFincaCtrl = TextEditingController();
  bool _tieneAnimales = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      appBar: AppBar(
        title: const Text('Configuración Inicial'),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _pasoActual,
        onStepContinue: () {
          if (_pasoActual < 5) {
            setState(() => _pasoActual++);
          } else {
            _finalizarConfiguracion();
          }
        },
        onStepCancel: () {
          if (_pasoActual > 0) setState(() => _pasoActual--);
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E20),
                    minimumSize: const Size(150, 50),
                  ),
                  child: Text(_pasoActual == 5 ? '¡LISTO, EMPECEMOS!' : 'SIGUIENTE'),
                ),
                if (_pasoActual > 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('ATRÁS', style: TextStyle(color: Colors.grey)),
                  ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('1. Su Finca', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            content: Column(
              children: [
                const Text('Primero, ¿Cómo se llama su propiedad principal?'),
                const SizedBox(height: 12),
                TextField(
                  controller: _nombreFincaCtrl,
                  decoration: const InputDecoration(labelText: 'Nombre de la Finca', border: OutlineInputBorder()),
                ),
              ],
            ),
            isActive: _pasoActual >= 0,
          ),
          Step(
            title: const Text('2. Zonificación', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            content: const Text('Más adelante dibujaremos sus lotes de café y potreros en el mapa para saber cuántas hectáreas tiene realmente.'),
            isActive: _pasoActual >= 1,
          ),
          Step(
            title: const Text('3. Su Bodega', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            content: const Text('¿Tiene bultos de abono o herramientas? Registrarlos le permitirá saber cuánto gasta en cada abonada.'),
            isActive: _pasoActual >= 2,
          ),
          Step(
            title: const Text('4. Agenda de Trabajo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            content: const Text('Programaremos sus fumigaciones y abonadas para que el celular le avise qué toca hacer cada día.'),
            isActive: _pasoActual >= 3,
          ),
          Step(
            title: const Text('5. Sus Animales', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            content: Column(
              children: [
                const Text('¿Tiene cerdos, gallinas o peces en su finca?'),
                SwitchListTile(
                  title: const Text('Sí, tengo animales'),
                  value: _tieneAnimales,
                  onChanged: (v) => setState(() => _tieneAnimales = v),
                ),
              ],
            ),
            isActive: _pasoActual >= 4,
          ),
          Step(
            title: const Text('6. Equipo de Trabajo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            content: const Text('Configuraremos a sus trabajadores y si les paga por jornal o por kilo recogido (arrobiado).'),
            isActive: _pasoActual >= 5,
          ),
        ],
      ),
    );
  }

  void _finalizarConfiguracion() async {
    if (_nombreFincaCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, póngale un nombre a su finca.')));
      return;
    }

    // 1. Crear la finca
    await ref.read(fincasNotifierProvider.notifier).agregarFinca(
      nombre: _nombreFincaCtrl.text.trim(),
    );

    // 2. Obtener la lista actualizada y seleccionar la nueva finca
    final fincas = await ref.read(fincasNotifierProvider.future);
    if (fincas.isNotEmpty) {
      ref.read(fincaSeleccionadaProvider.notifier).seleccionar(fincas.last.id);
      
      // 3. Ir al Dashboard principal
      context.go('/dashboard');
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Finca configurada! Bienvenido a AgroGo.'),
          backgroundColor: Color(0xFF1B5E20),
        ),
      );
    }
  }
}
