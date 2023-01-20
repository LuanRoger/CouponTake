import 'package:coupon_take/models/coupon.dart';
import 'package:flutter/material.dart';

class CouponHistoryTile extends StatelessWidget {
  final Coupon couponInfo;

  const CouponHistoryTile(this.couponInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    int day = couponInfo.createdAt.day;
    int month = couponInfo.createdAt.month;
    int year = couponInfo.createdAt.year;

    int hour = couponInfo.createdAt.hour;
    int minute = couponInfo.createdAt.minute;

    return ListTile(
      title: Text(couponInfo.couponCode),
      subtitle: Text("$day/$month/$year - $hour:${minute < 10 ? "0$minute" : minute}"),
    );
  }
}
