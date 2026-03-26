import 'package:flutter/material.dart';

import '../app_state.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.state});

  final FitnessAppState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      children: [
        Text(
          'Profil',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Objectifs et préférences',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.55),
          ),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.mint, AppColors.coral],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor: theme.colorScheme.surface,
                    child: Icon(
                      Icons.person_rounded,
                      size: 36,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sportif',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Objectif : 3 séances / semaine',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Préférences',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Notifications push'),
                subtitle: Text(
                  'Rappels et résumés hebdo',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                value: state.pushNotifications,
                activeThumbColor: AppColors.mint,
                onChanged: state.setPushNotifications,
              ),
              Divider(
                height: 1,
                color: Colors.white.withValues(alpha: 0.06),
              ),
              SwitchListTile(
                title: const Text('Rappel matinal'),
                subtitle: Text(
                  'Vers 7 h 30',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                value: state.reminderMorning,
                activeThumbColor: AppColors.mint,
                onChanged: state.setReminderMorning,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: Icon(
              Icons.scale_rounded,
              color: theme.colorScheme.primary,
            ),
            title: const Text('Unité de poids'),
            subtitle: Text(
              state.weightUnit.toUpperCase(),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
            trailing: const Icon(Icons.swap_horiz_rounded),
            onTap: state.cycleWeightUnit,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Démo',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: Icon(
              Icons.restart_alt_rounded,
              color: AppColors.coral,
            ),
            title: const Text('Réinitialiser les données de démo'),
            subtitle: Text(
              'Séance du jour, planning et stats locales',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
            onTap: () {
              state.resetTodaySessionDemo();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Données de démo réinitialisées.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 28),
        Center(
          child: Text(
            'Fitness Tracker · v1.0.0',
            style: theme.textTheme.labelMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.35),
            ),
          ),
        ),
      ],
    );
  }
}
