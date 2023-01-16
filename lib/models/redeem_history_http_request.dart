import 'package:equatable/equatable.dart';

class RedeemHistoryHttpRequest extends Equatable {
  int page;
  int limitPerPage;

  RedeemHistoryHttpRequest({required this.page, this.limitPerPage = 10});

  @override
  List<Object?> get props => [page, limitPerPage];
}
