import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class CardBase extends HookConsumerWidget {
  String cardTitle;

  CardBase({super.key, required this.cardTitle});

  Widget? headerActions(BuildContext context);
  Widget virtualBuild(BuildContext context, WidgetRef ref);

  List<Widget> _buildHeader(BuildContext context) {
    List<Widget> headerWidgets = [
      Text(
        cardTitle,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
      )
    ];
    Widget? actions = headerActions(context);

    if (actions != null) {
      headerWidgets.add(actions);
    }

    return headerWidgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildHeader(context),
                ),
              ),
              Expanded(flex: 1, child: virtualBuild(context, ref))
            ],
          )),
    );
  }
}
