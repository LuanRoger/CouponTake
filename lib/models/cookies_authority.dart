class CookiesAuthority {
  String? jwtAuthToken;

  CookiesAuthority({this.jwtAuthToken});

  CookiesAuthority copyWith({String? jwtAuthToken}) {
    return CookiesAuthority(jwtAuthToken: jwtAuthToken ?? this.jwtAuthToken);
  }
}
