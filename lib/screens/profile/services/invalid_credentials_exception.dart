import 'auth_exception.dart';

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException(super.message);
}