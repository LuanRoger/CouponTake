class FormsValidators {
  static bool checkNotEmptyAndLengh(String? text, int requiredLenght) =>
      text != null && text.isNotEmpty && text.length >= requiredLenght;
}
