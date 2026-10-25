import 'package:gym_tracker/models/workout_exercise.dart';

class Workout {
  Workout({required this.name, required this.date});

  final String name;
  DateTime date;
  final List<WorkoutExercise> exercises = List.empty(growable: true);
}
