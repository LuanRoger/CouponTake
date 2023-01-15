enum HttpCodes {
  SUCCESS(200),
  NOT_FOUND(404);

  final int code;

  const HttpCodes(this.code);
}
