import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:agrogo/core/routing/pantalla_principal_shell.dart';
import 'package:agrogo/features/maps_and_lots/presentation/pantalla_panel_lotes.dart';
import 'package:agrogo/features/maps_and_lots/presentation/pantalla_mapa_lotes.dart';
import 'package:agrogo/features/maps_and_lots/presentation/pantalla_mapa_finca.dart';
import 'package:agrogo/features/field_workers/presentation/pantalla_lista_trabajadores.dart';
import 'package:agrogo/features/inventory_costs/presentation/pantalla_panel_costos.dart';
import 'package:agrogo/features/farm_calendar/presentation/pantalla_cronograma.dart';
import 'package:agrogo/features/livestock/presentation/pantalla_panel_pecuario.dart';
import 'package:agrogo/features/livestock/presentation/pantalla_detalle_especie.dart';
import 'package:agrogo/features/home/presentation/pantalla_inicio.dart';
import 'package:agrogo/features/farms/presentation/pantalla_mis_fincas.dart';
import 'package:agrogo/features/maps_and_lots/presentation/pantalla_mapa_global.dart';
import 'package:agrogo/features/inventory_management/presentation/pantalla_bodega.dart';

class EnrutadorApp {
  static final GlobalKey<NavigatorState> _navigatorRaizKey = GlobalKey<NavigatorState>(debugLabel: 'raiz');

  static final GoRouter enrutador = GoRouter(
    navigatorKey: _navigatorRaizKey,
    initialLocation: '/',
    routes: [
      // Selección de Finca (Root)
      GoRoute(
        path: '/',
        builder: (context, state) => const PantallaMisFincas(),
      ),

      // Shell de Navegación para la Finca Seleccionada
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return PantallaPrincipalShell(navigationShell: navigationShell);
        },
        branches: [
          // Rama 1: Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const PantallaInicio(),
                routes: [
                  GoRoute(
                    path: 'animales',
                    builder: (context, state) => const PantallaPanelPecuario(),
                    routes: [
                      GoRoute(
                        path: 'detalle/:id',
                        builder: (context, state) {
                          final id = state.pathParameters['id']!;
                          return PantallaDetalleEspecie(especieId: id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Rama 2: Lotes
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/lotes',
                builder: (context, state) => const PantallaPanelLotes(),
                routes: [
                  GoRoute(
                    path: 'nuevo-lote',
                    builder: (context, state) => const PantallaMapaLotes(),
                  ),
                ],
              ),
            ],
          ),
          // Rama 3: Agenda
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/agenda',
                builder: (context, state) => const PantallaCronograma(),
              ),
            ],
          ),
        ],
      ),

      // Rutas Independientes (Full Screen)
      GoRoute(
        path: '/trabajadores',
        parentNavigatorKey: _navigatorRaizKey,
        builder: (context, state) => const PantallaListaTrabajadores(),
      ),
      GoRoute(
        path: '/gastos',
        parentNavigatorKey: _navigatorRaizKey,
        builder: (context, state) => const PantallaPanelCostos(),
      ),
      GoRoute(
        path: '/mapa-finca',
        parentNavigatorKey: _navigatorRaizKey,
        builder: (context, state) => const PantallaMapaFinca(),
      ),
      GoRoute(
        path: '/mapa-global',
        parentNavigatorKey: _navigatorRaizKey,
        builder: (context, state) => const PantallaMapaGlobal(),
      ),
      GoRoute(
        path: '/bodega',
        parentNavigatorKey: _navigatorRaizKey,
        builder: (context, state) => const PantallaBodega(),
      ),
    ],
  );
}
