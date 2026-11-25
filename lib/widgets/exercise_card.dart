import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_tracker/models/exercise.dart';
import 'package:gym_tracker/theme/app_theme.dart';
import 'package:gym_tracker/widgets/exercise_dialog.dart';

class ExerciseCard extends StatelessWidget {
  const new({
    super.key,
    required this.icon,
    required this.exercise,
    required this.isNameTaken,
    required this.onSaveEdit,
  });

  final Icon icon;
  final Exercise exercise;
  // Checks if an exercise already exists with that name
  final bool Function(String name) isNameTaken;
  // When the user clicks 'save'
  final Future<void> Function(ExerciseDialogResult result) onSaveEdit;

  void onDelete() {
    stdout.writeln("todo");
  }

  Future<ExerciseDialogResult?> onEdit(BuildContext context) async {
    final result = await showDialog<ExerciseDialogResult>(
      context: context,
      builder: (_) =>
          ExerciseDialog(initialExercise: exercise, isNameTaken: isNameTaken),
    );

    if (result == null) return null;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    String name = exercise.name;
    String description = exercise.description;
    return Card(
      elevation: 1,
      color: Theme.of(context).colorScheme.surfaceContainer,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Palette.bgDark),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_horiz),
                  tooltip: "Exercise options",
                  onSelected: (action) async {
                    if (action == 'delete') onDelete();
                    if (action == 'edit') {
                      final result = await onEdit(context);
                      if (result == null) return; // Cancelled
                      await onSaveEdit(result);
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'delete',
                      child: Text("Delete exercise"),
                    ),
                    PopupMenuItem(value: 'edit', child: Text("Edit exercise")),
                  ],
                ),
              ],
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}
