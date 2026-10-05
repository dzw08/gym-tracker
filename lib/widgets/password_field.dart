import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  PasswordField({super.key, required this.controller, this.onSubmitted});

  final ValueNotifier<bool> _obscure = ValueNotifier(true);
  final TextEditingController controller;

  /// Note: Also includes keyboard done action.
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscure,
      builder: (context, obscured, _) {
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) => TextFormField(
            controller: controller,
            autocorrect: false,
            obscuringCharacter: '•',
            obscureText: _obscure.value,
            enableSuggestions: false,
            onFieldSubmitted: onSubmitted,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              hintText: 'Enter password',
              suffixIcon: value.text.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: Icon(
                          obscured ? Icons.visibility : Icons.visibility_off,
                        ),
                        tooltip: obscured ? 'Show password' : 'Hide password',
                        onPressed: () => _obscure.value = !_obscure.value,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.fromMap({
                            WidgetState.any: Colors.transparent,
                          }),
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
