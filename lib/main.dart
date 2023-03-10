import 'package:coupon_take/l10n/l10n.dart';
import 'package:coupon_take/models/enums/app_brightness.dart';
import 'package:coupon_take/providers/providers.dart';
import 'package:coupon_take/routes/app_routes.dart';
import 'package:coupon_take/routes/route_driver.dart';
import 'package:coupon_take/shared/app_theme_data.dart';
import 'package:coupon_take/shared/environment_configuration.dart';
import 'package:coupon_take/shared/global.dart';
import 'package:coupon_take/shared/preferences/global_preferences.dart';
import 'package:coupon_take/shared/responsive_breakpoints_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Providers initialization
  GlobalPreferences globalPreferences = GlobalPreferences();
  await globalPreferences.init();

  preferencesProvider =
      ChangeNotifierProvider<GlobalPreferences>((_) => globalPreferences);

  envVars = await EnvironmentConfiguration.init();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themePreferences = ref.watch(themePreferencesProvider);
    final localePreferences = ref.watch(localePreferencesProvider);

    return MaterialApp(
      builder: (_, child) => ResponsiveWrapper.builder(child,
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
      theme: AppThemeData.getAppTheme(
          AppBrightness.values[themePreferences.brightness],
          themePreferences.colorIndex),
      initialRoute: AppRoutes.homePage,
      onGenerateRoute: RouteDriver.drive,
      locale: localePreferences,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: L10n.locales,
    );
  }
}
