import 'dart:convert';

class UserInfoHttpRequest {
  String username;
  String password;

  UserInfoHttpRequest(this.username, this.password);

  String toJson() => jsonEncode({"username": username, "password": password});
}
