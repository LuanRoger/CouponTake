import 'package:cupon_take/pages/home_page/home_page.dart';
import 'package:cupon_take/shared/app_theme_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: const HomePage(), theme: AppThemeData.appDarkTheme),
  );
}
