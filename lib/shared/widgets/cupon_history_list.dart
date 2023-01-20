import 'package:cupon_take/models/redeem_history_http_request.dart';
import 'package:cupon_take/providers/providers.dart';
import 'package:cupon_take/shared/widgets/controllers/cupon_history_list_controller.dart';
import 'package:cupon_take/shared/widgets/controllers/cupon_history_list_state.dart';
import 'package:cupon_take/shared/widgets/cupon_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CuponHistoryList extends ConsumerStatefulWidget {
  final CuponHistoryListController? controller;

  const CuponHistoryList({super.key, this.controller});

  @override
  ConsumerState<CuponHistoryList> createState() => _CuponHistoryListState();
}

class _CuponHistoryListState extends ConsumerState<CuponHistoryList> {
  late final CuponHistoryListState state;

  @override
  void initState() {
    super.initState();
    state = CuponHistoryListState(page: 1);
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
                      CuponHistoryTile(info[index].cupon),
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
