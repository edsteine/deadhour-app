import 'package:shared_preferences/shared_preferences.dart';

class GuestMode {
  static const String _isGuestKey = 'is_guest_mode';
  static const String _guestSessionIdKey = 'guest_session_id';
  static const String _hasSeenOnboardingKey = 'has_seen_onboarding';

  static bool _isGuest = false;
  static String? _guestSessionId;
  static bool _hasSeenOnboarding = false;

  /// Check if the user is currently in guest mode
  static bool get isGuest => _isGuest;

  /// Get the guest session ID
  static String? get guestSessionId => _guestSessionId;

  /// Check if user has seen onboarding before
  static bool get hasSeenOnboarding => _hasSeenOnboarding;

  /// Initialize guest mode state from storage
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _isGuest = prefs.getBool(_isGuestKey) ?? false;
    _guestSessionId = prefs.getString(_guestSessionIdKey);
    _hasSeenOnboarding = prefs.getBool(_hasSeenOnboardingKey) ?? false;
  }

  /// Enable guest mode
  static Future<void> enableGuestMode() async {
    final prefs = await SharedPreferences.getInstance();
    _isGuest = true;
    _guestSessionId = DateTime.now().millisecondsSinceEpoch.toString();

    await prefs.setBool(_isGuestKey, true);
    await prefs.setString(_guestSessionIdKey, _guestSessionId!);
  }

  /// Disable guest mode (when user registers or logs in)
  static Future<void> disableGuestMode() async {
    final prefs = await SharedPreferences.getInstance();
    _isGuest = false;
    _guestSessionId = null;

    await prefs.remove(_isGuestKey);
    await prefs.remove(_guestSessionIdKey);
  }

  /// Mark onboarding as completed
  static Future<void> markOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    _hasSeenOnboarding = true;
    await prefs.setBool(_hasSeenOnboardingKey, true);
  }

  /// Clear all guest data
  static Future<void> clearGuestData() async {
    // Remove any guest-specific data here
    await disableGuestMode();
  }
}
