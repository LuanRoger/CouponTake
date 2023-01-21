import 'package:coupon_take/shared/widgets/cards/cards_base.dart';
import 'package:coupon_take/shared/widgets/coupon_history_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RightCard extends CardBase {
  RightCard({super.key, required super.cardTitle});

  @override
  Widget? headerActions(BuildContext context) => null;

  @override
  Widget virtualBuild(BuildContext context, WidgetRef ref) {
    return const CouponHistoryList();
  }
}
