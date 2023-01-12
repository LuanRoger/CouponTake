import 'package:cupon_take/models/user_info.dart';
import 'package:cupon_take/shared/widgets/cards/cards_base.dart';
import 'package:cupon_take/shared/widgets/material_card.dart';
import 'package:cupon_take/shared/widgets/user_info_chip.dart';
import 'package:flutter/material.dart';

class BottomLeftCard extends CardBase {
  UserInfo userInfo;

  BottomLeftCard(this.userInfo, {super.key, required super.cardTitle});

  @override
  Widget? headerActions(BuildContext context) {
    return Row(
      children: [
        UserInfoChip(userInfo),
      ],
    );
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 0,
          child: FilledMaterialCard(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: FloatingActionButton.extended(
              icon: const Icon(Icons.api_rounded),
              onPressed: () {},
              label: const Text("Requisitar código"),
            ),
          ),
        )
      ],
    );
  }
}
