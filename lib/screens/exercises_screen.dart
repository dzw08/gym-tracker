import 'package:flutter/material.dart';

class ExercisesScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: ListView(
        children: [
          Text(
            'Default',
            style: TextStyle(
              fontSize: 34,
              fontFamily: 'PlusJakartaSans',
              fontVariations: [FontVariation('wght', 700)],
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
