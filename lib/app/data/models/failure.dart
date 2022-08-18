class Failure {
  final String title;
  final String message;

  const Failure({
    required this.title,
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}
