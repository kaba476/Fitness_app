import 'package:flutter/foundation.dart';

import 'data/sample_data.dart';
import 'models/exercise.dart';
import 'models/planned_slot.dart';
import 'models/workout_session.dart';

class FitnessAppState extends ChangeNotifier {
  FitnessAppState() {
    _session = SampleData.todaySession();
    _refreshWeek();
  }

  late WorkoutSession _session;
  late List<PlannedSlot> _weekSlots;

  int weeklyCalories = 420;
  int weeklyMinutes = 38;
  int streakDays = 5;
  String volumeTonnes = '2.4';

  bool pushNotifications = true;
  bool reminderMorning = true;
  String weightUnit = 'kg';

  WorkoutSession get todaySession => _session;
  List<PlannedSlot> get weekSlots => _weekSlots;

  void _refreshWeek() {
    _weekSlots = SampleData.weekPlanFrom(DateTime.now());
  }

  void toggleExerciseDone(String exerciseId) {
    final list = _session.exercises;
    for (final e in list) {
      if (e.id == exerciseId) {
        e.done = !e.done;
        break;
      }
    }
    _bumpStatsFromProgress();
    notifyListeners();
  }

  void _bumpStatsFromProgress() {
    final p = _session.progress;
    weeklyCalories = 320 + (p * 400).round();
    weeklyMinutes = 24 + (p * 40).round();
  }

  void toggleSlotDone(int index) {
    if (index < 0 || index >= _weekSlots.length) return;
    _weekSlots[index].done = !_weekSlots[index].done;
    notifyListeners();
  }

  void setPushNotifications(bool v) {
    pushNotifications = v;
    notifyListeners();
  }

  void setReminderMorning(bool v) {
    reminderMorning = v;
    notifyListeners();
  }

  void cycleWeightUnit() {
    weightUnit = weightUnit == 'kg' ? 'lb' : 'kg';
    notifyListeners();
  }

  void resetTodaySessionDemo() {
    _session = SampleData.todaySession();
    _refreshWeek();
    weeklyCalories = 420;
    weeklyMinutes = 38;
    notifyListeners();
  }

  List<Exercise> get upcomingExercises =>
      _session.exercises.where((e) => !e.done).toList();
}
