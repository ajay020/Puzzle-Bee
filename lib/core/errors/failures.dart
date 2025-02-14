class DatabaseFailure implements Exception {
  final String message;

  DatabaseFailure(this.message);

  @override
  String toString() => message;
}