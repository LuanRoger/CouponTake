import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoAccountMessage extends StatelessWidget {
  const NoAccountMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.no_accounts_rounded),
        Text(AppLocalizations.of(context)!.noAccountWarning)
      ],
    );
  }
}
