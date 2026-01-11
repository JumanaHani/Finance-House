abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

class NetworkException extends AppException {
  const NetworkException() : super('No internet connection');
}

class ServerException extends AppException {
  const ServerException() : super('Server error occurred');
}

class NotFoundException extends AppException {
  const NotFoundException(String msg) : super(msg);
}
