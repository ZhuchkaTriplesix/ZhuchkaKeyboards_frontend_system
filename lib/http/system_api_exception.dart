/// Error from a staff-console HTTP API (JSON body or network failure).
class SystemApiException implements Exception {
  SystemApiException(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  String toString() => 'SystemApiException($statusCode): $message';
}
