import 'package:cupon_take/pages/home_page/sections/history_section.dart';
import 'package:cupon_take/shared/widgets/cards/cards_base.dart';
import 'package:cupon_take/shared/widgets/cupon_history_list.dart';
import 'package:flutter/material.dart';

class RightCard extends CardBase {
  RightCard({super.key, required super.cardTitle});

  @override
  Widget? headerActions(BuildContext context) => null;

  @override
  Widget virtualBuild(BuildContext context) {
    return CuponHistoryList(List.empty());
  }
}
