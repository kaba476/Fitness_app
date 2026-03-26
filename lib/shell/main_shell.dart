import 'package:flutter/material.dart';

import '../app_state.dart';
import '../screens/home_dashboard.dart';
import '../screens/planning_screen.dart';
import '../screens/profile_screen.dart';
import '../widgets/ambient_background.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final FitnessAppState _state = FitnessAppState();
  int _index = 0;

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _state,
      builder: (context, _) {
        return Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              const AmbientBackground(),
              SafeArea(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 280),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: _index == 0
                      ? HomeDashboard(
                          key: const ValueKey('home'),
                          state: _state,
                        )
                      : _index == 1
                          ? PlanningScreen(
                              key: const ValueKey('plan'),
                              state: _state,
                            )
                          : ProfileScreen(
                              key: const ValueKey('profile'),
                              state: _state,
                            ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Accueil',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_today_outlined),
                selectedIcon: Icon(Icons.calendar_month_rounded),
                label: 'Planning',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Profil',
              ),
            ],
          ),
        );
      },
    );
  }
}
