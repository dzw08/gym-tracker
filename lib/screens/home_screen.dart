import 'package:flutter/material.dart';

import 'workouts_screen.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;

  final _appBarPadding = const EdgeInsets.only(top: 15);

  static const _pageTitles = [
    'Account',
    'History',
    'Workouts',
    'Exercises',
    'Trends',
  ];

  final List<Widget> _pages = [
    Placeholder(), //eventually account page
    Placeholder(), //eventually the history page
    WorkoutsScreen(), //new workout (i.e. home screen)
    Placeholder(), //exercises
    Placeholder(), //trends/graphs
  ];

  void _startEmptyWorkout() {
    //TODO: navigate to the workout screen.
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: _appBarPadding,
          child: Text(
            _pageTitles[_selectedIndex],
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        actions: _selectedIndex == 2
            ? [
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 15),
                  child: IconButton(
                    icon: Icon(Icons.search_outlined),
                    onPressed: () => 0,
                  ),
                ),
              ]
            : null,
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      floatingActionButton: _selectedIndex == 2
          ? Padding(
              padding: const EdgeInsets.only(bottom: 6, right: 6),
              child: FloatingActionButton(
                onPressed: _startEmptyWorkout,
                tooltip: 'Start workout',
                elevation: 4,
                child: const Icon(Icons.add),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: NavigationBar(
        height: 90,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person),
            label: 'Account',
          ),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
          NavigationDestination(icon: Icon(Icons.add), label: 'New Workout'),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_rounded),
            label: 'Exercises',
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_down),
            selectedIcon: Icon(Icons.trending_up),
            label: 'Trends',
          ),
        ],
      ),
    );
  }
}
