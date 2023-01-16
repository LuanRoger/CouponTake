import 'package:freezed_annotation/freezed_annotation.dart';

part 'redeem_history_http_request.freezed.dart';

@freezed
class RedeemHistoryHttpRequest with _$RedeemHistoryHttpRequest {
  const factory RedeemHistoryHttpRequest(
      {required int page,
      @Default(10) int limitPerPage}) = _RedeemHistoryHttpRequest;
}
