import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isObscureText;
  const AuthField({
    super.key,
    required this.hint,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        decoration: InputDecoration(
          hintText: hint,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "$hint is required!";
          }
          return null;
        },
      ),
    );
  }
}
