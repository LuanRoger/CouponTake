// ignore_for_file: constant_identifier_names

enum Localization {
  PORTUGUESE("Português", 0),
  ENGLISH("English", 1);

  final String langName;
  final int code;

  const Localization(this.langName, this.code);
}
