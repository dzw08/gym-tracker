import 'package:flutter/material.dart';
import 'package:gym_tracker/widgets/template_card.dart';

class WorkoutsScreen extends StatelessWidget {
  const new({super.key});

  final int itemCount = 10;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: ListTile(
            title: Text(
              'My templates',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        SliverList.builder(
          itemBuilder: (BuildContext context, int index) {
            return Center();
          },
        ),
        SliverToBoxAdapter(
          child: ListTile(
            title: Text(
              'Example templates',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        SliverList.builder(
          // Test information so far, placeholder cards
          itemCount: (itemCount / 2).ceil(),
          itemBuilder: (BuildContext context, int rowIndex) {
            final firstIndex = rowIndex * 2;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
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
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
