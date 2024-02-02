class ResponseStatus {
  final String message;
  final bool hasError;
  final Object? extra;

  ResponseStatus({
    required this.message,
    required this.hasError,
    this.extra
  });
}
