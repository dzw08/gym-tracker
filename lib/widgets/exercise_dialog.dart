import 'package:flutter/material.dart';
import 'package:gym_tracker/models/exercise.dart';

typedef ExerciseDialogResult = ({
  String name,
  String description,
  String iconKey,
});

class ExerciseDialog extends StatefulWidget {
  const new({super.key, this.initialExercise, required this.isNameTaken});

  final Exercise? initialExercise;
  final bool Function(String name) isNameTaken;

  @override
  State<ExerciseDialog> createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _iconKey;
  String _name = '';
  String _description = '';

  @override
  void initState() {
    super.initState();
    _iconKey = widget.initialExercise?.iconKey ?? 'strength';
  }

  void _submit() {
    final form = _formKey.currentState!;
    if (!form.validate()) return;
    form.save();

    Navigator.of(context).pop<ExerciseDialogResult>((
      name: _name,
      description: _description,
      iconKey: _iconKey,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.initialExercise == null
          ? Text("Create exercise")
          : Text("Edit exercise"),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Input forms for the new exercise.
          children: [
            // Dropdown menu to select a custom icon for the exercise.
            Padding(
              padding: EdgeInsets.only(bottom: 16, top: 8),
              child: DropdownMenu<String>(
                expandedInsets: EdgeInsets.zero,
                initialSelection: _iconKey,
                enableSearch: true,
                label: Text("Icon"),
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    value: "strength",
                    label: "Strength",
                    leadingIcon: Icon(Icons.fitness_center),
                  ),
                  DropdownMenuEntry(
                    value: "bodyweight",
                    label: "Bodyweight",
                    leadingIcon: Icon(Icons.accessibility),
                  ),
                  DropdownMenuEntry(
                    value: "dynamic",
                    label: "Dynamic",
                    leadingIcon: Icon(Icons.sports_gymnastics),
                  ),
                  DropdownMenuEntry(
                    value: "running",
                    label: "Running",
                    leadingIcon: Icon(Icons.directions_run),
                  ),
                  DropdownMenuEntry(
                    value: "cycling",
                    label: "Cycling",
                    leadingIcon: Icon(Icons.directions_bike),
                  ),
                  DropdownMenuEntry(
                    value: "stretching",
                    label: "Stretching",
                    leadingIcon: Icon(Icons.self_improvement),
                  ),
                ],
                onSelected: (value) {
                  if (value != null) _iconKey = value;
                },
              ),
            ),
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Exercise name *",
                hintText: "e.g. Bench Press",
              ),
              initialValue: widget.initialExercise?.name ?? '',
              onSaved: (value) => _name = value?.trim() ?? '',
              validator: (value) {
                final trimmed = value?.trim() ?? '';
                if (trimmed.isEmpty) {
                  return "Enter an exercise name.";
                }

                final exists = widget.isNameTaken(trimmed);
                return exists ? "This exercise already exists." : null;
              },
            ),
            TextFormField(
              autofocus: false,
              decoration: InputDecoration(labelText: "Description"),
              onSaved: (value) => _description = value?.trim() ?? '',
              initialValue: widget.initialExercise?.description ?? '',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancel"),
        ),
        FilledButton(
          onPressed: _submit,
          child: widget.initialExercise == null ? Text("Create") : Text("Save"),
        ),
      ],
    );
  }
}
