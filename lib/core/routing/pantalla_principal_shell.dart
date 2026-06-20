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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 1, color: Colors.grey.shade300),
          NavigationBar(
            height: 80,
            elevation: 0,
            backgroundColor: Colors.white,
            indicatorColor: const Color(0xFFE8F5E9),
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
                selectedIcon: Icon(Icons.home, size: 30, color: Color(0xFF1B5E20)),
                label: 'Inicio',
              ),
              NavigationDestination(
                icon: Icon(Icons.landscape_outlined, size: 28),
                selectedIcon: Icon(Icons.landscape, size: 30, color: Color(0xFF1B5E20)),
                label: 'Mis Lotes',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined, size: 28),
                selectedIcon: Icon(Icons.calendar_month, size: 30, color: Color(0xFF1B5E20)),
                label: 'Agenda',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
