import 'package:flutter/material.dart';

class AppThemeData {
  static final appDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepPurple,
      primaryColorDark: Colors.purple,
    ),
  );
}
