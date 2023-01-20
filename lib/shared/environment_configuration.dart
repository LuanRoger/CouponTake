import 'package:coupon_take/models/enums/environment.dart';
import 'package:coupon_take/models/environment_variables.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfiguration {
  static const String _devEnvFile = ".env.dev";
  static const String _prodEnvFile = ".env.prod";

  static Future<EnvironmentVariables> _loadDevEnviroment() async {
    await dotenv.load(fileName: _devEnvFile);
    return EnvironmentVariables(
        host: dotenv.env["API_HOST"]!, port: dotenv.env["API_PORT"]!);
  }

  static Future<EnvironmentVariables> _loadProdEnviroment() async {
    await dotenv.load(fileName: _prodEnvFile);
    return EnvironmentVariables(
        host: dotenv.env["API_HOST"]!, port: dotenv.env["API_PORT"]!);
  }

  static Future<EnvironmentVariables> init(Environment enviroment,
      {bool forceProd = false}) async {
    if (forceProd) return _loadProdEnviroment();

    switch (enviroment) {
      case Environment.DEVELOPMENT:
        return await _loadDevEnviroment();
      case Environment.PRODUCTION:
        return await _loadProdEnviroment();
    }
  }
}
