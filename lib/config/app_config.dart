/// Build-time configuration (`--dart-define`).
class AppConfig {
  AppConfig._();

  /// Default backend base for staff API calls (auth gateway or future BFF).
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000',
  );
}
