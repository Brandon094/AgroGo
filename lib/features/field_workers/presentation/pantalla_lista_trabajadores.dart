import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/trabajadores_notifier.dart';

/// Pantalla que muestra el listado de trabajadores de la finca y gestiona la nómina del equipo.
class PantallaListaTrabajadores extends ConsumerWidget {
  const PantallaListaTrabajadores({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoTrabajadores = ref.watch(trabajadoresNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Equipo - Nómina'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 28.0),
            tooltip: 'Actualizar equipo',
            onPressed: () => ref.read(trabajadoresNotifierProvider.notifier).refresh(),
          ),
        ],
      ),
      body: estadoTrabajadores.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 64.0),
                const SizedBox(height: 16.0),
                Text(
                  'Error al cargar el equipo:\n${error.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () => ref.read(trabajadoresNotifierProvider.notifier).refresh(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
        data: (trabajadores) {
          if (trabajadores.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 100.0, color: Colors.grey),
                    SizedBox(height: 24.0),
                    Text(
                      'No hay trabajadores registrados en tu equipo.\n¡Toca el botón flotante para agregar uno!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            itemCount: trabajadores.length,
            itemBuilder: (context, indice) {
              final trabajador = trabajadores[indice];
              final esRecolector = trabajador.tipoTrabajador == 'Recolector';
              final formatoTarifa = esRecolector
                  ? '\$${trabajador.tarifaBase.toStringAsFixed(0)} por Kilo'
                  : '\$${trabajador.tarifaBase.toStringAsFixed(0)} de Jornal';

              return Card(
                elevation: 4.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  leading: CircleAvatar(
                    radius: 28.0,
                    backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      size: 32.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    trabajador.nombreCompleto,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rol: ${trabajador.tipoTrabajador}',
                          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          'Tarifa: $formatoTarifa',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 28.0),
                    onPressed: () => _confirmarEliminacion(context, ref, trabajador),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormularioAgregar(context, ref),
        tooltip: 'Registrar Trabajador',
        child: const Icon(Icons.person_add, size: 28.0),
      ),
    );
  }

  /// Muestra el modal de confirmación antes de eliminar un trabajador
  void _confirmarEliminacion(BuildContext context, WidgetRef ref, dynamic trabajador) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar trabajador?'),
        content: Text('¿Estás seguro de que deseas retirar a ${trabajador.nombreCompleto} de la nómina?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(fontSize: 16.0)),
          ),
          TextButton(
            onPressed: () {
              ref.read(trabajadoresNotifierProvider.notifier).eliminarTrabajador(trabajador.id);
              Navigator.pop(context);
            },
            child: const Text('Retirar', style: TextStyle(color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  /// Despliega el BottomSheet con el formulario para registrar un nuevo trabajador
  void _mostrarFormularioAgregar(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) => const _FormularioTrabajadorModal(),
    );
  }
}

/// Widget interno que representa el formulario modal para registrar trabajadores
class _FormularioTrabajadorModal extends ConsumerStatefulWidget {
  const _FormularioTrabajadorModal();

  @override
  ConsumerState<_FormularioTrabajadorModal> createState() => _FormularioTrabajadorModalState();
}

class _FormularioTrabajadorModalState extends ConsumerState<_FormularioTrabajadorModal> {
  final _formularioKey = GlobalKey<FormState>();
  final _nombreControlador = TextEditingController();
  final _tarifaControlador = TextEditingController();
  String _tipoTrabajadorSeleccionado = 'Recolector';

  @override
  void dispose() {
    _nombreControlador.dispose();
    _tarifaControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tecladoPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 24.0 + tecladoPadding),
      child: Form(
        key: _formularioKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Registrar Trabajador',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16.0),

            // Nombre Completo
            TextFormField(
              controller: _nombreControlador,
              style: const TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                labelText: 'Nombre Completo',
                labelStyle: const TextStyle(fontSize: 16.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'Por favor ingresa el nombre completo';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),

            // Tipo de Trabajador (Dropdown)
            DropdownButtonFormField<String>(
              initialValue: _tipoTrabajadorSeleccionado,
              style: const TextStyle(fontSize: 18.0, color: Colors.black87),
              decoration: InputDecoration(
                labelText: 'Tipo de Trabajo',
                labelStyle: const TextStyle(fontSize: 16.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                prefixIcon: const Icon(Icons.work_outline),
              ),
              items: const [
                DropdownMenuItem(value: 'Recolector', child: Text('Recolector')),
                DropdownMenuItem(value: 'Jornalero', child: Text('Jornalero')),
              ],
              onChanged: (valor) {
                if (valor != null) {
                  setState(() {
                    _tipoTrabajadorSeleccionado = valor;
                  });
                }
              },
            ),
            const SizedBox(height: 20.0),

            // Tarifa Base
            TextFormField(
              controller: _tarifaControlador,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                labelText: _tipoTrabajadorSeleccionado == 'Recolector'
                    ? 'Tarifa por Kilo (COP)'
                    : 'Tarifa de Jornal diario (COP)',
                labelStyle: const TextStyle(fontSize: 16.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                prefixIcon: const Icon(Icons.attach_money),
              ),
              validator: (valor) {
                if (valor == null || valor.isEmpty) {
                  return 'Por favor ingresa la tarifa';
                }
                final tarifa = double.tryParse(valor);
                if (tarifa == null || tarifa <= 0) {
                  return 'Por favor ingresa un número válido mayor a 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 28.0),

            // Botón de Guardar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56.0),
              ),
              onPressed: () {
                if (_formularioKey.currentState!.validate()) {
                  ref.read(trabajadoresNotifierProvider.notifier).agregarTrabajador(
                        nombreCompleto: _nombreControlador.text.trim(),
                        tipoTrabajador: _tipoTrabajadorSeleccionado,
                        tarifaBase: double.parse(_tarifaControlador.text),
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Guardar Trabajador',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
