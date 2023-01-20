import 'package:coupon_take/models/enums/http_codes.dart';
import 'package:coupon_take/models/http_response.dart';
import 'package:coupon_take/models/redeem_history_http_request.dart';
import 'package:coupon_take/shared/global.dart';
import 'package:dio/dio.dart';

class CouponServices {
  String get _couponServicesUrl => "http://${envVars.hostAndPort}/coupon";
  String get _redeemUrl => "$_couponServicesUrl/redeem";
  String get _redeemHistoryUrl => "$_couponServicesUrl/history";

  final Dio dioClient = Dio();

  CouponServices() {
    dioClient.options.headers["Content-Type"] = "application/json";
  }

  Future<HttpResponse> redeemCoupon(String authToken) async {
    Dio clientWAuth = Dio();
    clientWAuth.options.headers = Map.from(dioClient.options.headers);
    clientWAuth.options.headers["Authorization"] = "Bearer $authToken";

    try {
      final response = await clientWAuth.get(_redeemUrl);

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } on DioError catch (e) {
      return HttpResponse(
          statusCode: e.response?.statusCode ?? HttpCodes.UNAVAILABLE.code,
          body: e.response?.data ?? "");
    } catch (_) {
      return HttpResponse(statusCode: HttpCodes.UNAVAILABLE.code, body: "");
    } finally {
      clientWAuth.close();
    }
  }

  Future<HttpResponse> getRedeemHistory(
      String authToken, RedeemHistoryHttpRequest historyRequest) async {
    Dio clientWAuth = Dio();
    clientWAuth.options.headers = Map.from(dioClient.options.headers);
    clientWAuth.options.headers["Authorization"] = "Bearer $authToken";

    try {
      final int limit = historyRequest.limitPerPage;
      final int page = historyRequest.page;
      final response =
          await clientWAuth.get("$_redeemHistoryUrl?limit=$limit&page=$page");

      return HttpResponse(
          statusCode: response.statusCode!, body: response.data);
    } on DioError catch (e) {
      return HttpResponse(
          statusCode: e.response?.statusCode ?? HttpCodes.UNAVAILABLE.code,
          body: e.response?.data ?? "");
    } catch (_) {
      return HttpResponse(statusCode: HttpCodes.UNAVAILABLE.code, body: "");
    } finally {
      clientWAuth.close();
    }
  }
}
