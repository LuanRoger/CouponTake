import 'package:cupon_take/providers/interfaces/cookies_authority_state.dart';
import 'package:cupon_take/providers/providers.dart';
import 'package:cupon_take/routes/app_routes.dart';
import 'package:cupon_take/routes/route_driver.dart';
import 'package:cupon_take/shared/app_theme_data.dart';
import 'package:cupon_take/shared/preferences/global_preferences.dart';
import 'package:cupon_take/shared/responsive_breakpoints_name.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'models/cookies_authority.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalPreferences globalPreferences = GlobalPreferences();
  globalPreferences.init();

  preferencesProvider =
      ChangeNotifierProvider<GlobalPreferences>((_) => globalPreferences);

  cookiesAuthorityProvider =
      StateNotifierProvider<CookiesAuthorityState, CookiesAuthority>((ref) {
    final preferences = ref.watch(preferencesProvider);

    return CookiesAuthorityState(
        cookiesAuthority:
            CookiesAuthority(jwtAuthToken: preferences.cupontakeAuthKey));
  });

  runApp(
    MaterialApp(
        builder: (_, child) => ProviderScope(
              child: ResponsiveWrapper.builder(child,
                  minWidth: 375,
                  defaultScale: true,
                  breakpoints: const [
                    ResponsiveBreakpoint.autoScale(375,
                        name: ResponsiveBreakpointsName.mobileBreakpoint),
                    ResponsiveBreakpoint.resize(600,
                        name: ResponsiveBreakpointsName.tabletBreakpoint),
                    ResponsiveBreakpoint.resize(1200,
                        name: ResponsiveBreakpointsName.desktopBreakpoint)
                  ]),
            ),
        theme: AppThemeData.appDarkTheme,
        initialRoute: AppRoutes.homePage,
        onGenerateRoute: RouteDriver.drive),
  );
}
