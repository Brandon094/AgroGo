import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'providers/trabajadores_notifier.dart';
import 'providers/gestion_administrativa_orchestrator.dart';
import '../../maps_and_lots/presentation/providers/panel_lotes_notifier.dart';
import '../../maps_and_lots/domain/lote_model.dart';
import '../domain/trabajador_model.dart';
import '../data/registro_labor_isar_model.dart';
import '../../../core/utils/formatters.dart';

class PantallaListaTrabajadores extends ConsumerWidget {
  const PantallaListaTrabajadores({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoTrabajadores = ref.watch(trabajadoresNotifierProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF9FBF9), Colors.white],
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 70, 24, 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mi Equipo',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF37474F)),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.people_alt_rounded, color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => context.push('/nomina-semanal'),
                      icon: const Icon(Icons.receipt_long_rounded),
                      label: const Text('VER LIQUIDACIÓN SEMANAL', style: TextStyle(fontWeight: FontWeight.w900)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade50,
                        foregroundColor: const Color(0xFF00695C),
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 56),
                        side: BorderSide(color: const Color(0xFF00695C).withOpacity(0.2)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'GESTIÓN DE NÓMINA Y LABORES',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.teal, letterSpacing: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            estadoTrabajadores.when(
              loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
              error: (error, stack) => SliverFillRemaining(child: Center(child: Text('Error: $error'))),
              data: (trabajadores) {
                if (trabajadores.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_add_alt_1_rounded, size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('No hay personas en el equipo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                        ],
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => RepaintBoundary(
                        child: _TarjetaTrabajador(trabajador: trabajadores[index]),
                      ),
                      childCount: trabajadores.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormularioAgregar(context, ref),
        backgroundColor: const Color(0xFF00695C),
        foregroundColor: Colors.white,
        label: const Text('NUEVO TRABAJADOR', style: TextStyle(fontWeight: FontWeight.w900)),
        icon: const Icon(Icons.person_add_rounded),
      ),
    );
  }

  void _mostrarFormularioAgregar(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => const _FormularioTrabajadorModal(),
    );
  }
}

class _TarjetaTrabajador extends ConsumerWidget {
  final TrabajadorEntity trabajador;
  const _TarjetaTrabajador({required this.trabajador});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final esRecolector = trabajador.tipoTrabajador == 'Recolector';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: const Border(),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Icon(Icons.person_rounded, color: Theme.of(context).primaryColor, size: 28),
        ),
        title: Text(trabajador.nombreCompleto, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF37474F))),
        subtitle: Text(
          esRecolector 
            ? 'Recolector • ${Formateadores.formatearMoneda(trabajador.tarifaBase)} / Kilo'
            : 'Jornalero • ${Formateadores.formatearMoneda(trabajador.tarifaBase)} / Día',
          style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 13),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
          onPressed: () => _confirmarEliminacion(context, ref),
        ),
        children: [
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF57C00),
                      minimumSize: const Size(0, 56),
                    ),
                    onPressed: () => _mostrarFormLabor(context, ref),
                    icon: const Icon(Icons.add_task_rounded),
                    label: const Text('REGISTRAR LABOR'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarFormLabor(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => _FormularioRegistroLabor(trabajador: trabajador),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar trabajador?'),
        content: Text('Esta acción retirará a ${trabajador.nombreCompleto} de la nómina.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          TextButton(
            onPressed: () async {
              await ref.read(trabajadoresNotifierProvider.notifier).eliminarTrabajador(trabajador.id);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${trabajador.nombreCompleto} ha sido retirado'),
                    backgroundColor: Colors.red.shade800,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('ELIMINAR', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _FormularioRegistroLabor extends ConsumerStatefulWidget {
  final TrabajadorEntity trabajador;
  const _FormularioRegistroLabor({required this.trabajador});
  @override
  ConsumerState<_FormularioRegistroLabor> createState() => _FormularioRegistroLaborState();
}

class _FormularioRegistroLaborState extends ConsumerState<_FormularioRegistroLabor> {
  final _kilosCtrl = TextEditingController();
  Lote? _loteSeleccionado;
  bool _conComida = false;
  late String _tipoPago;
  double _pagoEstimado = 0;

  @override
  void initState() {
    super.initState();
    _tipoPago = widget.trabajador.tipoTrabajador == 'Recolector' ? 'porKilo' : 'jornalFijo';
    _kilosCtrl.addListener(_recalcularPago);
    
    // Mostramos el pago inicial (especialmente útil para jornaleros)
    WidgetsBinding.instance.addPostFrameCallback((_) => _recalcularPago());
  }

  void _recalcularPago() {
    setState(() {
      _pagoEstimado = RegistroLaborIsarModel.calcularPago(
        tipo: _tipoPago,
        kilos: double.tryParse(_kilosCtrl.text),
        tarifaBase: widget.trabajador.tarifaBase,
        conAlimentacion: _conComida,
      );
    });
  }

  @override
  void dispose() {
    _kilosCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lotesAsync = ref.watch(panelLotesNotifierProvider);
    final padding = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Labor: ${widget.trabajador.nombreCompleto}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          lotesAsync.maybeWhen(
            data: (lotes) => DropdownButtonFormField<Lote>(
              value: _loteSeleccionado,
              decoration: const InputDecoration(labelText: 'Lote de trabajo', prefixIcon: Icon(Icons.landscape_rounded)),
              items: lotes.map((l) => DropdownMenuItem(value: l, child: Text(l.nombre))).toList(),
              onChanged: (v) => setState(() => _loteSeleccionado = v),
            ),
            orElse: () => const Text('Cargando lotes...'),
          ),
          if (widget.trabajador.tipoTrabajador == 'Recolector') ...[
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _tipoPago,
              decoration: const InputDecoration(labelText: 'Sistema de Pago', prefixIcon: Icon(Icons.payments_rounded)),
              items: const [
                DropdownMenuItem(value: 'porKilo', child: Text('Por Kilo')),
                DropdownMenuItem(value: 'porArroba', child: Text('Por Arroba (12.5 kg)')),
              ],
              onChanged: (v) {
                setState(() => _tipoPago = v!);
                _recalcularPago();
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _kilosCtrl, 
              keyboardType: TextInputType.number, 
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Cantidad recolectada', 
                prefixIcon: const Icon(Icons.scale_rounded),
                suffixText: _tipoPago == 'porKilo' ? 'Kilos' : 'Arrobas',
              ),
            ),
          ],
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(16)),
            child: SwitchListTile(
              title: const Text('¿Incluye Alimentación?', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Se descuenta \$15,000 del pago'),
              value: _conComida,
              activeColor: Colors.teal,
              onChanged: (v) {
                setState(() => _conComida = v);
                _recalcularPago();
              },
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF00695C).withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFF00695C).withOpacity(0.2)),
            ),
            child: Column(
              children: [
                const Text('PAGO NETO PARA EL TRABAJADOR', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 1)),
                const SizedBox(height: 8),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    Formateadores.formatearMoneda(_pagoEstimado), 
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF00695C))
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () async {
              if (_loteSeleccionado == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('⚠️ Por favor seleccione un lote'), backgroundColor: Colors.orange),
                );
                return;
              }

              final kilosStr = _kilosCtrl.text;
              if (widget.trabajador.tipoTrabajador == 'Recolector' && kilosStr.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('⚠️ Por favor ingrese los kilos recolectados'), backgroundColor: Colors.orange),
                );
                return;
              }

              final kilos = double.tryParse(kilosStr);

              await ref.read(gestionAdministrativaOrchestratorProvider.notifier).liquidarLaborDiaria(
                trabajadorId: int.parse(widget.trabajador.id),
                loteId: int.parse(_loteSeleccionado!.id),
                tipoPago: _tipoPago,
                kilos: kilos,
                tarifaBase: widget.trabajador.tarifaBase,
                conAlimentacion: _conComida,
              );
              
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Labor diaria registrada con éxito'),
                    backgroundColor: Color(0xFF00695C),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('GUARDAR REGISTRO'),
          ),
        ],
      ),
    );
  }
}

class _FormularioTrabajadorModal extends ConsumerStatefulWidget {
  const _FormularioTrabajadorModal();
  @override
  ConsumerState<_FormularioTrabajadorModal> createState() => _FormularioTrabajadorModalState();
}

class _FormularioTrabajadorModalState extends ConsumerState<_FormularioTrabajadorModal> {
  final _formularioKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _tarifaCtrl = TextEditingController();
  String _tipo = 'Recolector';

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _tarifaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + padding),
      child: Form(
        key: _formularioKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Nuevo Trabajador', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nombreCtrl, 
              decoration: const InputDecoration(labelText: 'Nombre Completo', prefixIcon: Icon(Icons.person_outline_rounded)),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              validator: (v) => v!.isEmpty ? 'Ingrese el nombre' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _tipo,
              decoration: const InputDecoration(labelText: 'Tipo de Trabajo', prefixIcon: Icon(Icons.work_outline_rounded)),
              items: const [
                DropdownMenuItem(value: 'Recolector', child: Text('Recolector')),
                DropdownMenuItem(value: 'Jornalero', child: Text('Jornalero')),
              ],
              onChanged: (v) => setState(() => _tipo = v!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tarifaCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: _tipo == 'Recolector' ? 'Tarifa por Kilo (COP)' : 'Tarifa por Día (COP)',
                prefixIcon: const Icon(Icons.attach_money_rounded),
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              validator: (v) => v!.isEmpty ? 'Ingrese la tarifa' : null,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                if (_formularioKey.currentState!.validate()) {
                  await ref.read(trabajadoresNotifierProvider.notifier).agregarTrabajador(
                    nombreCompleto: _nombreCtrl.text.trim(),
                    tipoTrabajador: _tipo,
                    tarifaBase: double.parse(_tarifaCtrl.text),
                  );
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Trabajador registrado en el equipo'),
                        backgroundColor: Color(0xFF00695C),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              },
              child: const Text('GUARDAR TRABAJADOR'),
            ),
          ],
        ),
      ),
    );
  }
}
