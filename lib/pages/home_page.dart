import 'package:cupon_take/models/user_info.dart';
import 'package:cupon_take/widgets/cards/bottom_card.dart';
import 'package:cupon_take/widgets/cards/top_left_card.dart';
import 'package:cupon_take/widgets/cards/top_right_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 10,
                    child: TopLeftCard(cardTitle: "Histórico"),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 10,
                    child:
                        TopRightCard(UserInfo("lroger"), cardTitle: "Resgatar"),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 10,
              child: BottomCard(cardTitle: "Pontos"),
            )
          ],
        ),
      ),
    );
  }
}
