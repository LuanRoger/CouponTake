import 'package:coupon_take/l10n/l10n.dart';
import 'package:coupon_take/models/enums/localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocalePreferencesState extends StateNotifier<Locale?> {
  LocalePreferencesState({Locale? locale}) : super(locale);

  Localization? getCurrentCurrentLocalization() {
    if (state == null) return null;

    int localeIndex = L10n.locales.indexOf(state!);
    return L10n.getLocalizationByCode(localeIndex);
  }

  void changeLocalization(Localization localization) {
    state = L10n.locales[localization.code];
  }
}
