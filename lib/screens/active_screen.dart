import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_tracker/models/workout.dart';
import 'package:gym_tracker/repositories/exercise_repository.dart';
import 'package:gym_tracker/widgets/confirmation_dialog.dart';

class ActiveScreen extends StatefulWidget {
  const new({
    super.key,
    required this.startTime,
    required this.username,
    this.template,
  });

  final String username;
  final DateTime startTime;
  final WorkoutTemplate? template;

  @override
  State<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  late final Workout _workout;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();

    _workout = Workout(name: "New Workout", date: widget.startTime);

    final exerciseRepository = LocalExerciseRepository(
      username: widget.username,
    );
    exerciseRepository.fetchAll();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  Future<void> confirmClose() async {
    if (!mounted) return;

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => StandardDialog(
        prompt: "Are you sure you want to close?",
        confirm: "Close",
      ),
    );
    if (!mounted || result == null || !result) return;

    if (result) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = DateTime.now().difference(widget.startTime);
    final hours = elapsed.inHours.toString().padLeft(2, '0');
    final minutes = (elapsed.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (elapsed.inSeconds % 60).toString().padLeft(2, '0');
    final elapsedLabel = elapsed.inHours > 0
        ? "$hours:$minutes:$seconds"
        : "$minutes:$seconds";
    final dateLabel = MaterialLocalizations.of(context)
        .formatMediumDate(_workout.date.toLocal());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: TextFormField(
          initialValue: _workout.name,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Container(
            height: 64,
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.today),
                      const SizedBox(width: 8),
                      Text(
                        dateLabel,
                        style: TextStyle(fontFamily: "SpaceMono"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      const SizedBox(width: 8),
                      Text(
                        elapsedLabel,
                        style: TextStyle(fontFamily: "SpaceMono"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: confirmClose,
              style: ButtonStyle(
                backgroundColor: WidgetStateColor.fromMap({
                  WidgetState.any: Theme.of(context).colorScheme.tertiary,
                }),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          _workout.exercises.isEmpty
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No exercises yet."),
                      const SizedBox(height: 8),
                      IconButton(
                        icon: Icon(Icons.add),
                        tooltip: "Add exercise",
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              : Placeholder(),
        ],
      ),
    );
  }
}
