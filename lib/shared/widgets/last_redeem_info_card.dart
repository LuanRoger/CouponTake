import 'package:coupon_take/shared/widgets/filled_material_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LastRedeemInfoCard extends HookConsumerWidget {
  String? couponCode;

  LastRedeemInfoCard({super.key, this.couponCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledMaterialCard(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Último regate",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(couponCode ?? "Não houve recentes.")
        ]),
      ),
    );
  }
}
