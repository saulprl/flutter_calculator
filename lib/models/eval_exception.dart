class EvalException implements Exception {
  final String message;

  EvalException(this.message);

  @override
  String toString() {
    return message;
  }
}
