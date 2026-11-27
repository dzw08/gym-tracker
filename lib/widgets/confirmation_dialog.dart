import 'package:flutter/material.dart';
import 'package:gym_tracker/models/exercise.dart';

typedef ConfirmationDialogResult = ({bool confirmed, Exercise exercise});

class ConfirmationDialog extends StatefulWidget {
  const new({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  void _close(bool confirmed) {
    Navigator.of(context).pop<ConfirmationDialogResult>((
      confirmed: confirmed,
      exercise: widget.exercise,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete"),
      scrollable: false,
      content: Text("Delete this exercise?"),
      actions: [
        TextButton(onPressed: () => _close(false), child: Text("Cancel")),
        FilledButton.icon(
          onPressed: () => _close(true),
          icon: const Icon(Icons.delete),
          label: const Text("Delete"),
        ),
      ],
    );
  }
}
