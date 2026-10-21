import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_tracker/screens/workouts_screen.dart';

void main() {
  testWidgets('WorkoutsScreen lays out without parent data errors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WorkoutsScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Templates'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
