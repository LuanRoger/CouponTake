import 'package:cupon_take/models/redeem_history_http_request.dart';
import 'package:cupon_take/providers/providers.dart';
import 'package:cupon_take/shared/widgets/cupon_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CuponHistoryList extends HookConsumerWidget {
  CuponHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = useState(1);
    final redeemHistory = ref.watch(fetchUserRedeemHistoryProvider(
      RedeemHistoryHttpRequest(page: pageState.value),
    ));

    return redeemHistory.maybeWhen(
        data: (info) => ListView.separated(
            itemCount: info.length,
            shrinkWrap: true,
            itemBuilder: (_, index) => CuponHistoryTile(info[index].cupon),
            separatorBuilder: (_, index) => const Divider()),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        orElse: () => Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history_rounded),
                    Text("Não há histórico registrado")
                  ]),
            ));
  }
}
