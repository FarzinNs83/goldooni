class Failure {
  final String message;
  Failure([this.message = "An Unexpected Error Has Occured"]);
    @override
  String toString() => message;
}
