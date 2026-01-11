abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('Please check your internet connection');
}

class ServerFailure extends Failure {
  const ServerFailure() : super('Something went wrong. Try again later');
}

class BusinessFailure extends Failure {
  const BusinessFailure(super.msg);
}
