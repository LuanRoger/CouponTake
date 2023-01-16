import 'package:flutter/material.dart';

class NoAccountMessage extends StatelessWidget {
  const NoAccountMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.no_accounts_rounded),
        Text("Entre ou crie uma conta.")
      ],
    );
  }
}
