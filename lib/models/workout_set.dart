class WorkoutSet {
  WorkoutSet({required this.weight, required this.reps, this.rpe});

  double weight;
  int reps;
  double? rpe;
  double get max => weight * (1 + (reps / 30));
}
