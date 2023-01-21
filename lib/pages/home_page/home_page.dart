import 'package:coupon_take/pages/home_page/sections/account_section/account_section.dart';
import 'package:coupon_take/pages/home_page/sections/configurations_section.dart';
import 'package:coupon_take/pages/home_page/sections/history_section.dart';
import 'package:coupon_take/pages/home_page/sections/home_section.dart';
import 'package:coupon_take/shared/responsive_breakpoints_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                destinations: [
                  NavigationRailDestination(
                    icon: const Icon(Icons.home_rounded),
                    label:
                        Text(AppLocalizations.of(context)!.navigationBarHome),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.account_circle_rounded),
                    label: Text(
                        AppLocalizations.of(context)!.navigationBarAccount),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.history_rounded),
                    label: Text(
                        AppLocalizations.of(context)!.navigationBarHistory),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.settings_rounded),
                    label: Text(
                        AppLocalizations.of(context)!.navigationBarSettings),
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
                  destinations: [
                    NavigationDestination(
                      icon: const Icon(Icons.home_rounded),
                      label: AppLocalizations.of(context)!.navigationBarHome,
                    ),
                    NavigationDestination(
                      icon: const Icon(Icons.account_circle_rounded),
                      label: AppLocalizations.of(context)!.navigationBarAccount,
                    ),
                    NavigationDestination(
                      icon: const Icon(Icons.history_rounded),
                      label: AppLocalizations.of(context)!.navigationBarHistory,
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.settings_rounded),
                      label:
                          AppLocalizations.of(context)!.navigationBarSettings,
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
