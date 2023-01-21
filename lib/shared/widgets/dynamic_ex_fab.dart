import 'package:flutter/material.dart';

class DynamicExFab extends StatelessWidget {
  void Function() onPressed;
  IconData icon;
  Widget label;
  bool enabled;

  DynamicExFab(
      {super.key,
      required this.label,
      required this.icon,
      required this.onPressed,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        icon: enabled ? Icon(icon) : const Icon(Icons.av_timer_rounded),
        label: label,
        onPressed: enabled ? onPressed : null);
  }
}
