import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'providers/pecuario_notifier.dart';
import 'providers/especie_detalle_notifier.dart';
import '../domain/entidades_pecuario.dart';
import '../../inventory_management/presentation/providers/insumos_notifier.dart';
import '../../inventory_management/domain/insumo_model.dart';

class PantallaDetalleEspecie extends ConsumerWidget {
  final String especieId;
  const PantallaDetalleEspecie({super.key, required this.especieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final especieAsync = ref.watch(pecuarioNotifierProvider);

    return especieAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (especies) {
        final especie = especies.firstWhere((e) => e.id == especieId);

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(especie.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text('${especie.cantidadActual} ${especie.tipoEspecie}', style: const TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
              backgroundColor: const Color(0xFF1B5E20),
              foregroundColor: Colors.white,
              bottom: const TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 4,
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                tabs: [
                  Tab(icon: Icon(Icons.health_and_safety), text: 'Salud'),
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
                  ? const _VistaVacia(mensaje: 'Sin registros sanitarios', icono: Icons.vaccines_outlined)
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.controles.length,
                      itemBuilder: (context, i) {
                        final c = state.controles[i];
                        final fAplicacion = DateFormat('d MMM', 'es_CO').format(c.fechaAplicacion);
                        final fProxima = DateFormat('d MMM yyyy', 'es_CO').format(c.proximaDosis);
                        
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.red.shade50,
                                  child: Icon(Icons.medical_information, color: Colors.red.shade800),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${c.tipo}: ${c.producto}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                      const SizedBox(height: 4),
                                      Text('Aplicado: $fAplicacion', style: TextStyle(color: Colors.grey.shade600)),
                                      Text('Próxima: $fProxima', style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            _BotonAccion(
              onTap: () => _mostrarFormSalud(context, ref, especie),
              label: 'NUEVO CONTROL DE SALUD',
              icon: Icons.add_moderator,
              color: Colors.red.shade800,
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
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
                  ? const _VistaVacia(mensaje: 'Sin registros de comida', icono: Icons.bakery_dining_outlined)
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.alimentacion.length,
                      itemBuilder: (context, i) {
                        final a = state.alimentacion[i];
                        final fecha = DateFormat('EEEE d, MMM', 'es_CO').format(a.fecha);
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            leading: const Icon(Icons.shopping_basket, color: Colors.orange, size: 30),
                            title: Text(a.producto, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Consumo: ${a.cantidadKilos} kg'),
                            trailing: Text(fecha, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          ),
                        );
                      },
                    ),
            ),
            _BotonAccion(
              onTap: () => _mostrarFormComida(context, ref, especie),
              label: 'REGISTRAR ALIMENTACIÓN',
              icon: Icons.add_shopping_cart,
              color: Colors.orange.shade800,
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => _FormComidaModal(especie: especie),
    );
  }
}

class _BotonAccion extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final IconData icon;
  final Color color;
  const _BotonAccion({required this.onTap, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 64),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        icon: Icon(icon, size: 28),
        label: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
      ),
    );
  }
}

class _VistaVacia extends StatelessWidget {
  final String mensaje;
  final IconData icono;
  const _VistaVacia({required this.mensaje, required this.icono});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icono, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(mensaje, style: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
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
      padding: EdgeInsets.fromLTRB(24, 32, 24, 32 + padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Registro de Salud', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: _tipo,
            items: ['Vacuna', 'Purga', 'Vitamina', 'Medicamento'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (v) => setState(() => _tipo = v!),
            decoration: const InputDecoration(labelText: 'Tipo de tratamiento', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _prodCtrl, 
            decoration: const InputDecoration(labelText: 'Nombre del Producto', border: OutlineInputBorder(), prefixIcon: Icon(Icons.medication)),
          ),
          const SizedBox(height: 24),
          const Text('PRÓXIMA DOSIS / REFUERZO', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(DateFormat('EEEE d ' 'de' ' MMMM, yyyy', 'es_CO').format(_proxima)),
            leading: const Icon(Icons.calendar_month, color: Colors.purple),
            onTap: () async {
              final pick = await showDatePicker(
                context: context, 
                initialDate: _proxima, 
                firstDate: DateTime.now(), 
                lastDate: DateTime.now().add(const Duration(days: 365))
              );
              if (pick != null) setState(() => _proxima = pick);
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(0, 60), backgroundColor: Colors.red.shade800),
            onPressed: () {
              if (_prodCtrl.text.isEmpty) return;
              HapticFeedback.mediumImpact();
              ref.read(especieDetalleProvider(widget.especie.id).notifier).registrarSalud(
                tipo: _tipo,
                producto: _prodCtrl.text,
                fecha: DateTime.now(),
                proxima: _proxima,
                nombreEspecie: widget.especie.nombre,
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Salud registrada y agendada')));
            },
            child: const Text('GUARDAR Y AGENDAR', style: TextStyle(fontWeight: FontWeight.bold)),
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
  InsumoEntity? _insumoSeleccionado;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    final insumosAsync = ref.watch(insumosNotifierProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 32, 24, 32 + padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Consumo de Alimento', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          
          insumosAsync.maybeWhen(
            data: (insumos) {
              final purinas = insumos.where((i) => i.nombre.toLowerCase().contains('purina') || i.nombre.toLowerCase().contains('alimento')).toList();
              return DropdownButtonFormField<InsumoEntity>(
                value: _insumoSeleccionado,
                decoration: const InputDecoration(labelText: 'Descontar de Bodega (Opcional)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.inventory)),
                items: insumos.map((i) => DropdownMenuItem(value: i, child: Text('${i.nombre} (${i.cantidadActual} ${i.unidadMedida})'))).toList(),
                onChanged: (v) {
                  setState(() {
                    _insumoSeleccionado = v;
                    if (v != null) _prodCtrl.text = v.nombre;
                  });
                },
              );
            },
            orElse: () => const Text('Cargando insumos...'),
          ),
          
          const SizedBox(height: 16),
          TextField(
            controller: _prodCtrl, 
            decoration: const InputDecoration(labelText: 'Nombre del Alimento', border: OutlineInputBorder(), prefixIcon: Icon(Icons.restaurant)),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _cantCtrl, 
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(
              labelText: 'Cantidad consumida', 
              suffixText: _insumoSeleccionado?.unidadMedida ?? 'Kilos',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.scale),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(0, 60), backgroundColor: Colors.orange.shade800),
            onPressed: () {
              final kilos = double.tryParse(_cantCtrl.text) ?? 0;
              if (kilos <= 0 || _prodCtrl.text.isEmpty) return;
              
              HapticFeedback.mediumImpact();
              ref.read(especieDetalleProvider(widget.especie.id).notifier).registrarComida(
                producto: _prodCtrl.text,
                kilos: kilos,
                insumoId: _insumoSeleccionado?.id,
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Consumo registrado con éxito')));
            },
            child: const Text('REGISTRAR CONSUMO', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
