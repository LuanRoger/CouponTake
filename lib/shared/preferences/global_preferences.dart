import 'package:coupon_take/models/app_preferences.dart';
import 'package:coupon_take/models/theme_preferences.dart';
import 'package:coupon_take/shared/preferences/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalPreferences extends ChangeNotifier {
  late SharedPreferences _preferencesHolder;
  bool initializated = false;

  late AppPreferences preferences;

  Future init() async {
    _preferencesHolder = await SharedPreferences.getInstance();

    String? lastAuthKey = _preferencesHolder.getString(PreferencesKeys.authKey);
    int? brightnessPreference =
        _preferencesHolder.getInt(PreferencesKeys.brightnessTheme);
    int? colorThemePreference =
        _preferencesHolder.getInt(PreferencesKeys.themeColor);

    preferences = AppPreferences(
        coupontakeAuthKey: lastAuthKey,
        themePreferences: ThemePreferences(
            brightness: brightnessPreference ?? 0,
            colorIndex: colorThemePreference ?? 0));

    initializated = true;
    notifyListeners();
  }

  String? get coupontakeAuthKey => preferences.coupontakeAuthKey;
  set coupontakeAuthKey(String? authKey) {
    preferences.coupontakeAuthKey = authKey;
    _preferencesHolder.setString(PreferencesKeys.authKey, authKey ?? "");
    notifyListeners();
  }

  int? get brightness => preferences.themePreferences.brightness;
  set brightness(int? brightness) {
    int brightnessAsserted = brightness ?? 0;

    preferences.themePreferences =
        preferences.themePreferences.copyWith(brightness: brightnessAsserted);
    _preferencesHolder.setInt(
        PreferencesKeys.brightnessTheme, brightnessAsserted);
    notifyListeners();
  }

  int? get colorIndex => preferences.themePreferences.colorIndex;
  set colorIndex(int? colorIndex) {
    int colorIndexAsserted = colorIndex ?? 0;

    preferences.themePreferences =
        preferences.themePreferences.copyWith(colorIndex: colorIndexAsserted);
    _preferencesHolder.setInt(PreferencesKeys.themeColor, colorIndexAsserted);
    notifyListeners();
  }

  Future clear() async {
    _preferencesHolder.clear();
    await init();
  }
}
