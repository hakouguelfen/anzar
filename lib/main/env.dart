enum Environment { dev, prod }

abstract class AppEnvironment {
  static late String _apiUrl;
  static late Environment _environment;

  static Environment get environment => _environment;
  static String get apiUrl => _apiUrl;

  static setupEnvironment(Environment env) {
    _environment = env;
    switch (env) {
      case Environment.dev:
        _apiUrl = "https://dev.example.com";
        break;

      case Environment.prod:
        _apiUrl = "https://example.com";
        break;

      default:
        _apiUrl = "https://example.com";
    }
  }
}
