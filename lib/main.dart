import 'package:flutter/material.dart';

import '/theme/app_theme.dart';
import '/screens/login_screen.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://nynoruetxntaysxpwpxa.supabase.co',
    publishableKey: 'sb_publishable_5Tjc0MYT-TMakmmWMRxo7w_jlQuJKQG',
  );
  runApp(const MainWidget());
}

class MainWidget extends StatefulWidget {
  const new({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Tracker',
      theme: AppTheme.light,
      home: LoginScreen(),
      debugShowCheckedModeBanner: true,
    );
  }
}
