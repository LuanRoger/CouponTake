import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_preferences.freezed.dart';

@freezed
class ThemePreferences with _$ThemePreferences {
  const factory ThemePreferences(
      {required int brightness, required int colorIndex}) = _ThemePreferences;
}
