class EmptyListExceeption implements Exception {
  final String message = "There is no record in the list.";

  EmptyListExceeption();

  @override
  String toString() {
    return message;
  }
}
