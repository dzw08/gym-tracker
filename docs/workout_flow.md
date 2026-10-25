### PROCESS

1. Start workout -> create a `Workout` marked as in progress
2. Add exercise -> attaches a `WorkoutExercise` to the workout
3. Enter a set -> add its weight reps and optional RPE to that `WorkoutExercise` through `WorkoutExercise.setEntry(params)`
4. Complete workout -> validate it, record completion time and save through repo.

### Notes

- `Exercise` and `WorkoutExercise` are different: `Exercise` refers to the Exercises that can be found within the exercise page, and are used in the trends page, whereas `WorkoutExercise` are the workout-specific exercises that are created for entry into `Workout`s
- The `Exercise` ID is intended to maintain relationships between workout exercises and the actual exercises, so we can tell what exercise was actually performed, so that it is able to be tracked on the trends page.
