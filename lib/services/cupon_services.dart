import 'package:cupon_take/models/enums/http_codes.dart';
import 'package:cupon_take/models/http_response.dart';
import 'package:cupon_take/models/redeem_history_http_request.dart';
import 'package:dio/dio.dart';

class CuponServices {
  String get _cuponServicesUrl => "http://localhost:5198/cupon";
  String get _redeemUrl => "$_cuponServicesUrl/redeem";
  String get _redeemHistoryUrl => "$_cuponServicesUrl/history";

  final Dio dioClient = Dio();

  CuponServices() {
    dioClient.options.headers["Content-Type"] = "application/json";
  }

  Future<HttpResponse> redeemCupon(String authToken) async {
    Dio clientWAuth = Dio();
    clientWAuth.options.headers = Map.from(dioClient.options.headers);
    clientWAuth.options.headers["Authorization"] = "Bearer $authToken";

    try {
      final response = await clientWAuth.get(_redeemUrl);

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } catch (_) {
      return HttpResponse(statusCode: HttpCodes.NOT_FOUND.code, body: "");
    } finally {
      clientWAuth.close();
    }
  }

  Future<HttpResponse> getRedeemHistory(
      RedeemHistoryHttpRequest historyRequest) async {
    try {
      final response = await dioClient.get(_redeemHistoryUrl);

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } catch (_) {
      return HttpResponse(statusCode: HttpCodes.NOT_FOUND.code, body: "");
    } finally {
      dioClient.close();
    }
  }
}
