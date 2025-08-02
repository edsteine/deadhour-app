import 'package:deadhour/models/user.dart';

class AuthStorage {
  static Future<void> checkStoredAuth() async {
    // In real app, check secure storage for auth token
    await Future.delayed(const Duration(milliseconds: 500));
  }

  static Future<void> validateToken() async {
    // In real app, validate token with backend
    await Future.delayed(const Duration(milliseconds: 300));
  }

  static Future<void> saveAuthData(DeadHourUser user, String token) async {
    // In real app, save to secure storage
    await Future.delayed(const Duration(milliseconds: 200));
  }

  static Future<void> saveUserData(DeadHourUser user) async {
    // In real app, save user data to secure storage
    await Future.delayed(const Duration(milliseconds: 200));
  }

  static Future<void> clearAuthData() async {
    // In real app, clear from secure storage
    await Future.delayed(const Duration(milliseconds: 200));
  }

  static Future<void> sendVerificationEmail(DeadHourUser user) async {
    // In real app, trigger verification email
    await Future.delayed(const Duration(milliseconds: 500));
  }
}