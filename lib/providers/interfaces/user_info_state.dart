import 'package:cupon_take/models/user_info.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserInfoState extends StateNotifier<UserInfo?> {
  UserInfoState() : super(null);

  void initSession(UserInfo userInfo) {
    state = userInfo;
  }
}
