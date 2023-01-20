import 'package:coupon_take/models/redeem_history_http_request.dart';
import 'package:coupon_take/providers/providers.dart';
import 'package:coupon_take/shared/widgets/controllers/coupon_history_list_controller.dart';
import 'package:coupon_take/shared/widgets/controllers/coupon_history_list_state.dart';
import 'package:coupon_take/shared/widgets/coupon_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CouponHistoryList extends ConsumerStatefulWidget {
  final CouponHistoryListController? controller;

  const CouponHistoryList({super.key, this.controller});

  @override
  ConsumerState<CouponHistoryList> createState() => _CouponHistoryListState();
}

class _CouponHistoryListState extends ConsumerState<CouponHistoryList> {
  late final CouponHistoryListState state;

  @override
  void initState() {
    super.initState();
    state = CouponHistoryListState(page: 1);
    if (widget.controller != null) {
      widget.controller!.state = state;
      widget.controller!.onRefresh = _refresh;
      widget.controller!.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.dispose();
  }

  void _refresh() {
    // ignore: unused_result
    ref.refresh(fetchUserRedeemHistoryProvider(
      RedeemHistoryHttpRequest(page: state.page),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final redeemHistory = ref.watch(fetchUserRedeemHistoryProvider(
      RedeemHistoryHttpRequest(page: state.page),
    ));

    return redeemHistory.maybeWhen(
        data: (info) => RefreshIndicator(
              onRefresh: () {
                widget.controller?.reset();
                _refresh();
                return Future.value();
              },
              child: ListView.separated(
                  itemCount: info.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) =>
                      CouponHistoryTile(info[index].coupon),
                  separatorBuilder: (_, index) => const Divider()),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        orElse: () => Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.history_rounded),
                    Text("Não há histórico registrado.")
                  ]),
            ));
  }
}
