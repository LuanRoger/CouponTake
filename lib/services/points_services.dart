import 'package:coupon_take/models/enums/http_codes.dart';
import 'package:coupon_take/models/http_response.dart';
import 'package:coupon_take/shared/global.dart';
import 'package:dio/dio.dart';

class PointsServices {
  String get _pointsServiceUrl => "http://${envVars.hostAndPort}/coupon";
  String get _pointsUrl => "$_pointsServiceUrl/points";

  final dioClient = Dio();

  PointsServices() {
    dioClient.options.headers["Content-Type"] = "application/json";
  }

  Future<HttpResponse> requestPoints(String authToken,
      {int points = 50}) async {
    Dio clientWAuth = Dio();
    clientWAuth.options.headers = Map.from(dioClient.options.headers);
    clientWAuth.options.headers["Authorization"] = "Bearer $authToken";

    try {
      final response = await clientWAuth.post("$_pointsUrl?points=$points");

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } on DioError catch (e) {
      return HttpResponse(
          statusCode: e.response?.statusCode ?? HttpCodes.UNAVAILABLE.code,
          body: e.response?.data ?? "");
    } catch (_) {
      return HttpResponse(statusCode: HttpCodes.UNAVAILABLE.code, body: "");
    }
  }
}
