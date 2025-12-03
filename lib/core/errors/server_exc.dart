class ServerExc implements Exception {
  final String message;

  ServerExc({required this.message});
    @override
  String toString() => message;
}
