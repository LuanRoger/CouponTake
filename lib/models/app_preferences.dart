import 'package:coupon_take/models/theme_preferences.dart';

class AppPreferences {
  String? coupontakeAuthKey;
  ThemePreferences themePreferences;

  AppPreferences(
      {required this.coupontakeAuthKey, required this.themePreferences});
}
