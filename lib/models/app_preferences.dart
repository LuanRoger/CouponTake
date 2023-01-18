import 'package:cupon_take/models/theme_preferences.dart';

class AppPreferences {
  String? cupontakeAuthKey;
  ThemePreferences themePreferences;

  AppPreferences(
      {required this.cupontakeAuthKey, required this.themePreferences});
}
