import 'package:cupon_take/models/cupon.dart';
import 'package:flutter/material.dart';

class CuponHistoryTile extends StatelessWidget {
  final Cupon cuponInfo;

  const CuponHistoryTile(this.cuponInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    int day = cuponInfo.createdAt.day;
    int month = cuponInfo.createdAt.month;
    int year = cuponInfo.createdAt.year;

    int hour = cuponInfo.createdAt.hour;
    int minute = cuponInfo.createdAt.minute;

    return ListTile(
      title: Text(cuponInfo.cuponCode),
      subtitle: Text("$day/$month/$year - $hour:${minute < 10 ? "0$minute" : minute}"),
    );
  }
}
