import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:deadhour/models/user.dart';
import 'package:deadhour/utils/performance_utils.dart';
import 'package:deadhour/utils/guest_mode.dart';
import 'package:deadhour/services/auth/auth_exceptions.dart';
import 'package:deadhour/services/auth/auth_validation.dart';
import 'package:deadhour/services/auth/auth_helpers.dart';
import 'package:deadhour/services/auth/auth_storage.dart';
import 'package:deadhour/services/auth/social_provider.dart';

// Authentication Service for DeadHour App
// Handles multi-role account system and authentication flow
class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Authentication state
  DeadHourUser? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _authToken;
  Timer? _tokenRefreshTimer;

  // Getters
  DeadHourUser? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get authToken => _authToken;

  // Multi-role system helpers
  bool get hasConsumerRole =>
      _currentUser?.activeRoles.contains(UserRole.consumer) ?? false;
  bool get hasBusinessRole =>
      _currentUser?.activeRoles.contains(UserRole.business) ?? false;
  bool get hasGuideRole =>
      _currentUser?.activeRoles.contains(UserRole.guide) ?? false;
  bool get hasPremiumRole =>
      _currentUser?.activeRoles.contains(UserRole.premium) ?? false;

  // Guest mode helpers
  bool get isGuestMode => GuestMode.isGuest;
  bool get canAccessFeature => _isAuthenticated || GuestMode.isGuest;

  // Initialize authentication service
  Future<void> initialize() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Initialize guest mode
      await GuestMode.initialize();

      // Check for stored authentication token
      await AuthStorage.checkStoredAuth();

      // Validate token if exists
      if (_authToken != null) {
        await AuthStorage.validateToken();
      }
    } catch (error) {
      debugPrint('Auth initialization error: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Email/Password Login
  Future<DeadHourUser> loginWithEmail({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await PerformanceUtils.simulateNetworkDelay();

      // Validate input
      AuthValidation.validateEmailInput(email);
      AuthValidation.validatePasswordInput(password);

      // Simulate authentication API call
      await Future.delayed(const Duration(milliseconds: 1500));

      // Mock successful authentication
      final user = AuthHelpers.createMockUser(email);
      await _setAuthenticatedUser(user, rememberMe);

      return user;
    } catch (error) {
      if (error is AuthException) rethrow;

      // Handle different error types
      if (error.toString().contains('network')) {
        throw const NetworkException(
            'Unable to connect. Please check your internet connection.');
      } else if (error.toString().contains('credentials')) {
        throw const InvalidCredentialsException(
            'Invalid email or password. Please try again.');
      } else {
        throw AuthException('Login failed: ${error.toString()}');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Phone Number Login
  Future<DeadHourUser> loginWithPhone({
    required String phoneNumber,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await PerformanceUtils.simulateNetworkDelay();

      // Validate Moroccan phone number
      AuthValidation.validateMoroccanPhoneNumber(phoneNumber);

      // Simulate authentication
      await Future.delayed(const Duration(milliseconds: 1500));

      final user = AuthHelpers.createMockUser(phoneNumber);
      await _setAuthenticatedUser(user, rememberMe);

      return user;
    } catch (error) {
      if (error is AuthException) rethrow;
      throw AuthException('Phone login failed: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Social Login (Google, Facebook)
  Future<DeadHourUser> loginWithSocial({
    required SocialProvider provider,
    bool rememberMe = false,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await PerformanceUtils.simulateNetworkDelay();

      // Simulate social authentication flow
      await Future.delayed(const Duration(milliseconds: 2000));

      final email = 'user@${provider.name.toLowerCase()}.com';
      final user = AuthHelpers.createMockUser(email);

      await _setAuthenticatedUser(user, rememberMe);

      return user;
    } catch (error) {
      if (error is AuthException) rethrow;
      throw AuthException('${provider.name} login failed: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Registration
  Future<DeadHourUser> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String city,
    required String language,
    required String userType,
    String? businessName,
    String? businessCategory,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await PerformanceUtils.simulateNetworkDelay();

      // Validate registration data
      AuthValidation.validateRegistrationInput(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        userType: userType,
        businessName: businessName,
        businessCategory: businessCategory,
      );

      // Simulate registration API call
      await Future.delayed(const Duration(milliseconds: 2000));

      // Create user with appropriate roles based on user type
      final user = DeadHourUser(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: fullName,
        phone: phoneNumber,
        city: city,
        preferredLanguage: language,
        profileImageUrl: 'https://i.pravatar.cc/150?u=$email',
        activeRoles: AuthHelpers.determineUserRoles(userType),
        joinDate: DateTime.now(),
      );

      await _setAuthenticatedUser(user, true);

      // Send verification email (mock)
      await AuthStorage.sendVerificationEmail(user);

      return user;
    } catch (error) {
      if (error is AuthException) rethrow;
      throw AuthException('Registration failed: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add Role to User Account
  Future<void> addRole(UserRole role) async {
    if (_currentUser == null) {
      throw const UnauthenticatedException('Please log in to add roles');
    }

    try {
      _isLoading = true;
      notifyListeners();

      await PerformanceUtils.simulateNetworkDelay();

      // Simulate role addition API call
      await Future.delayed(const Duration(milliseconds: 1000));

      _currentUser = _currentUser!.addRole(role);
      await AuthStorage.saveUserData(_currentUser!);

      notifyListeners();
    } catch (error) {
      throw AuthException('Failed to add role: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Switch Active Role
  void switchActiveRole(UserRole role) {
    if (_currentUser == null || !_currentUser!.activeRoles.contains(role)) {
      throw const InvalidInputException('User does not have this role');
    }

    // Create a new user instance with the updated active roles
    final updatedRoles = Set<UserRole>.from(_currentUser!.activeRoles);
    _currentUser = _currentUser!.copyWith(activeRoles: updatedRoles);
    notifyListeners();
  }

  // Enable Guest Mode
  Future<void> enableGuestMode() async {
    try {
      _isLoading = true;
      notifyListeners();

      await GuestMode.enableGuestMode();

      notifyListeners();
    } catch (error) {
      throw AuthException('Failed to enable guest mode: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Convert Guest to Registered User
  Future<DeadHourUser> convertGuestToUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String city,
    required String language,
    required String userType,
    String? businessName,
    String? businessCategory,
  }) async {
    if (!GuestMode.isGuest) {
      throw const InvalidInputException('User is not in guest mode');
    }

    try {
      // Register normally
      final user = await register(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        city: city,
        language: language,
        userType: userType,
        businessName: businessName,
        businessCategory: businessCategory,
      );

      // Disable guest mode
      await GuestMode.disableGuestMode();

      return user;
    } catch (error) {
      throw AuthException(
          'Failed to convert guest account: ${error.toString()}');
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Cancel token refresh timer
      _tokenRefreshTimer?.cancel();

      // Clear authentication data
      await AuthStorage.clearAuthData();

      // Clear guest mode if active
      if (GuestMode.isGuest) {
        await GuestMode.clearGuestData();
      }

      _currentUser = null;
      _isAuthenticated = false;
      _authToken = null;

      notifyListeners();
    } catch (error) {
      throw AuthException('Logout failed: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      _isLoading = true;
      notifyListeners();

      await PerformanceUtils.simulateNetworkDelay();

      AuthValidation.validateEmailInput(email);

      // Simulate password reset API call
      await Future.delayed(const Duration(milliseconds: 1500));

      // Mock success - in real app, this would trigger email
    } catch (error) {
      if (error is AuthException) rethrow;
      throw AuthException('Password reset failed: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update Profile
  Future<void> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? city,
    String? profilePicture,
  }) async {
    if (_currentUser == null) {
      throw const UnauthenticatedException('Please log in to update profile');
    }

    try {
      _isLoading = true;
      notifyListeners();

      await PerformanceUtils.simulateNetworkDelay();

      // Update user data using copyWith
      _currentUser = _currentUser!.copyWith(
        name: fullName,
        phone: phoneNumber,
        city: city,
        profileImageUrl: profilePicture,
      );

      // Simulate API update
      await Future.delayed(const Duration(milliseconds: 1000));

      await AuthStorage.saveUserData(_currentUser!);
      notifyListeners();
    } catch (error) {
      throw AuthException('Profile update failed: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Verify Email
  Future<void> verifyEmail(String verificationCode) async {
    if (_currentUser == null) {
      throw const UnauthenticatedException('Please log in to verify email');
    }

    try {
      _isLoading = true;
      notifyListeners();

      await PerformanceUtils.simulateNetworkDelay();

      // Simulate verification
      await Future.delayed(const Duration(milliseconds: 1000));

      _currentUser = _currentUser!.copyWith(isVerified: true);
      await AuthStorage.saveUserData(_currentUser!);
      notifyListeners();
    } catch (error) {
      throw AuthException('Email verification failed: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Private helper methods
  Future<void> _setAuthenticatedUser(DeadHourUser user, bool rememberMe) async {
    _currentUser = user;
    _isAuthenticated = true;
    _authToken = AuthHelpers.generateAuthToken(user.id);

    // Save authentication data
    if (rememberMe) {
      await AuthStorage.saveAuthData(user, _authToken!);
    }

    // Start token refresh timer
    _startTokenRefreshTimer();

    notifyListeners();
  }

  void _startTokenRefreshTimer() {
    _tokenRefreshTimer?.cancel();
    _tokenRefreshTimer = Timer.periodic(
      const Duration(hours: 1),
      (timer) async {
        try {
          await _refreshToken();
        } catch (error) {
          // If refresh fails, logout user
          await logout();
        }
      },
    );
  }

  Future<void> _refreshToken() async {
    // In real app, refresh authentication token
    await Future.delayed(const Duration(milliseconds: 500));
    _authToken = AuthHelpers.generateRefreshToken();
  }

  @override
  void dispose() {
    _tokenRefreshTimer?.cancel();
    super.dispose();
  }
}