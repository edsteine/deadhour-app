import 'auth_exception.dart';

class UnauthenticatedException extends AuthException {
  const UnauthenticatedException(super.message);
}