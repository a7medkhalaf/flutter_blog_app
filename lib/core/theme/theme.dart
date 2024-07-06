import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/theme/app_palette.dart';

class AppTheme {
  static InputBorder _inputBorder([
    Color color = AppPalette.borderColor,
  ]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      );

  static final dartThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(
        AppPalette.backgroundColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(32.0),
      enabledBorder: _inputBorder(),
      border: _inputBorder(),
      focusedBorder: _inputBorder(AppPalette.gradient2),
      errorBorder: _inputBorder(AppPalette.errorColor),
    ),
  );
}
