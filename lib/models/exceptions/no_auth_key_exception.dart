class NoAuthException implements Exception {
  final String message = "There is no Auth Key";

  @override
  String toString() {
    return message;
  }
}
