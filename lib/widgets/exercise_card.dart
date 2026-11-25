import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ExerciseCard extends StatelessWidget {
  const new({
    super.key,
    required this.icon,
    required this.name,
    this.description,
  });

  final Icon icon;
  final String name;
  final String? description;

  void onDelete() {}
  void onEdit() {}

  @override
  Widget build(BuildContext context) {
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
                  onSelected: (action) {
                    if (action == 'delete') onDelete();
                    if (action == 'edit') onEdit();
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
            Text(description ?? ''),
          ],
        ),
      ),
    );
  }
}
