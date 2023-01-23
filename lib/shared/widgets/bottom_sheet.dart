import 'package:flutter/material.dart';

class BottomSheet {
  final BuildContext context;
  Widget body;
  double? height;

  BottomSheet(this.context, {required this.body, this.height});

  void show() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(height: height, child: body),
          );
        });
  }
}
