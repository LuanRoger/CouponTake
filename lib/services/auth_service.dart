import 'package:cupon_take/models/enums/http_codes.dart';
import 'package:cupon_take/models/http_response.dart';
import 'package:cupon_take/models/user_info_http_request.dart';
import 'package:dio/dio.dart';

class AuthServices {
  String get _authServiceUrl => "http://localhost:5039/auth";
  String get _loginUrl => "$_authServiceUrl/login";
  String get _registerUrl => "$_authServiceUrl/register";
  String get _userInfoUrl => "$_authServiceUrl/user";

  Future<HttpResponse> login(UserInfoHttpRequest userInfoRequest) async {
    try {
      final response = await Dio().post(_loginUrl, data: {
        "username": userInfoRequest.username,
        "password": userInfoRequest.password
      });

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } catch (_) {
      return HttpResponse(statusCode: HttpCodes.NOT_FOUND.code, body: "");
    }
  }

  Future<HttpResponse> register(UserInfoHttpRequest userInfoRequest) async {
    try {
      final response = await Dio().post(_registerUrl, data: {
        "username": userInfoRequest.username,
        "password": userInfoRequest.password
      });

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } catch (_) {
      return HttpResponse(statusCode: HttpCodes.NOT_FOUND.code, body: "");
    }
  }

  Future<HttpResponse> getUserInfo(String authToken) async {
    final dioClient = Dio();
    dioClient.options.headers["Authorization"] = "Bearer $authToken";

    try {
      final response = await dioClient.get(_userInfoUrl);

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } catch (_) {
      return HttpResponse(statusCode: HttpCodes.NOT_FOUND.code, body: "");
    }
  }
}
