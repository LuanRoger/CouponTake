import 'package:cupon_take/providers/providers.dart';
import 'package:cupon_take/services/cupon_services.dart';
import 'package:cupon_take/shared/widgets/cards/cards_base.dart';
import 'package:cupon_take/shared/widgets/no_account_message.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopLeftCard extends CardBase {
  TopLeftCard({super.key, required super.cardTitle});

  @override
  Widget? headerActions(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.light_mode))
      ],
    );
  }

  @override
  Widget virtualBuild(BuildContext context, WidgetRef ref) {
    final authKey = ref.read(userAuthProvider);
    final userInfo = ref.watch(fetchUserInfoProvider);

    return userInfo.maybeWhen(
      data: (info) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: 0,
              child: Chip(
                  avatar: const Icon(Icons.attach_money_rounded),
                  label: Text(info.points.toString()))),
          Expanded(
            flex: 1,
            child: Center(
              child: FloatingActionButton.extended(
                  icon: Icon(Icons.add_rounded),
                  label: Text("Adicionar pontos"),
                  onPressed: () {}),
            ),
          ),
        ],
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      orElse: () => const Center(child: NoAccountMessage()),
    );
  }
}
