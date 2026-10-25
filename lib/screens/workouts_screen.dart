import 'package:flutter/material.dart';
import 'package:gym_tracker/widgets/template_card.dart';

class WorkoutsScreen extends StatelessWidget {
  const new({super.key});

  final int itemCount = 4;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      'Templates',
                      style: TextStyle(
                        fontSize: 34,
                        fontFamily: 'PlusJakartaSans',
                        fontVariations: [FontVariation('wght', 700)],
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: FilledButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStateColor.fromMap({
                        WidgetState.any: Theme.of(context)
                            .colorScheme
                            .secondary,
                      }),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        Text(
                          "Template",
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
          ),
        ),
        SliverToBoxAdapter(
          child: ListTile(
            title: Text(
              itemCount > 0 ? 'My templates ($itemCount)' : 'My templates',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        SliverList.builder(
          // Test information so far, placeholder cards
          itemCount: (itemCount / 2).ceil(),
          itemBuilder: (BuildContext context, int rowIndex) {
            final firstIndex = rowIndex * 2;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TemplateCard(
                      title: 'Push ${firstIndex + 1}',
                      exercises: ["1", "2", "3"],
                      lastDone: "Never",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: firstIndex + 1 < itemCount
                        ? TemplateCard(
                            title: 'Push ${firstIndex + 2}',
                            exercises: ["1", "2", "3"],
                            lastDone: "Never",
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: ListTile(
            title: Text(
              "Example templates",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        SliverList.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int itemCount) => Placeholder(),
        ),
      ],
    );
  }
}
