import 'package:cupon_take/models/enums/app_brightness.dart';
import 'package:cupon_take/models/enums/enviroment.dart';
import 'package:cupon_take/providers/providers.dart';
import 'package:cupon_take/routes/app_routes.dart';
import 'package:cupon_take/routes/route_driver.dart';
import 'package:cupon_take/shared/app_theme_data.dart';
import 'package:cupon_take/shared/enviromet_configuration.dart';
import 'package:cupon_take/shared/global.dart';
import 'package:cupon_take/shared/preferences/global_preferences.dart';
import 'package:cupon_take/shared/responsive_breakpoints_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Providers initialization
  GlobalPreferences globalPreferences = GlobalPreferences();
  await globalPreferences.init();

  preferencesProvider =
      ChangeNotifierProvider<GlobalPreferences>((_) => globalPreferences);

  //Enviroment initialization
  Enviroment enviroment =
      kDebugMode ? Enviroment.DEVELOPMENT : Enviroment.PRODUCTION;
  envVars = await EnviromentConfiguration.init(enviroment, forceProd: true);

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themePreferences = ref.watch(themePreferencesProvider);

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
        onGenerateRoute: RouteDriver.drive);
  }
}
