class ResponseStatus {
  final String message;
  final bool hasError;
  final Map <String,dynamic>? extra;

  ResponseStatus({
    required this.message,
    required this.hasError,
    this.extra
  });
}
