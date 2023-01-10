import 'package:cupon_take/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class RouteDriver {
  static Route<dynamic> drive(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return goToHomePage;
      default:
        return goToHomePage;
    }
  }

  static MaterialPageRoute get goToHomePage =>
      MaterialPageRoute(builder: (_) => HomePage());
}
