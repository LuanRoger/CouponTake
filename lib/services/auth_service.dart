import 'package:cupon_take/models/enums/http_codes.dart';
import 'package:cupon_take/models/http_response.dart';
import 'package:cupon_take/models/user_info_http_request.dart';
import 'package:dio/dio.dart';

class AuthServices {
  String get _authServiceUrl => "http://localhost:5198/auth";
  String get _loginUrl => "$_authServiceUrl/login";
  String get _registerUrl => "$_authServiceUrl/register";
  String get _userInfoUrl => "$_authServiceUrl/user";

  final Dio dioClient = Dio();

  AuthServices() {
    dioClient.options.headers["Content-Type"] = "application/json";
  }

  Future<HttpResponse> login(UserInfoHttpRequest userInfoRequest) async {
    try {
      final body = userInfoRequest.toJson();
      final response = await dioClient.post(_loginUrl, data: body);

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } on DioError catch (e) {
      return HttpResponse(
          statusCode: e.response!.statusCode!, body: e.response!.data);
    } catch (e) {
      return HttpResponse(statusCode: HttpCodes.NOT_FOUND.code, body: "");
    } finally {
      dioClient.close();
    }
  }

  Future<HttpResponse> register(UserInfoHttpRequest userInfoRequest) async {
    try {
      final body = userInfoRequest.toJson();
      final response = await dioClient.post(_registerUrl, data: body);

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } on DioError catch (e) {
      return HttpResponse(
          statusCode: e.response!.statusCode!, body: e.response!.data);
    } catch (_) {
      return HttpResponse(statusCode: HttpCodes.NOT_FOUND.code, body: "");
    }
  }

  Future<HttpResponse> getUserInfo(String authToken) async {
    Dio clientWAuth = Dio();
    clientWAuth.options.headers = Map.from(dioClient.options.headers);
    clientWAuth.options.headers["Authorization"] = "Bearer $authToken";

    try {
      final response = await clientWAuth.get(_userInfoUrl,
          options: Options(responseType: ResponseType.json));

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } catch (_) {
      return HttpResponse(statusCode: HttpCodes.NOT_FOUND.code, body: "");
    } finally {
      clientWAuth.close();
    }
  }
}
