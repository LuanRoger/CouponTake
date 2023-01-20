class EnvironmentVariables {
  final String host;
  final String port;

  EnvironmentVariables({required this.host, required this.port});

  String get hostAndPort => "$host:$port";
}
