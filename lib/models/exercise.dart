import 'package:gym_tracker/models/workout_set.dart';

class Exercise {
  Exercise({
    required this.name,
    required this.exerciseId,
    this.description = '',
    DateTime? createdAt,
    this.iconKey = 'strength',
  }) : createdAt = createdAt ?? DateTime.now();

  String name;
  final int exerciseId;
  String description;
  final DateTime createdAt;
  final String iconKey;
  final List<WorkoutSet> history = [];
  WorkoutSet best = WorkoutSet(reps: 0, weight: 0, rpe: 0);

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    exerciseId: (json['id'] as num).toInt(),
    name: json['name'] as String,
    description: json['description'] as String? ?? '',
    createdAt: DateTime.parse(json['createdAt'] as String),
    iconKey: json['icon'] as String? ?? 'strength',
  );

  Map<String, dynamic> toJson() => {
    'id': exerciseId,
    'name': name,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
    'icon': iconKey,
  };

  void addHistory(WorkoutSet set) {
    history.add(set);
    if (set.max > best.max) {
      best = set;
    }
  }
}

class WorkoutExercise {
  WorkoutExercise({required this.exercise});

  final Exercise exercise;
  final List<WorkoutSet> sets = [];

  void addSet(WorkoutSet set) {
    sets.add(set);
    exercise.addHistory(set);
  }

  void removeSet(WorkoutSet? set) {
    if (sets.isNotEmpty || set != null) {
      sets.contains(set) ? sets.remove(set) : null;
    } else {
      return;
    }
  }
}
