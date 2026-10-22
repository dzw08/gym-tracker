import 'package:flutter/material.dart';
import 'package:gym_tracker/screens/login_screen.dart';

class AccountScreen extends StatefulWidget {
  const new({super.key, required this.username});

  final String username;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
      child: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 30),
                child: CircleAvatar(
                  radius: 45,
                  child: Icon(Icons.person, size: 45),
                ),
              ),
              Text(
                widget.username,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: FilledButton(
              onPressed: //TODO: make sure that Supabase logs out too.
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text("Log out"),
            ),
          ),
        ],
      ),
    );
  }
}
