import 'package:cupon_take/models/app_preferences.dart';
import 'package:cupon_take/shared/preferences/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalPreferences extends ChangeNotifier {
  late SharedPreferences _preferencesHolder;
  bool initializated = false;

  late AppPreferences _preferences;

  Future init() async {
    _preferencesHolder = await SharedPreferences.getInstance();

    String? lastAuthKey = _preferencesHolder.getString(PreferencesKeys.authKey);

    _preferences = AppPreferences(cupontakeAuthKey: lastAuthKey);

    initializated = true;
    notifyListeners();
  }

  String? get cupontakeAuthKey => _preferences.cupontakeAuthKey;
  set cupontakeAuthKey(String? authKey) {
    _preferences.cupontakeAuthKey = authKey;
    notifyListeners();
  }
}
