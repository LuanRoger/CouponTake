class EnviromentVariables {
  final String host;
  final String port;

  EnviromentVariables({required this.host, required this.port});

  String get hostAndPort => "$host:$port";
}
