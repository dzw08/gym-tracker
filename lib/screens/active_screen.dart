import 'dart:async';

import 'package:flutter/material.dart';

class ActiveScreen extends StatefulWidget {
  const new({super.key, required this.startTime});

  final DateTime startTime;
  @override
  State<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Workout'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "$hours:$minutes:$seconds",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontVariations: [FontVariation('wght', 900)],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Placeholder(),
    );
  }
}
