import 'package:flutter/material.dart';
import 'package:gym_tracker/models/exercise.dart';
import 'package:gym_tracker/repositories/exercise_repository.dart';
import 'package:gym_tracker/widgets/exercise_card.dart';

class ExercisesScreen extends StatefulWidget {
  const new({super.key, required this.username, this.repository});

  final String username;
  final ExerciseRepository? repository;

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  final List<Exercise> _exercises = [];
  late final ExerciseRepository _repository;
  bool _isLoading = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _repository =
        widget.repository ?? LocalExerciseRepository(username: widget.username);
    _loadExercises();
  }

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
    }
  }

  Future<void> createExercise() async {
    final formKey = GlobalKey<FormState>();
    var name = '';
    var description = '';

    final result = await showDialog<List<String>>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Create exercise"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "Exercise name *",
                  hintText: "e.g. Bench Press",
                ),
                onChanged: (value) => name = value.trim(),
                validator: (value) {
                  final trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return "Enter an exercise name.";
                  }

                  final exists = _exercises.any(
                    (exercise) =>
                        exercise.name.toLowerCase() == trimmed.toLowerCase(),
                  );

                  return exists ? "This exercise already exists." : null;
                },
              ),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(labelText: "Description"),
                onChanged: (value) => description = value.trim(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: _isLoading
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(dialogContext, [name, description]);
                    }
                  },
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text("Create"),
          ),
        ],
      ),
    );

    if (!mounted || result == null) return;

    final exerciseName = result[0];
    final exerciseDescription = result[1];

    setState(() async {
      try {
        final exercise = await _repository.create(
          name: exerciseName,
          description: exerciseDescription,
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
    });
  }

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
              icon: const Icon(Icons.fitness_center),
              name: exercise.name,
              description: exercise.description,
            ),
          ),
        ],
      ),
    );
  }
}
