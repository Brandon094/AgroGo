import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/trabajadores_notifier.dart';
import 'providers/gestion_administrativa_orchestrator.dart';
import '../domain/trabajador_model.dart';
import '../../../core/utils/formatters.dart';

class PantallaNominaSemanal extends ConsumerWidget {
  const PantallaNominaSemanal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumenFuture = ref.watch(gestionAdministrativaOrchestratorProvider.notifier).obtenerResumenNominaSemanal();
    final trabajadoresAsync = ref.watch(trabajadoresNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      appBar: AppBar(
        title: const Text('Liquidación Semanal', style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<ResumenTrabajadorNomina>>(
        future: resumenFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final resumen = snapshot.data ?? [];
          if (resumen.isEmpty) {
            return const Center(
              child: Text('No hay labores registradas esta semana', 
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            );
          }

          return trabajadoresAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error al cargar nombres: $e')),
            data: (trabajadores) {
              final totalGlobal = resumen.fold<double>(0, (sum, r) => sum + r.totalPagar);

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                    ),
                    child: Column(
                      children: [
                        const Text('TOTAL NÓMINA DE LA SEMANA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 1.5)),
                        const SizedBox(height: 8),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            Formateadores.formatearMoneda(totalGlobal), 
                            style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Color(0xFF00695C))
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: resumen.length,
                      itemBuilder: (context, index) {
                        final item = resumen[index];
                        final trabajador = trabajadores.firstWhere(
                          (t) => t.id == item.trabajadorId.toString(),
                          orElse: () => TrabajadorEntity(id: '', nombreCompleto: 'Desconocido', tipoTrabajador: '', tarifaBase: 0, fechaIngreso: DateTime.now()),
                        );

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xFF00695C).withOpacity(0.1),
                              child: const Icon(Icons.payments_rounded, color: Color(0xFF00695C)),
                            ),
                            title: Text(trabajador.nombreCompleto, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                            subtitle: const Text('Acumulado semana', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                            trailing: Text(
                              Formateadores.formatearMoneda(item.totalPagar), 
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF2E7D32))
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
