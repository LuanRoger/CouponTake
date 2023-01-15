import 'package:cupon_take/shared/widgets/cards/cards_base.dart';
import 'package:cupon_take/shared/widgets/cupon_history_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RightCard extends CardBase {
  RightCard({super.key, required super.cardTitle});

  @override
  Widget? headerActions(BuildContext context) => null;

  @override
  Widget virtualBuild(BuildContext context, WidgetRef ref) {
    return CuponHistoryList(List.empty());
  }
}
