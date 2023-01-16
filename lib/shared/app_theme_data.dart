import 'package:cupon_take/models/enums/app_brightness.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static final List<Color> _appColors = [
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.amber
  ];
  static List<Color> get appColors => List<Color>.from(_appColors);

  static ThemeData getAppTheme(AppBrightness brightness, int colorIndex) {
    return ThemeData(
        useMaterial3: true,
        brightness: brightness == AppBrightness.LIGHT
            ? Brightness.light
            : Brightness.dark,
        colorSchemeSeed: _appColors[colorIndex]);
  }
}
