import 'package:cupon_take/models/http_response.dart';
import 'package:cupon_take/models/user_info_http_request.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  String get _authServiceUrl => "http://localhost:5039/auth";
  Uri get _loginUrl => Uri.parse("$_authServiceUrl/login");
  Uri get _registerUrl => Uri.parse("$_authServiceUrl/register");
  Uri get _userInfoUrl => Uri.parse("$_authServiceUrl/user");

  Future<HttpResponse> login(String username, String password) async {
    final UserInfoHttpRequest userInfoRequest =
        UserInfoHttpRequest(username, password);
    final response = await http.post(_loginUrl, body: userInfoRequest.toJson());

    return HttpResponse(statusCode: response.statusCode, body: response.body);
  }

  Future<HttpResponse> register(String username, String password) async {
    final UserInfoHttpRequest userInfoRequest =
        UserInfoHttpRequest(username, password);
    final response =
        await http.post(_registerUrl, body: userInfoRequest.toJson());

    return HttpResponse(statusCode: response.statusCode, body: response.body);
  }

  Future<HttpResponse> getUserInfo(String authToken) async {
    final response = await http
        .get(_userInfoUrl, headers: {"Authorization": "Bearer $authToken"});

    return HttpResponse(statusCode: response.statusCode, body: response.body);
  }
}
