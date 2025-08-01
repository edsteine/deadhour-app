import 'dart:async';

/// Biometric authentication service for enhanced security
/// Addresses critical missing biometric auth from TAB_ANALYSIS_REPORT.md
class BiometricAuthService {
  static final BiometricAuthService _instance = BiometricAuthService._internal();
  factory BiometricAuthService() => _instance;
  BiometricAuthService._internal();

  // Biometric availability and state
  final Map<String, BiometricCapability> _capabilities = {};
  final Map<String, bool> _enrollmentStatus = {};
  final Map<String, DateTime> _lastSuccessfulAuth = {};
  
  bool _isInitialized = false;
  Timer? _securityTimer;
  
  // Security settings
  final Duration _authValidityPeriod = const Duration(minutes: 15);
  final int _maxFailedAttempts = 3;
  final Map<String, int> _failedAttempts = {};

  /// Initialize biometric authentication system
  Future<void> initializeBiometricAuth() async {
    if (_isInitialized) return;
    
    await _detectBiometricCapabilities();
    await _checkEnrollmentStatus();
    _startSecurityMonitoring();
    _isInitialized = true;
  }

  /// Check if biometric authentication is available on device
  Future<BiometricAvailability> checkBiometricAvailability() async {
    final deviceCapabilities = await _getDeviceCapabilities();
    final hasEnrolledBiometrics = await _hasEnrolledBiometrics();
    
    return BiometricAvailability(
      isAvailable: deviceCapabilities.isNotEmpty,
      supportedTypes: deviceCapabilities,
      hasEnrolledBiometrics: hasEnrolledBiometrics,
      isDeviceSecure: await _isDeviceSecure(),
      recommendedMethod: _getRecommendedMethod(deviceCapabilities),
    );
  }

  /// Authenticate user with biometrics
  Future<BiometricAuthResult> authenticateWithBiometrics({
    required String reason,
    BiometricType? preferredType,
    bool allowFallback = true,
  }) async {
    // Check if authentication is needed
    if (_isRecentlyAuthenticated('biometric')) {
      return BiometricAuthResult(
        success: true,
        message: 'Recently authenticated - access granted',
        authMethod: BiometricAuthMethod.recentAuth,
        timestamp: DateTime.now(),
      );
    }

    // Check failed attempts
    if (_hasExceededFailedAttempts('biometric')) {
      return const BiometricAuthResult(
        success: false,
        message: 'Too many failed attempts. Please wait and try again.',
        errorType: BiometricErrorType.tooManyAttempts,
        lockoutDuration: Duration(minutes: 5),
      );
    }

    try {
      // Simulate biometric authentication
      final result = await _performBiometricAuth(reason, preferredType);
      
      if (result.success) {
        _recordSuccessfulAuth('biometric');
        _resetFailedAttempts('biometric');
      } else {
        _recordFailedAttempt('biometric');
      }
      
      return result;
    } catch (e) {
      _recordFailedAttempt('biometric');
      return BiometricAuthResult(
        success: false,
        message: 'Biometric authentication failed: ${e.toString()}',
        errorType: BiometricErrorType.authenticationFailed,
      );
    }
  }

  /// Enable biometric authentication for user account
  Future<BiometricSetupResult> enableBiometricAuth({
    required String userId,
    required BiometricType type,
    String? customReason,
  }) async {
    final availability = await checkBiometricAvailability();
    
    if (!availability.isAvailable) {
      return const BiometricSetupResult(
        success: false,
        message: 'Biometric authentication is not available on this device',
        errorType: BiometricSetupError.notAvailable,
      );
    }

    if (!availability.hasEnrolledBiometrics) {
      return const BiometricSetupResult(
        success: false,
        message: 'Please enroll your biometrics in device settings first',
        errorType: BiometricSetupError.notEnrolled,
        requiresEnrollment: true,
      );
    }

    // Test authentication before enabling
    final testAuth = await authenticateWithBiometrics(
      reason: customReason ?? 'Verify your identity to enable biometric login',
      preferredType: type,
    );

    if (!testAuth.success) {
      return const BiometricSetupResult(
        success: false,
        message: 'Biometric verification failed. Setup cancelled.',
        errorType: BiometricSetupError.verificationFailed,
      );
    }

    // Store biometric preference
    await _storeBiometricPreference(userId, type);
    
    return BiometricSetupResult(
      success: true,
      message: 'Biometric authentication enabled successfully',
      enabledType: type,
    );
  }

  /// Disable biometric authentication
  Future<bool> disableBiometricAuth(String userId) async {
    await _removeBiometricPreference(userId);
    _clearAuthHistory(userId);
    return true;
  }

  /// Get user's biometric preferences
  Future<BiometricPreferences> getBiometricPreferences(String userId) async {
    final prefs = await _getUserBiometricPrefs(userId);
    return prefs;
  }

  /// Update biometric preferences
  Future<void> updateBiometricPreferences({
    required String userId,
    required BiometricPreferences preferences,
  }) async {
    await _saveBiometricPreferences(userId, preferences);
  }

  /// Check if user has biometric authentication enabled
  Future<bool> isBiometricEnabled(String userId) async {
    final prefs = await getBiometricPreferences(userId);
    return prefs.isEnabled;
  }

  /// Get biometric security status
  BiometricSecurityStatus getSecurityStatus(String userId) {
    final lastAuth = _lastSuccessfulAuth[userId];
    final failedCount = _failedAttempts[userId] ?? 0;
    
    return BiometricSecurityStatus(
      isAuthValid: _isRecentlyAuthenticated(userId),
      lastAuthTime: lastAuth,
      failedAttempts: failedCount,
      isLocked: _hasExceededFailedAttempts(userId),
      nextAuthRequired: lastAuth?.add(_authValidityPeriod),
    );
  }

  /// Force re-authentication (e.g., for sensitive operations)
  Future<BiometricAuthResult> requireFreshAuthentication({
    required String reason,
    BiometricType? preferredType,
  }) async {
    // Clear recent auth to force fresh authentication
    _clearRecentAuth('biometric');
    
    return await authenticateWithBiometrics(
      reason: reason,
      preferredType: preferredType,
      allowFallback: false,
    );
  }

  Future<void> _detectBiometricCapabilities() async {
    // Simulate capability detection
    _capabilities['fingerprint'] = const BiometricCapability(
      type: BiometricType.fingerprint,
      isAvailable: true,
      quality: BiometricQuality.high,
      description: 'Fingerprint sensor',
    );
    
    _capabilities['face'] = const BiometricCapability(
      type: BiometricType.face,
      isAvailable: true,
      quality: BiometricQuality.medium,
      description: 'Face recognition',
    );
    
    _capabilities['voice'] = const BiometricCapability(
      type: BiometricType.voice,
      isAvailable: false,
      quality: BiometricQuality.low,
      description: 'Voice recognition (not available)',
    );
  }

  Future<void> _checkEnrollmentStatus() async {
    // Simulate enrollment status check
    _enrollmentStatus['fingerprint'] = true;
    _enrollmentStatus['face'] = true;
    _enrollmentStatus['voice'] = false;
  }

  Future<List<BiometricType>> _getDeviceCapabilities() async {
    final available = <BiometricType>[];
    
    for (final capability in _capabilities.values) {
      if (capability.isAvailable) {
        available.add(capability.type);
      }
    }
    
    return available;
  }

  Future<bool> _hasEnrolledBiometrics() async {
    return _enrollmentStatus.values.any((enrolled) => enrolled);
  }

  Future<bool> _isDeviceSecure() async {
    // Check if device has screen lock
    return true; // Simulate secure device
  }

  BiometricType? _getRecommendedMethod(List<BiometricType> available) {
    // Prefer fingerprint over face recognition for better security
    if (available.contains(BiometricType.fingerprint)) {
      return BiometricType.fingerprint;
    }
    if (available.contains(BiometricType.face)) {
      return BiometricType.face;
    }
    return available.isNotEmpty ? available.first : null;
  }

  Future<BiometricAuthResult> _performBiometricAuth(
    String reason, 
    BiometricType? preferredType,
  ) async {
    // Simulate authentication delay
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Simulate random success/failure for testing
    final success = DateTime.now().millisecond % 10 > 2; // 80% success rate
    
    if (success) {
      return BiometricAuthResult(
        success: true,
        message: 'Biometric authentication successful',
        authMethod: preferredType == BiometricType.fingerprint 
            ? BiometricAuthMethod.fingerprint 
            : BiometricAuthMethod.face,
        timestamp: DateTime.now(),
      );
    } else {
      return const BiometricAuthResult(
        success: false,
        message: 'Biometric authentication failed',
        errorType: BiometricErrorType.authenticationFailed,
      );
    }
  }

  void _recordSuccessfulAuth(String userId) {
    _lastSuccessfulAuth[userId] = DateTime.now();
  }

  void _recordFailedAttempt(String userId) {
    _failedAttempts[userId] = (_failedAttempts[userId] ?? 0) + 1;
  }

  void _resetFailedAttempts(String userId) {
    _failedAttempts[userId] = 0;
  }

  bool _isRecentlyAuthenticated(String userId) {
    final lastAuth = _lastSuccessfulAuth[userId];
    if (lastAuth == null) return false;
    
    return DateTime.now().difference(lastAuth) < _authValidityPeriod;
  }

  bool _hasExceededFailedAttempts(String userId) {
    return (_failedAttempts[userId] ?? 0) >= _maxFailedAttempts;
  }

  void _clearRecentAuth(String userId) {
    _lastSuccessfulAuth.remove(userId);
  }

  void _clearAuthHistory(String userId) {
    _lastSuccessfulAuth.remove(userId);
    _failedAttempts.remove(userId);
  }

  Future<void> _storeBiometricPreference(String userId, BiometricType type) async {
    // In real app, store in secure storage
    // For now, just simulate storage
  }

  Future<void> _removeBiometricPreference(String userId) async {
    // In real app, remove from secure storage
  }

  Future<BiometricPreferences> _getUserBiometricPrefs(String userId) async {
    // Simulate user preferences
    return const BiometricPreferences(
      isEnabled: true,
      preferredType: BiometricType.fingerprint,
      requireForLogin: true,
      requireForPayments: true,
      requireForSensitiveActions: true,
      fallbackToPassword: true,
      autoLockAfter: Duration(minutes: 15),
    );
  }

  Future<void> _saveBiometricPreferences(String userId, BiometricPreferences prefs) async {
    // In real app, save to secure storage
  }

  void _startSecurityMonitoring() {
    _securityTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _cleanupExpiredAuth();
    });
  }

  void _cleanupExpiredAuth() {
    final now = DateTime.now();
    final expiredUsers = <String>[];
    
    for (final entry in _lastSuccessfulAuth.entries) {
      if (now.difference(entry.value) > _authValidityPeriod) {
        expiredUsers.add(entry.key);
      }
    }
    
    for (final userId in expiredUsers) {
      _lastSuccessfulAuth.remove(userId);
    }
  }

  void dispose() {
    _securityTimer?.cancel();
  }
}

/// Biometric availability information
class BiometricAvailability {
  final bool isAvailable;
  final List<BiometricType> supportedTypes;
  final bool hasEnrolledBiometrics;
  final bool isDeviceSecure;
  final BiometricType? recommendedMethod;

  const BiometricAvailability({
    required this.isAvailable,
    required this.supportedTypes,
    required this.hasEnrolledBiometrics,
    required this.isDeviceSecure,
    this.recommendedMethod,
  });
}

/// Biometric capability information
class BiometricCapability {
  final BiometricType type;
  final bool isAvailable;
  final BiometricQuality quality;
  final String description;

  const BiometricCapability({
    required this.type,
    required this.isAvailable,
    required this.quality,
    required this.description,
  });
}

/// Biometric authentication result
class BiometricAuthResult {
  final bool success;
  final String message;
  final BiometricAuthMethod? authMethod;
  final DateTime? timestamp;
  final BiometricErrorType? errorType;
  final Duration? lockoutDuration;

  const BiometricAuthResult({
    required this.success,
    required this.message,
    this.authMethod,
    this.timestamp,
    this.errorType,
    this.lockoutDuration,
  });
}

/// Biometric setup result
class BiometricSetupResult {
  final bool success;
  final String message;
  final BiometricType? enabledType;
  final BiometricSetupError? errorType;
  final bool requiresEnrollment;

  const BiometricSetupResult({
    required this.success,
    required this.message,
    this.enabledType,
    this.errorType,
    this.requiresEnrollment = false,
  });
}

/// User biometric preferences
class BiometricPreferences {
  final bool isEnabled;
  final BiometricType? preferredType;
  final bool requireForLogin;
  final bool requireForPayments;
  final bool requireForSensitiveActions;
  final bool fallbackToPassword;
  final Duration autoLockAfter;

  const BiometricPreferences({
    required this.isEnabled,
    this.preferredType,
    required this.requireForLogin,
    required this.requireForPayments,
    required this.requireForSensitiveActions,
    required this.fallbackToPassword,
    required this.autoLockAfter,
  });

  BiometricPreferences copyWith({
    bool? isEnabled,
    BiometricType? preferredType,
    bool? requireForLogin,
    bool? requireForPayments,
    bool? requireForSensitiveActions,
    bool? fallbackToPassword,
    Duration? autoLockAfter,
  }) {
    return BiometricPreferences(
      isEnabled: isEnabled ?? this.isEnabled,
      preferredType: preferredType ?? this.preferredType,
      requireForLogin: requireForLogin ?? this.requireForLogin,
      requireForPayments: requireForPayments ?? this.requireForPayments,
      requireForSensitiveActions: requireForSensitiveActions ?? this.requireForSensitiveActions,
      fallbackToPassword: fallbackToPassword ?? this.fallbackToPassword,
      autoLockAfter: autoLockAfter ?? this.autoLockAfter,
    );
  }
}

/// Biometric security status
class BiometricSecurityStatus {
  final bool isAuthValid;
  final DateTime? lastAuthTime;
  final int failedAttempts;
  final bool isLocked;
  final DateTime? nextAuthRequired;

  const BiometricSecurityStatus({
    required this.isAuthValid,
    this.lastAuthTime,
    required this.failedAttempts,
    required this.isLocked,
    this.nextAuthRequired,
  });
}

/// Enums
enum BiometricType {
  fingerprint,
  face,
  voice,
  iris,
}

enum BiometricQuality {
  low,
  medium,
  high,
}

enum BiometricAuthMethod {
  fingerprint,
  face,
  voice,
  iris,
  recentAuth,
  fallback,
}

enum BiometricErrorType {
  authenticationFailed,
  tooManyAttempts,
  biometricNotAvailable,
  biometricNotEnrolled,
  deviceNotSecure,
  permissionDenied,
  cancelled,
}

enum BiometricSetupError {
  notAvailable,
  notEnrolled,
  verificationFailed,
  permissionDenied,
  deviceNotSecure,
}