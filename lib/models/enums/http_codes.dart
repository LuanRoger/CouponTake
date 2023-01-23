// ignore_for_file: constant_identifier_names

enum HttpCodes {
  SUCCESS(200),
  UNAVAILABLE(503),
  NOT_FOUND(404);

  final int code;

  const HttpCodes(this.code);
}
