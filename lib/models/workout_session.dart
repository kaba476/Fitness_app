import 'exercise.dart';

class WorkoutSession {
  WorkoutSession({
    required this.id,
    required this.title,
    required this.meta,
    required this.exercises,
    this.badgeLabel = "Aujourd'hui",
  });

  final String id;
  final String title;
  final String meta;
  final String badgeLabel;
  final List<Exercise> exercises;

  double get progress {
    if (exercises.isEmpty) return 0;
    return exercises.where((e) => e.done).length / exercises.length;
  }

  int get completedCount => exercises.where((e) => e.done).length;
}
