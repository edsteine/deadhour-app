import 'package:deadhour/services/auth/auth_exceptions.dart';

class AuthValidation {
  static void validateRegistrationInput({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String userType,
    String? businessName,
    String? businessCategory,
  }) {
    if (fullName.trim().isEmpty) {
      throw const InvalidInputException('Please enter your full name');
    }

    if (!email.contains('@')) {
      throw const InvalidInputException('Please enter a valid email address');
    }

    if (!RegExp(r'^\+212[5-7][0-9]{8}$').hasMatch(phoneNumber)) {
      throw const InvalidInputException(
          'Please enter a valid Moroccan phone number');
    }

    if (password.length < 6) {
      throw const InvalidInputException(
          'Password must be at least 6 characters');
    }

    if (userType == 'business') {
      if (businessName == null || businessName.trim().isEmpty) {
        throw const InvalidInputException('Please enter your business name');
      }
      if (businessCategory == null || businessCategory.trim().isEmpty) {
        throw const InvalidInputException(
            'Please select your business category');
      }
    }
  }

  static void validateEmailInput(String email) {
    if (email.isEmpty || !email.contains('@')) {
      throw const InvalidInputException('Please enter a valid email address');
    }
  }

  static void validatePasswordInput(String password) {
    if (password.length < 6) {
      throw const InvalidInputException(
          'Password must be at least 6 characters');
    }
  }

  static void validateMoroccanPhoneNumber(String phoneNumber) {
    if (!RegExp(r'^\+212[5-7][0-9]{8}$').hasMatch(phoneNumber)) {
      throw const InvalidInputException(
          'Please enter a valid Moroccan phone number (+212...)');
    }
  }
}