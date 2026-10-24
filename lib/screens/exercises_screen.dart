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
                  onPressed: () {},
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
        ],
      ),
    );
  }
}
