import 'package:cupon_take/shared/app_text_style.dart';
import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String title;

  const CardTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.cardTitle,
    );
  }
}
