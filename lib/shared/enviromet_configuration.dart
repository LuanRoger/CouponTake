import 'package:cupon_take/models/enums/enviroment.dart';
import 'package:cupon_take/models/enviroment_variables.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnviromentConfiguration {
  static const String _devEnvFile = ".env.dev";
  static const String _prodEnvFile = ".env.prod";

  static Future<EnviromentVariables> _loadDevEnviroment() async {
    await dotenv.load(fileName: _devEnvFile);
    return EnviromentVariables(
        host: dotenv.env["API_HOST"]!, port: dotenv.env["API_PORT"]!);
  }

  static Future<EnviromentVariables> _loadProdEnviroment() async {
    await dotenv.load(fileName: _prodEnvFile);
    return EnviromentVariables(
        host: dotenv.env["API_HOST"]!, port: dotenv.env["API_PORT"]!);
  }

  static Future<EnviromentVariables> init(Enviroment enviroment,
      {bool forceProd = false}) async {
    if (forceProd) return _loadProdEnviroment();

    switch (enviroment) {
      case Enviroment.DEVELOPMENT:
        return await _loadDevEnviroment();
      case Enviroment.PRODUCTION:
        return await _loadProdEnviroment();
    }
  }
}
