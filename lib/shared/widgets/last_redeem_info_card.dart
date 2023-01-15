import 'package:cupon_take/shared/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LastRedeemInfoCard extends HookConsumerWidget {
  const LastRedeemInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO: fetch hitory data
    return FilledMaterialCard(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Ultimo regate",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const Text("Dia 24 de janeiro, 10:30 PM")
        ]),
      ),
    );
  }
}
