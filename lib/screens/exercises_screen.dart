import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_tracker/models/exercise.dart';
import 'package:gym_tracker/repositories/exercise_repository.dart';
import 'package:gym_tracker/widgets/exercise_card.dart';
import 'package:gym_tracker/widgets/exercise_dialog.dart';

/*
**************************************
  SCREEN THAT DISPLAYS EXERCISES
**************************************
*/

class ExercisesScreen extends StatefulWidget {
  const new({super.key, required this.username, this.repository});

  final String username;
  final ExerciseRepository? repository;

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

// Manages the state of the exercise screen, i.e. allows dynamic content.
class _ExercisesScreenState extends State<ExercisesScreen> {
  final List<Exercise> _exercises = [];
  late final ExerciseRepository _repository;
  bool _isLoading = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    // Initialise the persistent storage from /lib/repositories.
    _repository =
        widget.repository ?? LocalExerciseRepository(username: widget.username);
    _loadExercises();
  }

  // Function to load existing locally-stored user exercises.
  Future<void> _loadExercises() async {
    try {
      final items = await _repository.fetchAll();
      if (!mounted) return;

      setState(() {
        _exercises
          ..clear()
          ..addAll(items);
        _isLoading = false;
        _loadError = null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loadError = error.toString();
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text("Error."),
          content: Text(
            "There was an error loading your exercises: $_loadError",
          ),
        ),
      );
    }
  }

  // Function to save edits to an existing exercise
  Future<void> _saveExerciseEdit(int id, ExerciseDialogResult result) async {
    stdout.writeln("todo");
  }

  // Function that adds a new user-created exercise to the loaded repo.
  Future<void> createExercise() async {
    if (_isLoading) return;

    final result = await showDialog<ExerciseDialogResult>(
      context: context,
      builder: (_) => ExerciseDialog(
        isNameTaken: (name) => _exercises.any(
          (exercise) => exercise.name.toLowerCase() == name.toLowerCase(),
        ),
      ),
    );

    if (!mounted || result == null) return;

    try {
      final exercise = await _repository.create(
        name: result.name,
        description: result.description,
        iconKey: result.iconKey,
      );
      if (!mounted) return;

      setState(() {
        _exercises.add(exercise);
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "An error occurred saving the exercise. Please try again.",
          ),
        ),
      );
    }
  }

  IconData _iconFor(String iconKey) => switch (iconKey) {
    'bodyweight' => Icons.accessibility,
    'dynamic' => Icons.sports_gymnastics,
    'running' => Icons.directions_run,
    'cycling' => Icons.directions_bike,
    'stretching' => Icons.self_improvement,
    _ => Icons.fitness_center,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Library',
                  style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'PlusJakartaSans',
                    fontVariations: [FontVariation('wght', 700)],
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: FilledButton(
                  onPressed: createExercise,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateColor.fromMap({
                      WidgetState.any: Theme.of(context).colorScheme.secondary,
                    }),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      Text(
                        "Exercise",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontVariations: [FontVariation("wght", 600)],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          if (_exercises.isEmpty)
            Center(
              child: Column(
                children: [
                  Text("No exercises yet."),
                  const SizedBox(height: 8),
                  IconButton(
                    icon: Icon(Icons.add),
                    tooltip: "Add exercise",
                    onPressed: createExercise,
                  ),
                ],
              ),
            ),
          ..._exercises.map(
            (exercise) => ExerciseCard(
              icon: Icon(_iconFor(exercise.iconKey)),
              exercise: exercise,
              isNameTaken: (name) => _exercises.any(
                (other) =>
                    other.exerciseId != exercise.exerciseId &&
                    other.name.toLowerCase() == name.toLowerCase(),
              ),
              onSaveEdit: (result) =>
                  _saveExerciseEdit(exercise.exerciseId, result),
            ),
          ),
        ],
      ),
    );
  }
}
