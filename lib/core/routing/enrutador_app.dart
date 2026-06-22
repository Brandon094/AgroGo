import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
import 'package:agrogo/features/farms/presentation/pantalla_onboarding.dart';
import 'package:agrogo/features/maps_and_lots/presentation/pantalla_mapa_global.dart';
import 'package:agrogo/features/inventory_management/presentation/pantalla_bodega.dart';
import 'package:agrogo/features/field_workers/presentation/pantalla_nomina_semanal.dart';
import 'package:agrogo/features/inventory_management/presentation/pantalla_proceso_cafe.dart';
import 'package:agrogo/features/auth/presentation/screens/pantalla_login.dart';
import 'package:agrogo/features/auth/presentation/providers/auth_provider.dart';

part 'enrutador_app.g.dart';

@riverpod
GoRouter enrutador(EnrutadorRef ref) {
  final authState = ref.watch(alAutenticarProvider);
  final GlobalKey<NavigatorState> navigatorRaizKey = GlobalKey<NavigatorState>(debugLabel: 'raiz');

  return GoRouter(
    navigatorKey: navigatorRaizKey,
    initialLocation: '/login',
    redirect: (context, state) {
      final logueado = authState.valueOrNull != null;
      final enLogin = state.matchedLocation == '/login';

      if (!logueado && !enLogin) return '/login';
      if (logueado && enLogin) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const PantallaLogin(),
      ),
      // Selección de Finca (Root)
      GoRoute(
        path: '/',
        builder: (context, state) => const PantallaMisFincas(),
      ),

      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const PantallaOnboarding(),
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
        parentNavigatorKey: navigatorRaizKey,
        builder: (context, state) => const PantallaListaTrabajadores(),
      ),
      GoRoute(
        path: '/nomina-semanal',
        parentNavigatorKey: navigatorRaizKey,
        builder: (context, state) => const PantallaNominaSemanal(),
      ),
      GoRoute(
        path: '/gastos',
        parentNavigatorKey: navigatorRaizKey,
        builder: (context, state) {
          final action = state.uri.queryParameters['action'];
          return PantallaPanelCostos(
            abrirCalculadora: action == 'calc',
            abrirFormulario: action == 'add',
          );
        },
      ),
      GoRoute(
        path: '/mapa-finca',
        parentNavigatorKey: navigatorRaizKey,
        builder: (context, state) => const PantallaMapaFinca(),
      ),
      GoRoute(
        path: '/mapa-global',
        parentNavigatorKey: navigatorRaizKey,
        builder: (context, state) => const PantallaMapaGlobal(),
      ),
      GoRoute(
        path: '/bodega',
        parentNavigatorKey: navigatorRaizKey,
        builder: (context, state) => const PantallaBodega(),
      ),
      GoRoute(
        path: '/proceso-cafe',
        parentNavigatorKey: navigatorRaizKey,
        builder: (context, state) => const PantallaProcesoCafe(),
      ),
    ],
  );
}
