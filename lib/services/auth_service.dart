import 'package:cupon_take/models/enums/http_codes.dart';
import 'package:cupon_take/models/http_response.dart';
import 'package:cupon_take/models/user_info_http_request.dart';
import 'package:dio/dio.dart';

class AuthServices {
  String get _authServiceUrl => "http://localhost:5198/auth";
  String get _loginUrl => "$_authServiceUrl/login";
  String get _registerUrl => "$_authServiceUrl/register";
  String get _userInfoUrl => "$_authServiceUrl/user";

  Future<HttpResponse> login(UserInfoHttpRequest userInfoRequest) async {
    Dio client = Dio();
    client.options.headers["Content-Type"] = "application/json";
    client.options.headers["Access-Control-Allow-Origin"] = "*";
    client.options.headers["Access-Control-Allow-Methods"] = "POST";

    try {
      final body = userInfoRequest.toJson();
      final response = await Dio().post(_loginUrl, data: body);

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } on DioError catch (e) {
      return HttpResponse(
          statusCode: e.response!.statusCode!, body: e.response!.data);
    } catch (e) {
      return HttpResponse(statusCode: HttpCodes.NOT_FOUND.code, body: "");
    } finally {
      client.close();
    }
  }

  Future<HttpResponse> register(UserInfoHttpRequest userInfoRequest) async {
    try {
      final body = userInfoRequest.toJson();
      final response = await Dio().post(_registerUrl, data: body);

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
    final dioClient = Dio();
    dioClient.options.headers["Authorization"] = "Bearer $authToken";

    try {
      final response = await dioClient.get(_userInfoUrl,
          options: Options(responseType: ResponseType.json));

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } catch (_) {
      return HttpResponse(statusCode: HttpCodes.NOT_FOUND.code, body: "");
    } finally {
      dioClient.close();
    }
  }
}
