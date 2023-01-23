import 'package:coupon_take/models/environment_variables.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfiguration {
  static const String _envFile = ".env";

  static Future<EnvironmentVariables> init() async {
    await dotenv.load(fileName: _envFile);
    return EnvironmentVariables(
        host: dotenv.env["API_HOST"]!, port: dotenv.env["API_PORT"]!);
  }
}
