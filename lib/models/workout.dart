import 'package:gym_tracker/models/exercise.dart';

class Workout {
  Workout({required this.name, required this.date});

  final String name;
  DateTime date;
  final List<WorkoutExercise> exercises = List.empty(growable: true);

  void addExercise(WorkoutExercise exercise) {
    exercises.add(exercise);
  }
}
