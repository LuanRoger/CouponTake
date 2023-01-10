import 'package:cupon_take/models/user_info.dart';
import 'package:cupon_take/widgets/cards/cards_base.dart';
import 'package:cupon_take/widgets/user_info_chip.dart';
import 'package:flutter/material.dart';

class TopRightCard extends CardBase {
  UserInfo userInfo;

  TopRightCard(this.userInfo, {super.key, required super.cardTitle});

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
    return Text("Body");
  }
}
