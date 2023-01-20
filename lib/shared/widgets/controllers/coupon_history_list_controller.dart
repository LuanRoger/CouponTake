import 'package:coupon_take/shared/widgets/controllers/coupon_history_list_state.dart';
import 'package:flutter/material.dart';

class CouponHistoryListController extends ChangeNotifier {
  late CouponHistoryListState _state;

  void Function()? onReset;
  void Function()? onRefresh;

  CouponHistoryListController({this.onReset}) {
    _state = CouponHistoryListState(page: 1);
  }

  set state(CouponHistoryListState state) {
    _state = state;
  }

  int get page => _state.page;

  void nextPage() {
    _state.page++;
    notifyListeners();
  }

  void previousPage() {
    if (_state.page <= 1) return;

    _state.page--;
    notifyListeners();
  }

  void refresh() {
    onRefresh?.call();
  }

  void reset() {
    _state.page = 1;
    onReset?.call();
    notifyListeners();
  }
}
