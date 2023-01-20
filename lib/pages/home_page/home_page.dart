import 'package:coupon_take/pages/home_page/sections/account_section/account_section.dart';
import 'package:coupon_take/pages/home_page/sections/configurations_section.dart';
import 'package:coupon_take/pages/home_page/sections/history_section.dart';
import 'package:coupon_take/pages/home_page/sections/home_section.dart';
import 'package:coupon_take/shared/responsive_breakpoints_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  Widget _changeDestination(int index) {
    switch (index) {
      case 0:
        return const HomeSection();
      case 1:
        return AccountSection();
      case 2:
        return HistorySection();
      case 3:
        return const ConfigurationSection();
      default:
        return const HomeSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    const int initialPageIndex = 0;
    final selectedRailIndexState = useState(initialPageIndex);
    final mainContentState =
        useState<Widget>(_changeDestination(initialPageIndex));

    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ResponsiveVisibility(
              hiddenWhen: const [
                Condition.equals(
                    name: ResponsiveBreakpointsName.mobileBreakpoint)
              ],
              child: NavigationRail(
                selectedIndex: selectedRailIndexState.value,
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
                  NavigationRailDestination(
                    icon: Icon(Icons.settings_rounded),
                    label: Text("Configurações"),
                  ),
                ],
                onDestinationSelected: (newIndex) {
                  mainContentState.value = _changeDestination(newIndex);
                  selectedRailIndexState.value = newIndex;
                },
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: mainContentState.value),
            ))
          ],
        ),
      ),
      bottomNavigationBar: ResponsiveValue<NavigationBar?>(context,
          defaultValue: null,
          valueWhen: [
            Condition.equals(
                name: ResponsiveBreakpointsName.mobileBreakpoint,
                value: NavigationBar(
                  selectedIndex: selectedRailIndexState.value,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_rounded),
                      label: "Inicío",
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.account_circle_rounded),
                      label: "Conta",
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.history_rounded),
                      label: "Histórico",
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.settings_rounded),
                      label: "Configurações",
                    )
                  ],
                  onDestinationSelected: (newIndex) {
                    mainContentState.value = _changeDestination(newIndex);
                    selectedRailIndexState.value = newIndex;
                  },
                )),
            const Condition.largerThan(
                name: ResponsiveBreakpointsName.mobileBreakpoint, value: null)
          ]).value,
    );
  }
}
