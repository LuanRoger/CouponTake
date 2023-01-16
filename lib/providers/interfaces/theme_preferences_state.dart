import 'package:cupon_take/models/enums/app_brightness.dart';
import 'package:cupon_take/models/theme_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemePreferencesState extends StateNotifier<ThemePreferences> {
  ThemePreferencesState(ThemePreferences? themePreferences)
      : super(themePreferences ??
            const ThemePreferences(brightness: 0, colorIndex: 0));

  void changeBrightness(AppBrightness brightness) {
    state = state.copyWith(brightness: brightness.index);
  }

  void changeColor(int colorIndex) {
    state = state.copyWith(colorIndex: colorIndex);
  }
}
