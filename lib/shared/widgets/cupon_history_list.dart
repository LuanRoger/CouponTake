import 'package:cupon_take/models/cupon.dart';
import 'package:flutter/material.dart';

class CuponHistoryList extends StatelessWidget {
  List<Cupon> cupons;

  CuponHistoryList(this.cupons, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: cupons.length,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          final cupon = cupons[index];
          return ListTile(
            title: Text(cupon.cuponCode),
            subtitle: Text(cupon.createdAt.toString()),
          );
        },
        separatorBuilder: (_, index) => const Divider());
  }
}
