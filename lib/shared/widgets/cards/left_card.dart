import 'package:cupon_take/shared/widgets/cards/cards_base.dart';
import 'package:flutter/material.dart';

class LeftCard extends CardBase {
  LeftCard({super.key, required super.cardTitle});

  @override
  Widget? headerActions(BuildContext context) => null;

  @override
  Widget virtualBuild(BuildContext context) {
    return Text("Body");
  }
}
