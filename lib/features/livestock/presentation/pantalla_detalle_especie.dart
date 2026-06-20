import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/pecuario_notifier.dart';
import 'providers/especie_detalle_notifier.dart';
import '../domain/entidades_pecuario.dart';

class PantallaDetalleEspecie extends ConsumerWidget {
  final String especieId;
  const PantallaDetalleEspecie({super.key, required this.especieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final especieAsync = ref.watch(pecuarioNotifierProvider);
    final detalleAsync = ref.watch(especieDetalleProvider(especieId));

    return especieAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (especies) {
        final especie = especies.firstWhere((e) => e.id == especieId);

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(especie.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
              backgroundColor: const Color(0xFF1B5E20),
              foregroundColor: Colors.white,
              bottom: const TabBar(
                indicatorColor: Colors.white,
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                tabs: [
                  Tab(icon: Icon(Icons.medical_services_outlined), text: 'Salud'),
                  Tab(icon: Icon(Icons.restaurant), text: 'Alimento'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _TabSalud(especie: especie),
                _TabAlimentacion(especie: especie),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TabSalud extends ConsumerWidget {
  final EspecieEntity especie;
  const _TabSalud({required this.especie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalle = ref.watch(especieDetalleProvider(especie.id));

    return detalle.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (state) {
        return Column(
          children: [
            Expanded(
              child: state.controles.isEmpty
                  ? const Center(child: Text('Sin registros sanitarios', style: TextStyle(fontSize: 18, color: Colors.grey)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.controles.length,
                      itemBuilder: (context, i) {
                        final c = state.controles[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            leading: const Icon(Icons.vaccines, color: Colors.red, size: 30),
                            title: Text('${c.tipo}: ${c.producto}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Aplicado: ${c.fechaAplicacion.day}/${c.fechaAplicacion.month}\nPróxima: ${c.proximaDosis.day}/${c.proximaDosis.month}'),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                onPressed: () => _mostrarFormSalud(context, ref, especie),
                icon: const Icon(Icons.add_moderator),
                label: const Text('REGISTRAR VACUNA / PURGA'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _mostrarFormSalud(BuildContext context, WidgetRef ref, EspecieEntity especie) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _FormSaludModal(especie: especie),
    );
  }
}

class _TabAlimentacion extends ConsumerWidget {
  final EspecieEntity especie;
  const _TabAlimentacion({required this.especie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalle = ref.watch(especieDetalleProvider(especie.id));

    return detalle.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (state) {
        return Column(
          children: [
            Expanded(
              child: state.alimentacion.isEmpty
                  ? const Center(child: Text('Sin registros de alimentación', style: TextStyle(fontSize: 18, color: Colors.grey)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.alimentacion.length,
                      itemBuilder: (context, i) {
                        final a = state.alimentacion[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            leading: const Icon(Icons.shopping_basket, color: Colors.orange, size: 30),
                            title: Text(a.producto, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Cantidad: ${a.cantidadKilos} kg'),
                            trailing: Text('${a.fecha.day}/${a.fecha.month}', style: const TextStyle(color: Colors.grey)),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                onPressed: () => _mostrarFormComida(context, ref, especie),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('REGISTRAR CONSUMO'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _mostrarFormComida(BuildContext context, WidgetRef ref, EspecieEntity especie) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _FormComidaModal(especie: especie),
    );
  }
}

class _FormSaludModal extends ConsumerStatefulWidget {
  final EspecieEntity especie;
  const _FormSaludModal({required this.especie});
  @override
  ConsumerState<_FormSaludModal> createState() => _FormSaludModalState();
}

class _FormSaludModalState extends ConsumerState<_FormSaludModal> {
  final _prodCtrl = TextEditingController();
  String _tipo = 'Vacuna';
  DateTime _proxima = DateTime.now().add(const Duration(days: 90));

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 24 + padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Registro de Salud', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _tipo,
            items: ['Vacuna', 'Purga', 'Vitamina'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (v) => setState(() => _tipo = v!),
            decoration: const InputDecoration(labelText: 'Tipo de aplicación', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(controller: _prodCtrl, decoration: const InputDecoration(labelText: 'Nombre del Producto', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          const Text('Próxima dosis recomendada:', style: TextStyle(fontWeight: FontWeight.bold)),
          ListTile(
            title: Text('${_proxima.day}/${_proxima.month}/${_proxima.year}'),
            trailing: const Icon(Icons.calendar_month),
            onTap: () async {
              final pick = await showDatePicker(context: context, initialDate: _proxima, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
              if (pick != null) setState(() => _proxima = pick);
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.read(especieDetalleProvider(widget.especie.id).notifier).registrarSalud(
                tipo: _tipo,
                producto: _prodCtrl.text,
                fecha: DateTime.now(),
                proxima: _proxima,
                nombreEspecie: widget.especie.nombre,
              );
              Navigator.pop(context);
            },
            child: const Text('GUARDAR Y AGENDAR'),
          ),
        ],
      ),
    );
  }
}

class _FormComidaModal extends ConsumerStatefulWidget {
  final EspecieEntity especie;
  const _FormComidaModal({required this.especie});
  @override
  ConsumerState<_FormComidaModal> createState() => _FormComidaModalState();
}

class _FormComidaModalState extends ConsumerState<_FormComidaModal> {
  final _prodCtrl = TextEditingController();
  final _cantCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 24 + padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Registro de Alimento', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(controller: _prodCtrl, decoration: const InputDecoration(labelText: 'Producto (Ej: Purina Crecimiento)', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          TextField(controller: _cantCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Cantidad (Kilos)', border: OutlineInputBorder())),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.read(especieDetalleProvider(widget.especie.id).notifier).registrarComida(
                producto: _prodCtrl.text,
                kilos: double.tryParse(_cantCtrl.text) ?? 0,
              );
              Navigator.pop(context);
            },
            child: const Text('REGISTRAR CONSUMO'),
          ),
        ],
      ),
    );
  }
}
