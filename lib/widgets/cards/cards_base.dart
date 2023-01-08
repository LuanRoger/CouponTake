import 'package:cupon_take/widgets/card_title.dart';
import 'package:flutter/material.dart';

abstract class CardBase extends StatelessWidget {
  String cardTitle;

  CardBase({super.key, required this.cardTitle});

  Widget? headerActions(BuildContext context);
  Widget virtualBuild(BuildContext context);

  List<Widget> _buildHeader(BuildContext context) {
    List<Widget> headerWidgets = [CardTitle(cardTitle)];
    Widget? actions = headerActions(context);

    if (actions != null) {
      headerWidgets.add(actions);
    }

    return headerWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildHeader(context),
              ),
              virtualBuild(context)
            ],
          )),
    );
  }
}
