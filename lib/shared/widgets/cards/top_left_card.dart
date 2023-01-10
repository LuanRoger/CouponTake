import 'package:cupon_take/shared/widgets/cards/cards_base.dart';
import 'package:flutter/material.dart';

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
  Widget virtualBuild(BuildContext context) {
    return Text("Body");
  }
}
