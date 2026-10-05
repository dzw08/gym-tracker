import 'package:flutter/material.dart';
import 'package:gym_tracker/widgets/username_field.dart';
import 'package:gym_tracker/widgets/password_field.dart';
import 'package:gym_tracker/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
export 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';

  @override
  void dispose() {
    _usernameController
      ..removeListener(_clearError)
      ..dispose();
    _passwordController
      ..removeListener(_clearError)
      ..dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_clearError);
    _passwordController.addListener(_clearError);
  }

  void _clearError() {
    if (errorMessage.isEmpty) return;
    setState(() => errorMessage = '');
  }

  Future<void> _submitLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final supabase = Supabase.instance.client;

    try {
      final row = await supabase
          .from('users')
          .select('id, username')
          .eq('username', username)
          .eq('password', password)
          .maybeSingle();

      if (row != null) {
        // Login succeed.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen(),
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid credentials.')));
        setState(() => errorMessage = 'Invalid credentials!');
      }
    } on PostgrestException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
        setState(() => errorMessage = e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        centerTitle: true,
        title: Text('Login', style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    right: 20,
                    left: 20,
                  ),
                  child: UsernameField(controller: _usernameController),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 25,
                    right: 20,
                    left: 20,
                  ),
                  child: PasswordField(
                    controller: _passwordController,
                    onSubmitted: (_) => _submitLogin(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 20,
                  ),
                  child: Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: FilledButton(
                    onPressed: _submitLogin,
                    child: Text('Log in'),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
