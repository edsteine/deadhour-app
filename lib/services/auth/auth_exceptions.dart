// Custom exceptions for authentication
class AuthException implements Exception {
  const AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException(super.message);
}

class InvalidInputException extends AuthException {
  const InvalidInputException(super.message);
}

class UnauthenticatedException extends AuthException {
  const UnauthenticatedException(super.message);
}

class NetworkException extends AuthException {
  const NetworkException(super.message);
}