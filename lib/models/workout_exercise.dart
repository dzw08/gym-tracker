class WorkoutExercise {
  WorkoutExercise({required this.name, required this.exerciseId});

  final int exerciseId;
  final String name;
  List<Set> sets = List.empty(growable: true);

  void setEntry() {}
  void setDelete() {}
}
