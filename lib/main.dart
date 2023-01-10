import 'package:cupon_take/routes/route_driver.dart';
import 'package:cupon_take/shared/app_theme_data.dart';
import 'package:cupon_take/shared/responsive_breakpoints_name.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(
    MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(child,
                minWidth: 400,
                defaultScale: true,
                breakpoints: const [
                  ResponsiveBreakpoint.resize(350,
                      name: ResponsiveBreakpointsName.mobileBreakpoint),
                  ResponsiveBreakpoint.autoScale(850,
                      name: ResponsiveBreakpointsName.tabletBreakpoint),
                  ResponsiveBreakpoint.resize(1024,
                      name: ResponsiveBreakpointsName.desktopBreakpoint)
                ]),
        theme: AppThemeData.appDarkTheme,
        onGenerateRoute: RouteDriver.drive),
  );
}
