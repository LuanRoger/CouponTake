import 'package:coupon_take/shared/widgets/filled_material_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            AppLocalizations.of(context)!.lastRedeemCardTitle,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(couponCode ??
              AppLocalizations.of(context)!.noLastRedeemCardContent)
        ]),
      ),
    );
  }
}
