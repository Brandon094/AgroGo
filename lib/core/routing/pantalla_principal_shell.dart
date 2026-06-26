import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PantallaPrincipalShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const PantallaPrincipalShell({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          height: 85,
          elevation: 0,
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFF00695C).withValues(alpha: 0.1),
          selectedIndex: navigationShell.currentIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (int index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, size: 28),
              selectedIcon: Icon(Icons.home_rounded, size: 30, color: Color(0xFF00695C)),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.landscape_outlined, size: 28),
              selectedIcon: Icon(Icons.landscape_rounded, size: 30, color: Color(0xFF00695C)),
              label: 'Mis Lotes',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined, size: 28),
              selectedIcon: Icon(Icons.calendar_month_rounded, size: 30, color: Color(0xFF00695C)),
              label: 'Agenda',
            ),
          ],
        ),
      ),
    );
  }
}
