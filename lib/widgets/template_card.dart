import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({
    super.key,
    required this.title,
    required this.exercises,
    required this.lastDone,
    this.onTap,
  });

  final String title;
  final List<String> exercises;
  final String lastDone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      color: theme.colorScheme.surfaceContainer,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Palette.bgDark),
      ),
    );
  }
}
