import 'dart:convert';

import 'package:cupon_take/models/cookies_authority.dart';
import 'package:cupon_take/models/http_response.dart';
import 'package:cupon_take/models/user_info.dart';
import 'package:cupon_take/models/user_info_http_response.dart';
import 'package:cupon_take/providers/interfaces/cookies_authority_state.dart';
import 'package:cupon_take/services/auth_service.dart';
import 'package:cupon_take/shared/preferences/global_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'interfaces/user_auth_state.dart';

late final ChangeNotifierProvider<GlobalPreferences> preferencesProvider;

late final StateNotifierProvider<CookiesAuthorityState, CookiesAuthority>
    cookiesAuthorityProvider;

final userAuthProvider =
    StateNotifierProvider<UserAuthKeyState, String?>((ref) {
  final userAuthKey =
      ref.watch(cookiesAuthorityProvider.select((value) => value.jwtAuthToken));

  return UserAuthKeyState(authKey: userAuthKey);
});

final fetchUserInfoProvider = FutureProvider<UserInfo>((ref) async {
  final userAuthKey = ref.read(userAuthProvider);

  if (userAuthKey == null || userAuthKey.isEmpty)
    throw Exception("There is no Auth Key");

  AuthServices authServices = AuthServices();
  HttpResponse response = await authServices.getUserInfo(userAuthKey);

  final userResponse = UserInfoHttpResponse(response.statusCode,
      jsonData: response.body.isNotEmpty
          ? null
          : jsonDecode(response.body) as Map<String, String>);

  return UserInfo(userResponse.jsonData!["username"] as String,
      points: userResponse.jsonData!["points"] as int);
});
