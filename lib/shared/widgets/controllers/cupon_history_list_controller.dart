import 'package:cupon_take/shared/widgets/controllers/cupon_history_list_state.dart';
import 'package:flutter/material.dart';

class CuponHistoryListController extends ChangeNotifier {
  late CuponHistoryListState _state;

  void Function()? onReset;

  CuponHistoryListController({this.onReset}) {
    _state = CuponHistoryListState(page: 1);
  }

  set state(CuponHistoryListState state) {
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

  void reset() {
    _state.page = 1;
    onReset?.call();
    notifyListeners();
  }
}
