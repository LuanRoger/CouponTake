import 'package:cupon_take/pages/home_page/sections/home_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Widget mainContent;
  late int selectedRailIndex;

  @override
  void initState() {
    super.initState();
    mainContent = HomeSection();
    selectedRailIndex = 0;
  }

  Widget _changeDestination(int index) {
    switch (index) {
      case 0:
        return HomeSection();
    }

    return HomeSection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NavigationRail(
            selectedIndex: selectedRailIndex,
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_rounded),
                label: Text("Inicío"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.account_circle_rounded),
                label: Text("Conta"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history_rounded),
                label: Text("Histórico"),
              ),
            ],
            onDestinationSelected: (value) => setState(() {
              mainContent = _changeDestination(value);
              selectedRailIndex = value;
            }),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: mainContent,
          ))
        ],
      ),
    );
  }
}
