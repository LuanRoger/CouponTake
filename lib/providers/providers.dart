import 'dart:convert';

import 'package:cupon_take/models/cookies_authority.dart';
import 'package:cupon_take/models/http_response.dart';
import 'package:cupon_take/models/user_info.dart';
import 'package:cupon_take/models/user_info_http_response.dart';
import 'package:cupon_take/providers/interfaces/cookies_authority_state.dart';
import 'package:cupon_take/providers/interfaces/user_info_state.dart';
import 'package:cupon_take/services/auth_service.dart';
import 'package:cupon_take/shared/preferences/global_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

late final ChangeNotifierProvider<GlobalPreferences> preferencesProvider;

late final StateNotifierProvider<CookiesAuthorityState, CookiesAuthority>
    cookiesAuthorityProvider;

final userInfoProvider =
    StateNotifierProvider<UserInfoState, UserInfo?>((_) => UserInfoState());

final getUserInfoProvider = FutureProvider<UserInfoHttpResponse?>((ref) async {
  final preferences = ref.watch(preferencesProvider);

  if (preferences.cupontakeAuthKey == null ||
      preferences.cupontakeAuthKey!.isEmpty) return null;

  AuthServices authServices = AuthServices();
  HttpResponse response =
      await authServices.getUserInfo(preferences.cupontakeAuthKey!);

  return UserInfoHttpResponse(response.statusCode,
      jsonBody: jsonDecode(response.body));
});
