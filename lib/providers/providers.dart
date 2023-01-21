import 'dart:ui';

import 'package:coupon_take/l10n/l10n.dart';
import 'package:coupon_take/models/coupon.dart';
import 'package:coupon_take/models/coupon_redeem.dart';
import 'package:coupon_take/models/enums/http_codes.dart';
import 'package:coupon_take/models/exceptions/empty_list_exception.dart';
import 'package:coupon_take/models/exceptions/http_not_succeed_exception.dart';
import 'package:coupon_take/models/exceptions/no_auth_key_exception.dart';
import 'package:coupon_take/models/http_response.dart';
import 'package:coupon_take/models/redeem_history_http_request.dart';
import 'package:coupon_take/models/theme_preferences.dart';
import 'package:coupon_take/models/user_info.dart';
import 'package:coupon_take/providers/interfaces/locale_preferences_state.dart';
import 'package:coupon_take/providers/interfaces/theme_preferences_state.dart';
import 'package:coupon_take/services/auth_service.dart';
import 'package:coupon_take/services/coupon_services.dart';
import 'package:coupon_take/shared/preferences/global_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'interfaces/user_auth_state.dart';

late final ChangeNotifierProvider<GlobalPreferences> preferencesProvider;

final userAuthProvider =
    StateNotifierProvider<UserAuthKeyState, String?>((ref) {
  final userAuthKeyPreference = ref.watch(preferencesProvider
      .select((value) => value.preferences.coupontakeAuthKey));

  return UserAuthKeyState(authKey: userAuthKeyPreference);
});

final themePreferencesProvider =
    StateNotifierProvider<ThemePreferencesState, ThemePreferences>((ref) {
  final preferences = ref.watch(preferencesProvider
      .select((value) => value.preferences.themePreferences));

  return ThemePreferencesState(
    ThemePreferences(
        brightness: preferences.brightness, colorIndex: preferences.colorIndex),
  );
});

final localePreferencesProvider =
    StateNotifierProvider<LocalePreferencesState, Locale?>((ref) {
  final localeIndexPreference = ref.watch(
      preferencesProvider.select((value) => value.preferences.localeIndex));

  return LocalePreferencesState(locale: L10n.locales[localeIndexPreference]);
});

final fetchUserInfoProvider = FutureProvider<UserInfo>((ref) async {
  final userAuthKey = ref.watch(userAuthProvider);

  if (userAuthKey == null || userAuthKey.isEmpty) {
    throw NoAuthException();
  }

  AuthServices authServices = AuthServices();
  HttpResponse response = await authServices.getUserInfo(userAuthKey);
  if (response.statusCode != HttpCodes.SUCCESS.code) {
    throw HttpNotSucceedException("getUserInfo", code: response.statusCode);
  }

  return UserInfo(response.body["username"] as String,
      points: response.body["points"] as int);
});

final fetchUserRedeemHistoryProvider =
    FutureProvider.family<List<CouponRedeem>, RedeemHistoryHttpRequest>(
        (ref, requestInfo) async {
  final userAuthKey = ref.watch(userAuthProvider);

  if (userAuthKey == null || userAuthKey.isEmpty) {
    throw NoAuthException();
  }

  CouponServices couponServices = CouponServices();
  final response =
      await couponServices.getRedeemHistory(userAuthKey, requestInfo);
  if (response.statusCode != HttpCodes.SUCCESS.code) {
    throw HttpNotSucceedException("getRedeemHistory",
        code: response.statusCode);
  }

  List<CouponRedeem> history = List.empty(growable: true);
  for (var coupon in response.body as List<dynamic>) {
    history.add(
      CouponRedeem(
        redeemProtocol: coupon["redeemProtocol"],
        coupon: Coupon(
          couponCode: coupon["redeemCoupon"]["couponCode"],
          createdAt: DateTime.parse(coupon["redeemCoupon"]["createdAt"]),
        ),
      ),
    );
  }
  if (history.isEmpty) throw EmptyListExceeption();

  return history;
});
