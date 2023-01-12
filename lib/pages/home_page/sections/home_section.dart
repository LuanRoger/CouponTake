import 'package:cupon_take/models/user_info.dart';
import 'package:cupon_take/shared/responsive_breakpoints_name.dart';
import 'package:cupon_take/shared/widgets/cards/top_left_card.dart';
import 'package:cupon_take/shared/widgets/cards/right_card.dart';
import 'package:cupon_take/shared/widgets/cards/bottom_left_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveWrapper.of(context)
              .isSmallerThan(ResponsiveBreakpointsName.tabletBreakpoint)
          ? ResponsiveRowColumnType.COLUMN
          : ResponsiveRowColumnType.ROW,
      rowMainAxisAlignment: MainAxisAlignment.start,
      children: [
        ResponsiveRowColumnItem(
          rowFlex: 2,
          columnFlex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: TopLeftCard(cardTitle: "Pontos"),
              ),
              Expanded(
                flex: 1,
                child:
                    BottomLeftCard(UserInfo("lroger"), cardTitle: "Resgatar"),
              ),
            ],
          ),
        ),
        if (ResponsiveWrapper.of(context).activeBreakpoint.name !=
            ResponsiveBreakpointsName.mobileBreakpoint)
          ResponsiveRowColumnItem(
            rowFlex: 1,
            columnFlex: 1,
            child: RightCard(cardTitle: "Histórico"),
          )
      ],
    );
  }
}
