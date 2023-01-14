import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserAuthKeyState extends StateNotifier<String?> {
  UserAuthKeyState({String? authKey}) : super(authKey);

  void initSession(String authKey) {
    state = authKey;
  }

  void logout() {
    state = null;
  }
}
