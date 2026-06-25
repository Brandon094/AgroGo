import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/costos_notifier.dart';
import 'package:agrogo/features/maps_and_lots/presentation/providers/panel_lotes_notifier.dart';
import 'package:agrogo/features/maps_and_lots/domain/lote_model.dart';
import 'package:agrogo/features/inventory_costs/domain/calculadora_insumos_usecase.dart';
import '../../inventory_management/presentation/providers/insumos_notifier.dart';
import '../../inventory_management/domain/insumo_model.dart';
import '../../livestock/presentation/providers/pecuario_notifier.dart';
import '../../livestock/domain/entidades_pecuario.dart';
import '../../../core/utils/formatters.dart';

class PantallaPanelCostos extends ConsumerStatefulWidget {
  final bool abrirCalculadora;
  final bool abrirFormulario;
  const PantallaPanelCostos({super.key, this.abrirCalculadora = false, this.abrirFormulario = false});
  @override
  ConsumerState<PantallaPanelCostos> createState() => _PantallaPanelCostosState();
}

class _PantallaPanelCostosState extends ConsumerState<PantallaPanelCostos> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.abrirCalculadora) _mostrarCalculadoraInsumos(context, ref);
      else if (widget.abrirFormulario) _mostrarFormularioAgregar(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final estadoCostos = ref.watch(costosNotifierProvider);
    final totalAcumulado = ref.read(costosNotifierProvider.notifier).obtenerTotalAcumulado();
    final estadoLotes = ref.watch(panelLotesNotifierProvider);

    final mapaLotes = estadoLotes.maybeWhen(
      data: (lotes) => {for (var l in lotes) l.id: l},
      orElse: () => <String, Lote>{},
    );

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
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Finanzas',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF37474F)),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.payments_rounded, color: Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Theme.of(context).primaryColor, const Color(0xFF2E7D32)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          const Text('INVERSIÓN TOTAL ACUMULADA', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                          const SizedBox(height: 8),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              Formateadores.formatearMoneda(totalAcumulado),
                              style: const TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: InkWell(
                  onTap: () => _mostrarCalculadoraInsumos(context, ref),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.blue.shade100, width: 2),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                          child: const Icon(Icons.calculate_rounded, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('PROYECTAR COMPRAS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.blue)),
                              Text('Calculadora de abono', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF37474F))),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, color: Colors.blue, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            estadoCostos.when(
              loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
              error: (error, stack) => SliverFillRemaining(child: Center(child: Text('Error: $error'))),
              data: (costos) {
                if (costos.isEmpty) {
                  return const SliverFillRemaining(child: Center(child: Text('Sin registros de gastos', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))));
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => RepaintBoundary(
                        child: _TarjetaGasto(
                          gasto: costos[index],
                          lote: costos[index].loteId != null ? mapaLotes[costos[index].loteId] : null,
                          onDelete: () => _confirmarEliminacion(context, ref, costos[index]),
                        ),
                      ),
                      childCount: costos.length,
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
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        label: const Text('REGISTRAR COMPRA', style: TextStyle(fontWeight: FontWeight.w900)),
        icon: const Icon(Icons.add_shopping_cart_rounded),
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, WidgetRef ref, dynamic gasto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar registro?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          TextButton(
            onPressed: () async { 
              await ref.read(costosNotifierProvider.notifier).eliminarCosto(gasto.id); 
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Registro de gasto eliminado'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }, 
            child: const Text('ELIMINAR', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _mostrarCalculadoraInsumos(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(context: context, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32.0))), builder: (context) => const _ModalCalculadoraInsumos());
  }

  void _mostrarFormularioAgregar(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(context: context, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32.0))), builder: (context) => const _FormularioCostoModal());
  }
}

class _TarjetaGasto extends StatelessWidget {
  final dynamic gasto;
  final Lote? lote;
  final VoidCallback onDelete;
  const _TarjetaGasto({required this.gasto, this.lote, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(Icons.receipt_long_rounded, color: Colors.blue.shade800),
        ),
        title: Text(gasto.nombreItem, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
        subtitle: Text(lote != null ? 'Lote: ${lote!.nombre}' : gasto.categoria, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              Formateadores.formatearMoneda(gasto.precioTotal.toDouble()), 
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF2E7D32))
            ),
          ],
        ),
      ),
    );
  }
}

class _ModalCalculadoraInsumos extends ConsumerStatefulWidget {
  const _ModalCalculadoraInsumos();
  @override
  ConsumerState<_ModalCalculadoraInsumos> createState() => _ModalCalculadoraInsumosState();
}

class _ModalCalculadoraInsumosState extends ConsumerState<_ModalCalculadoraInsumos> {
  final _calculadora = CalculadoraInsumosUseCase();
  Lote? _loteSeleccionado;
  EspecieEntity? _especieSeleccionada;

  final _gramosCtrl = TextEditingController(text: '50.0');
  final _precioUnitarioCtrl = TextEditingController();
  
  // Para Fumigación
  final _matasPorBombaCtrl = TextEditingController(text: '400');
  final _capacidadBombaCtrl = TextEditingController(text: '20');

  // Para Alimento Animal
  final _grDiaAnimalCtrl = TextEditingController(text: '100');
  final _diasProyeccionCtrl = TextEditingController(text: '30');

  int _tipoCalculo = 0; // 0: Abono, 1: Fumigación, 2: Alimento Animal
  int? _resultadoCant;
  double? _totalCosto;

  @override
  void dispose() {
    _gramosCtrl.dispose();
    _precioUnitarioCtrl.dispose();
    _matasPorBombaCtrl.dispose();
    _capacidadBombaCtrl.dispose();
    _grDiaAnimalCtrl.dispose();
    _diasProyeccionCtrl.dispose();
    super.dispose();
  }

  void _calcular() {
    final precioUnitario = double.tryParse(_precioUnitarioCtrl.text) ?? 0;

    setState(() {
      if (_tipoCalculo == 0) {
        final lote = _loteSeleccionado ?? ref.read(panelLotesNotifierProvider).valueOrNull?.first;
        if (lote == null) return;
        final gramos = double.tryParse(_gramosCtrl.text) ?? 0;
        _resultadoCant = _calculadora.calcularBultosAbono(
          numeroMatas: lote.numeroMatas, 
          gramosPorMata: gramos, 
          kilosPorBulto: 50.0,
        );
      } else if (_tipoCalculo == 1) {
        final lote = _loteSeleccionado ?? ref.read(panelLotesNotifierProvider).valueOrNull?.first;
        if (lote == null) return;
        final matasPorBomba = int.tryParse(_matasPorBombaCtrl.text) ?? 1;
        final res = _calculadora.calcularFumigacion(
          numeroMatas: lote.numeroMatas, 
          rendimientoMatasPorBomba: matasPorBomba, 
          capacidadBombaLitros: double.tryParse(_capacidadBombaCtrl.text) ?? 20,
        );
        _resultadoCant = res.bombas;
      } else {
        final especie = _especieSeleccionada ?? ref.read(pecuarioNotifierProvider).valueOrNull?.first;
        if (especie == null) return;
        _resultadoCant = _calculadora.calcularBultosAlimento(
          cantidadAnimales: especie.cantidadActual, 
          gramosDiaPorAnimal: double.tryParse(_grDiaAnimalCtrl.text) ?? 0, 
          diasProyeccion: int.tryParse(_diasProyeccionCtrl.text) ?? 0, 
          kilosPorBulto: 40.0, // Estándar alimento concentrado
        );
      }

      if (precioUnitario > 0 && _resultadoCant != null) {
        _totalCosto = _resultadoCant! * precioUnitario;
      }
    });
  }

  Future<void> _registrarComoCompra() async {
    if (_resultadoCant == null || _totalCosto == null || _totalCosto! <= 0) return;
    
    String nombreItem;
    if (_tipoCalculo == 0) nombreItem = 'Abono: ${_resultadoCant} bultos';
    else if (_tipoCalculo == 1) nombreItem = 'Insumos Fumigación: ${_resultadoCant} bombas';
    else nombreItem = 'Concentrado: ${_resultadoCant} bultos para ${_especieSeleccionada?.nombre}';

    // 1. Registrar el Gasto Financiero
    await ref.read(costosNotifierProvider.notifier).agregarCosto(
      nombre: nombreItem,
      categoria: 'Insumos',
      precioTotal: _totalCosto!,
      loteId: _tipoCalculo != 2 ? _loteSeleccionado?.id : null,
    );

    // 2. Sumar a la Bodega automáticamente
    final insumos = ref.read(insumosNotifierProvider).valueOrNull ?? [];
    
    if (_tipoCalculo == 0) {
      final abonoExistente = insumos.firstWhere(
        (i) => i.nombre.toLowerCase().contains('abono') || i.nombre.toLowerCase().contains('urea'),
        orElse: () => InsumoEntity(id: '', fincaId: '', nombre: 'Abono General', cantidadActual: 0, unidadMedida: 'Bultos', umbralMinimo: 5),
      );
      if (abonoExistente.id.isNotEmpty) await ref.read(insumosNotifierProvider.notifier).ajustarStock(abonoExistente.id, _resultadoCant!.toDouble());
      else await ref.read(insumosNotifierProvider.notifier).registrarInsumo(nombre: 'Abono (Compra Proyectada)', unidad: 'Bultos', stockInicial: _resultadoCant!.toDouble());
    } else if (_tipoCalculo == 1) {
      final fungicidaExistente = insumos.firstWhere(
        (i) => i.nombre.toLowerCase().contains('fungicida') || i.nombre.toLowerCase().contains('veneno') || i.nombre.toLowerCase().contains('fumiga'),
        orElse: () => InsumoEntity(id: '', fincaId: '', nombre: 'Insumo Fumigación', cantidadActual: 0, unidadMedida: 'Unidades', umbralMinimo: 5),
      );
      if (fungicidaExistente.id.isNotEmpty) await ref.read(insumosNotifierProvider.notifier).ajustarStock(fungicidaExistente.id, _resultadoCant!.toDouble());
      else await ref.read(insumosNotifierProvider.notifier).registrarInsumo(nombre: 'Insumos Fumigación (Proyectado)', unidad: 'Unidades', stockInicial: _resultadoCant!.toDouble(), umbral: 2);
    } else {
      final concentradoExistente = insumos.firstWhere(
        (i) => i.nombre.toLowerCase().contains('concentrado') || i.nombre.toLowerCase().contains('purina') || i.nombre.toLowerCase().contains('alimento'),
        orElse: () => InsumoEntity(id: '', fincaId: '', nombre: 'Concentrado Animal', cantidadActual: 0, unidadMedida: 'Bultos', umbralMinimo: 5),
      );
      if (concentradoExistente.id.isNotEmpty) await ref.read(insumosNotifierProvider.notifier).ajustarStock(concentradoExistente.id, _resultadoCant!.toDouble());
      else await ref.read(insumosNotifierProvider.notifier).registrarInsumo(nombre: 'Concentrado (Compra Proyectada)', unidad: 'Bultos', stockInicial: _resultadoCant!.toDouble(), umbral: 5);
    }

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Gasto y Stock actualizados para ${_tipoCalculo == 2 ? 'el alimento' : 'la labor'}'),
          backgroundColor: const Color(0xFF00695C),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lotes = ref.watch(panelLotesNotifierProvider).valueOrNull ?? [];
    final especies = ref.watch(pecuarioNotifierProvider).valueOrNull ?? [];

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.calculate_rounded, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              const Text('Calculadora Pro', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF37474F))),
            ],
          ),
          const SizedBox(height: 24),
          
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Abono'), icon: Icon(Icons.eco)),
                ButtonSegment(value: 1, label: Text('Fumigación'), icon: Icon(Icons.shutter_speed)),
                ButtonSegment(value: 2, label: Text('Animales'), icon: Icon(Icons.pets)),
              ],
              selected: {_tipoCalculo},
              onSelectionChanged: (set) => setState(() {
                _tipoCalculo = set.first;
                _resultadoCant = null;
                _totalCosto = null;
              }),
            ),
          ),
          
          const SizedBox(height: 24),
          if (_tipoCalculo != 2) ...[
            if (lotes.isNotEmpty) DropdownButtonFormField<Lote>(
              value: _loteSeleccionado ?? lotes.first, 
              decoration: const InputDecoration(labelText: 'Lote a trabajar', prefixIcon: Icon(Icons.landscape_rounded)),
              items: lotes.map((l) => DropdownMenuItem(value: l, child: Text(l.nombre))).toList(), 
              onChanged: (v) => setState(() => _loteSeleccionado = v)
            ) else const Text('No hay lotes para calcular.', style: TextStyle(color: Colors.red)),
          ] else ...[
            if (especies.isNotEmpty) DropdownButtonFormField<EspecieEntity>(
              value: _especieSeleccionada ?? especies.first, 
              decoration: const InputDecoration(labelText: 'Grupo Animal', prefixIcon: Icon(Icons.pets_rounded)),
              items: especies.map((e) => DropdownMenuItem(value: e, child: Text('${e.nombre} (${e.cantidadActual} ${e.tipoEspecie})'))).toList(), 
              onChanged: (v) => setState(() => _especieSeleccionada = v)
            ) else const Text('No hay animales registrados.', style: TextStyle(color: Colors.red)),
          ],
          
          const SizedBox(height: 16),
          if (_tipoCalculo == 0)
            TextField(controller: _gramosCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Dosis por mata', suffixText: 'gramos'))
          else if (_tipoCalculo == 1) ...[
            TextField(controller: _matasPorBombaCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Rendimiento por bomba', suffixText: 'matas')),
            const SizedBox(height: 16),
            TextField(controller: _capacidadBombaCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Capacidad de la Bomba', suffixText: 'Litros')),
          ] else ...[
            TextField(controller: _grDiaAnimalCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Dosis diaria por animal', suffixText: 'gr')),
            const SizedBox(height: 16),
            TextField(controller: _diasProyeccionCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Días de autonomía', suffixText: 'días')),
          ],
          
          const SizedBox(height: 16),
          TextField(
            controller: _precioUnitarioCtrl, 
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(
              labelText: _tipoCalculo == 1 ? 'Costo por bomba' : 'Precio por bulto',
              prefixText: '\$ ',
            ),
          ),
          
          if (_resultadoCant != null) ...[
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
                  Text(_tipoCalculo == 1 ? 'BOMBAS REQUERIDAS' : 'BULTOS NECESARIOS', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  Text('$_resultadoCant ${_tipoCalculo == 1 ? 'BOMBAS' : 'BULTOS'}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF00695C))),
                  if (_totalCosto != null) ...[
                    const Divider(height: 30),
                    const Text('PRESUPUESTO ESTIMADO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 1)),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        Formateadores.formatearMoneda(_totalCosto!), 
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.blue)
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (_totalCosto != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _registrarComoCompra,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('REGISTRAR COMO COMPRA REAL'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32)),
              ),
            ],
          ],
          
          const SizedBox(height: 32),
          if (_resultadoCant == null)
            ElevatedButton(
              onPressed: (lotes.isEmpty && _tipoCalculo != 2) || (especies.isEmpty && _tipoCalculo == 2) ? null : _calcular,
              child: const Text('CALCULAR PROYECCIÓN')
            ),
          const SizedBox(height: 12),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CERRAR', style: TextStyle(color: Colors.grey))),
        ]
      )
    );
  }
}

class _FormularioCostoModal extends ConsumerStatefulWidget {
  const _FormularioCostoModal();
  @override
  ConsumerState<_FormularioCostoModal> createState() => _FormularioCostoModalState();
}

class _FormularioCostoModalState extends ConsumerState<_FormularioCostoModal> {
  final _nombreCtrl = TextEditingController();
  final _precioCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(28, 32, 28, 32 + padding), 
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Nueva Compra', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: '¿Qué compró?', prefixIcon: Icon(Icons.shopping_bag_outlined))),
          const SizedBox(height: 16),
          TextField(
            controller: _precioCtrl, 
            keyboardType: TextInputType.number, 
            decoration: const InputDecoration(
              labelText: 'Precio Total Pagado', 
              prefixIcon: Icon(Icons.attach_money_rounded),
              suffixText: 'COP',
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(onPressed: () async { 
            if (_nombreCtrl.text.isNotEmpty && _precioCtrl.text.isNotEmpty) {
              await ref.read(costosNotifierProvider.notifier).agregarCosto(
                nombre: _nombreCtrl.text,
                categoria: 'Insumos', 
                precioTotal: double.parse(_precioCtrl.text)
              ); 
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Gasto registrado correctamente'),
                    backgroundColor: Color(0xFF2E7D32),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }
          }, child: const Text('GUARDAR GASTO'))
        ]
      )
    );
  }
}
