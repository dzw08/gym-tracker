import 'dart:convert';

import 'package:gym_tracker/models/exercise.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> fetchAll();
  Future<Exercise> create({
    required String name,
    required String description,
    required String iconKey,
  });
}

// Repository for local storage, will implement a Supabase version later
class LocalExerciseRepository implements ExerciseRepository {
  LocalExerciseRepository({required this.username, SharedPreferences? prefs})
    : _injectedPrefs = prefs;
  final String username;
  final SharedPreferences? _injectedPrefs;
  String get _key => 'exercises:$username';

  Future<SharedPreferences> _prefs() async {
    return _injectedPrefs ?? await SharedPreferences.getInstance();
  }

  @override
  Future<List<Exercise>> fetchAll() async {
    final prefs = await _prefs();
    final raw = prefs.getString(_key);

    // If the user has no saved data
    if (raw == null) return [];

    // Otherwise, decode the user's JSON
    final decoded = jsonDecode(raw);

    if (decoded is! Map<String, dynamic> ||
        decoded['version'] != 1 ||
        decoded['exercises'] is! List) {
      throw const FormatException("Unsupported exercise storage format.");
    }

    final rows = decoded['exercises'] as List;
    final exercises = rows.map((row) {
      if (row is! Map<String, dynamic>) {
        throw const FormatException("Invalid saved exercise.");
      }
      return Exercise.fromJson(row);
    }).toList();

    exercises.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return exercises;
  }

  @override
  Future<Exercise> create({
    required String name,
    required String description,
    required String iconKey,
  }) async {
    final exercises = await fetchAll();
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      throw ArgumentError("Enter an exercise name.");
    }

    final exists = exercises.any(
      (exercise) => exercise.name.toLowerCase() == trimmedName.toLowerCase(),
    );

    if (exists) {
      throw ArgumentError("This exercise already exists");
    }

    // Generating an ID to avoid collisions with exercises that already exist.
    final now = DateTime.now();
    var id = now.microsecondsSinceEpoch;

    while (exercises.any((exercise) => exercise.exerciseId == id)) {
      id++;
    }

    final exercise = Exercise(
      exerciseId: id,
      name: trimmedName,
      description: description.trim(),
      createdAt: now,
      iconKey: iconKey,
    );

    exercises.add(exercise);

    final json = jsonEncode({
      'version': 1,
      'exercises': exercises.map((item) => item.toJson()).toList(),
    });

    final prefs = await _prefs();
    final saved = await prefs.setString(_key, json);

    if (!saved) {
      throw StateError("Could not save the exercise.");
    }

    return exercise;
  }
}
