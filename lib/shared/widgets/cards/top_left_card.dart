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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            flex: 0,
            child: Chip(
                avatar: Icon(Icons.attach_money_rounded), label: Text("100"))),
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
    );
  }
}
