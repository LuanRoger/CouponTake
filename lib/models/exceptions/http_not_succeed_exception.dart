import 'package:format/format.dart';

class HttpNotSucceedException implements Exception {
  final String message = "The operation \"{}\" was not succeded";
  final String operation;
  final int code;

  HttpNotSucceedException(this.operation, {required this.code});

  @override
  String toString() {
    return format(message, operation);
  }
}
