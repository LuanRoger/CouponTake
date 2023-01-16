import 'package:cupon_take/models/enums/app_brightness.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static final _appLightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: Colors.green);
  static final _appDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.green,
  );

  static ThemeData getBrightness(AppBrightness brightness) {
    switch (brightness) {
      case AppBrightness.LIGHT:
        return _appLightTheme;
      case AppBrightness.DARK:
        return _appDarkTheme;
    }
  }
}
