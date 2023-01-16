import 'package:flutter/material.dart';

class ColorPreview extends StatelessWidget {
  final Color color;
  final void Function() onPressed;

  const ColorPreview(this.color, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: color,
      shape: const CircleBorder(),
      child: const SizedBox(
        height: 30,
        width: 30,
      ),
    );
  }
}
