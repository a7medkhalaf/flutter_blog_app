import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/theme/app_palette.dart';

class AuthGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const AuthGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
        gradient: LinearGradient(
          colors: [
            AppPalette.gradient1,
            AppPalette.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(300, 50),
          backgroundColor: AppPalette.transparentColor,
          shadowColor: AppPalette.transparentColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
