class UserInfoHttpResponse {
  int statusCode;
  Map<String, String>? jsonData;

  UserInfoHttpResponse(this.statusCode, {required this.jsonData});
}
