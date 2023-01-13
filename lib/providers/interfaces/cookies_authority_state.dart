import 'package:cupon_take/models/cookies_authority.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CookiesAuthorityState extends StateNotifier<CookiesAuthority> {
  CookiesAuthorityState({CookiesAuthority? cookiesAuthority})
      : super(cookiesAuthority ?? CookiesAuthority());

  void setJwtAuth(String jwt) {
    state = state.copyWith(jwtAuthToken: jwt);
  }
}
