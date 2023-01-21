import 'package:coupon_take/models/enums/localization.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class L10n {
  //This list must to be at the same orde that the code from [Localization]
  static const List<Locale> locales = [Locale("pt", "BR"), Locale("en", "GB")];

  static Localization? getLocalizationByCode(int code) {
    return Localization.values
        .firstWhereOrNull((element) => element.code == code);
  }
}
