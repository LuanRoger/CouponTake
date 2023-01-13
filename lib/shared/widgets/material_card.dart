import 'package:flutter/material.dart';

class FilledMaterialCard extends StatelessWidget {
  final Widget child;

  const FilledMaterialCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: child,
    );
  }
}
