import 'package:gym_tracker/models/workout_set.dart';

class Exercise {
  Exercise({
    required this.name,
    required this.exerciseId,
    this.description = '',
  });

  final String name;
  final int exerciseId;
  final String description;
}

class WorkoutExercise {
  WorkoutExercise({required this.exercise});

  final Exercise exercise;
  final List<WorkoutSet> sets = [];

  void addSet(WorkoutSet set) => sets.add(set);
  void removeSet(WorkoutSet? set) {
    if (sets.isNotEmpty || set != null) {
      sets.contains(set) ? sets.remove(set) : null;
    } else {
      return;
    }
  }
}
