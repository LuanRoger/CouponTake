import 'package:cupon_take/models/enums/http_codes.dart';
import 'package:cupon_take/models/http_response.dart';
import 'package:cupon_take/models/user_info.dart';
import 'package:cupon_take/services/auth_service.dart';
import 'package:cupon_take/shared/preferences/global_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'interfaces/user_auth_state.dart';

late final ChangeNotifierProvider<GlobalPreferences> preferencesProvider;

final userAuthProvider =
    StateNotifierProvider<UserAuthKeyState, String?>((ref) {
  final userAuthKeyProvider = ref.watch(preferencesProvider);

  return UserAuthKeyState(authKey: userAuthKeyProvider.cupontakeAuthKey);
});

final fetchUserInfoProvider = FutureProvider<UserInfo>((ref) async {
  final userAuthKey = ref.watch(userAuthProvider);

  if (userAuthKey == null || userAuthKey.isEmpty) {
    throw Exception("There is no Auth Key");
  }

  AuthServices authServices = AuthServices();
  HttpResponse response = await authServices.getUserInfo(userAuthKey);
  if (response.statusCode != HttpCodes.SUCCESS.code) {
    throw Exception("The operation was not succeded");
  }

  return UserInfo(response.body["username"] as String,
      points: response.body["points"] as int);
});
