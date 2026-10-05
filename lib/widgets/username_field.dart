import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({super.key, required this.controller, this.onSubmitted});

  final TextEditingController controller;

  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: onSubmitted,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: 'Username',
        hintText: 'Enter username',
        border: OutlineInputBorder(),
      ),
    );
  }
}
