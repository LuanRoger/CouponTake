import 'package:coupon_take/models/user_info.dart';
import 'package:flutter/material.dart';

class UsernameInfoChip extends StatelessWidget {
  UserInfo userInfo;

  UsernameInfoChip(this.userInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        userInfo.username,
        maxLines: 1,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
