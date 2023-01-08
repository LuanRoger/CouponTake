import 'package:cupon_take/widgets/cards/cards_base.dart';
import 'package:flutter/material.dart';

class TopLeftCard extends CardBase {
  TopLeftCard({super.key, required super.cardTitle});

  @override
  Widget? headerActions(BuildContext context) => null;

  @override
  Widget virtualBuild(BuildContext context) {
    return Text("Body");
  }
}
