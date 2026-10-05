import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_tracker/screens/home_screen.dart';
import 'package:gym_tracker/screens/login_screen.dart';
import 'package:gym_tracker/widgets/password_field.dart';
import 'package:gym_tracker/widgets/username_field.dart';

void main() {
  Finder usernameInput() => find.widgetWithText(TextFormField, 'Username');
  Finder passwordInput() => find.widgetWithText(TextFormField, 'Password');
  Finder logInButton() => find.widgetWithText(FilledButton, 'Log in');

  // The placeholder auth in LoginScreen accepts any username plus this password.
  const placeholderPassword = 'password';

  Future<void> enterPlaceholderCredentials(WidgetTester tester) async {
    await tester.enterText(usernameInput(), 'dani');
    await tester.enterText(passwordInput(), placeholderPassword);
  }

  testWidgets('login screen shows a username and a password field', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    expect(find.byType(UsernameField), findsOneWidget);
    expect(find.byType(PasswordField), findsOneWidget);
    expect(logInButton(), findsOneWidget);
  });

  testWidgets('typing updates the screen-owned controller', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    await tester.enterText(usernameInput(), 'dani');
    await tester.enterText(passwordInput(), 'hunter2');

    expect(
      tester.widget<TextFormField>(usernameInput()).controller?.text,
      'dani',
    );
    expect(
      tester.widget<TextFormField>(passwordInput()).controller?.text,
      'hunter2',
    );
  });

  testWidgets('pressing the log in button opens the home screen', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    await enterPlaceholderCredentials(tester);
    await tester.tap(logInButton());
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    // pushReplacement, so there is nothing to go back to.
    expect(find.byType(LoginScreen), findsNothing);
  });

  testWidgets('confirming the password field also submits the form', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    await enterPlaceholderCredentials(tester);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('the login title is centred in the app bar', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    final screenCentre = tester.getSize(find.byType(Scaffold)).width / 2;
    final titleCentre = tester.getCenter(find.text('Login')).dx;

    expect(titleCentre, closeTo(screenCentre, 0.5));
  });

  testWidgets('an incorrect password shows a message on screen', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    expect(find.text('Credentials incorrect!'), findsNothing);

    await tester.enterText(usernameInput(), 'dani');
    await tester.enterText(passwordInput(), 'wrong');
    await tester.tap(logInButton());
    await tester.pump();

    expect(find.text('Credentials incorrect!'), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
  });
}
