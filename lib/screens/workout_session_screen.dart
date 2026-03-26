import 'package:flutter/material.dart';

import '../app_state.dart';
import '../theme/app_theme.dart';

class WorkoutSessionScreen extends StatelessWidget {
  const WorkoutSessionScreen({super.key, required this.state});

  final FitnessAppState state;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final session = state.todaySession;
        final theme = Theme.of(context);
        final done = session.progress >= 1;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Séance',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF121A22),
                      Color(0xFF0F1419),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, done ? 100 : 32),
                  children: [
                    Text(
                      session.title,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      session.meta,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: session.progress.clamp(0.0, 1.0),
                        minHeight: 10,
                        backgroundColor: Colors.white.withValues(alpha: 0.08),
                        color: AppColors.mint,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${session.completedCount} / ${session.exercises.length} exercices',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Exercices',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...session.exercises.map((ex) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          child: ListTile(
                            onTap: () => state.toggleExerciseDone(ex.id),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            leading: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: ex.done
                                    ? AppColors.mint.withValues(alpha: 0.25)
                                    : AppColors.mint.withValues(alpha: 0.12),
                              ),
                              child: Icon(
                                ex.done
                                    ? Icons.check_rounded
                                    : Icons.fitness_center_rounded,
                                color: ex.done
                                    ? AppColors.mint
                                    : theme.colorScheme.primary,
                              ),
                            ),
                            title: Text(
                              ex.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                decoration: ex.done
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: ex.done
                                    ? Colors.white.withValues(alpha: 0.45)
                                    : null,
                              ),
                            ),
                            subtitle: Text(
                              '${ex.setsDetail} · ${ex.muscleGroup}',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                            trailing: Icon(
                              ex.done
                                  ? Icons.undo_rounded
                                  : Icons.touch_app_rounded,
                              color: Colors.white.withValues(alpha: 0.35),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: done
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        backgroundColor: AppColors.coral,
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                      icon: const Icon(Icons.celebration_rounded),
                      label: const Text('Terminer la séance'),
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
