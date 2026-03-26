import '../models/exercise.dart';
import '../models/planned_slot.dart';
import '../models/workout_session.dart';

abstract final class SampleData {
  static WorkoutSession todaySession() {
    return WorkoutSession(
      id: 'today-1',
      title: 'Force — Haut du corps',
      meta: '45 min · 12 exercices · intensité modérée',
      exercises: [
        Exercise(
          id: 'e1',
          name: 'Squats bulgares',
          setsDetail: '3 × 10',
          muscleGroup: 'Jambes',
        ),
        Exercise(
          id: 'e2',
          name: 'Développé haltères',
          setsDetail: '4 × 8',
          muscleGroup: 'Pectoraux',
        ),
        Exercise(
          id: 'e3',
          name: 'Planche dynamique',
          setsDetail: '3 × 45 s',
          muscleGroup: 'Core',
        ),
        Exercise(
          id: 'e4',
          name: 'Tirage horizontal',
          setsDetail: '3 × 12',
          muscleGroup: 'Dos',
        ),
      ],
    );
  }

  /// 7 jours à partir d’aujourd’hui (démo).
  static List<PlannedSlot> weekPlanFrom(DateTime anchor) {
    final start = DateTime(anchor.year, anchor.month, anchor.day);
    return [
      PlannedSlot(
        day: start,
        title: 'Force — Haut du corps',
        subtitle: '45 min · modéré',
      ),
      PlannedSlot(
        day: start.add(const Duration(days: 1)),
        title: 'Cardio léger',
        subtitle: '30 min · faible',
        done: true,
      ),
      PlannedSlot(
        day: start.add(const Duration(days: 2)),
        title: 'Jambes & gainage',
        subtitle: '50 min · intense',
      ),
      PlannedSlot(
        day: start.add(const Duration(days: 3)),
        title: 'Repos actif',
        subtitle: 'Marche 20 min',
      ),
      PlannedSlot(
        day: start.add(const Duration(days: 4)),
        title: 'Full body express',
        subtitle: '35 min · modéré',
      ),
      PlannedSlot(
        day: start.add(const Duration(days: 5)),
        title: 'Étirements & mobilité',
        subtitle: '25 min',
      ),
      PlannedSlot(
        day: start.add(const Duration(days: 6)),
        title: 'Course ou vélo',
        subtitle: '40 min · endurance',
      ),
    ];
  }
}
