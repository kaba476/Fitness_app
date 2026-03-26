import 'package:flutter/material.dart';

import '../app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_tile.dart';
import '../widgets/today_session_card.dart';
import 'workout_session_screen.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key, required this.state});

  final FitnessAppState state;

  void _openSession(BuildContext context) {
    Navigator.of(context)
        .push<bool>(
      MaterialPageRoute(
        builder: (_) => WorkoutSessionScreen(state: state),
      ),
    )
        .then((completed) {
      if (completed == true && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bravo — séance terminée !'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final session = state.todaySession;
    final upcoming = state.upcomingExercises;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bonjour',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Prêt à bouger ?',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.mint, AppColors.coral],
                  ),
                ),
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: theme.colorScheme.surface,
                  child: Icon(
                    Icons.fitness_center_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          TodaySessionCard(
            title: session.title,
            meta: session.meta,
            badgeLabel: session.badgeLabel,
            progress: session.progress,
            onOpen: () => _openSession(context),
          ),
          const SizedBox(height: 20),
          Text(
            'Aperçu',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: StatTile(
                  icon: Icons.local_fire_department_rounded,
                  iconColor: AppColors.coral,
                  label: 'Calories',
                  value: '${state.weeklyCalories}',
                  unit: 'kcal',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatTile(
                  icon: Icons.timer_rounded,
                  iconColor: AppColors.mint,
                  label: 'Durée',
                  value: '${state.weeklyMinutes}',
                  unit: 'min',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: StatTile(
                  icon: Icons.bolt_rounded,
                  iconColor: const Color(0xFFFBBF24),
                  label: 'Série',
                  value: '${state.streakDays}',
                  unit: 'jours',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatTile(
                  icon: Icons.trending_up_rounded,
                  iconColor: const Color(0xFF818CF8),
                  label: 'Volume',
                  value: state.volumeTonnes,
                  unit: 't',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            upcoming.isEmpty ? 'Tout est fait' : 'À venir',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          if (upcoming.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.emoji_events_rounded,
                      color: AppColors.mint,
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Tu as coché tous les exercices. Reviens demain ou réinitialise la démo depuis le profil.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.65),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...upcoming.map(
              (ex) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _UpcomingExerciseTile(
                  name: ex.name,
                  sets: ex.setsDetail,
                  muscle: ex.muscleGroup,
                  onTap: () => _openSession(context),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _UpcomingExerciseTile extends StatelessWidget {
  const _UpcomingExerciseTile({
    required this.name,
    required this.sets,
    required this.muscle,
    required this.onTap,
  });

  final String name;
  final String sets;
  final String muscle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.mint.withValues(alpha: 0.14),
          ),
          child: Icon(
            Icons.sports_gymnastics_rounded,
            color: theme.colorScheme.primary,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '$sets · $muscle',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.white.withValues(alpha: 0.35),
        ),
      ),
    );
  }
}
