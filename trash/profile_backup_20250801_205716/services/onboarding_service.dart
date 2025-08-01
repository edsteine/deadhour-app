import 'auth_service.dart';
import '../models/user.dart';
import '../../../utils/app_performance_service.dart';
import 'package:flutter/foundation.dart';
import 'guest_mode.dart';
import 'onboarding_step.dart';


// Onboarding Service for DeadHour App
// Manages seamless transition from guest mode to authenticated user
class OnboardingService extends ChangeNotifier {
  static final OnboardingService _instance = OnboardingService._internal();
  factory OnboardingService() => _instance;
  OnboardingService._internal();

  bool _isInitialized = false;
  bool _showOnboarding = true;
  OnboardingStep _currentStep = OnboardingStep.welcome;
  final Map<String, dynamic> _guestActivity = {};

  // Getters
  bool get isInitialized => _isInitialized;
  bool get showOnboarding => _showOnboarding;
  OnboardingStep get currentStep => _currentStep;
  bool get isGuestMode => GuestMode.isGuest;
  bool get hasGuestActivity => _guestActivity.isNotEmpty;

  // Initialize onboarding service
  Future<void> initialize() async {
    try {
      // Check if user has completed onboarding before
      _showOnboarding = await _shouldShowOnboarding();

      // Initialize guest activity tracking
      await _initializeGuestTracking();

      _isInitialized = true;
      notifyListeners();
    } catch (error) {
      debugPrint('Onboarding service initialization error: $error');
    }
  }

  // Start guest mode experience
  Future<void> startGuestExperience() async {
    try {
      await AuthService().enableGuestMode();
      await _trackOnboardingProgress('guest_mode_started');
      notifyListeners();
    } catch (error) {
      debugPrint('Failed to start guest experience: $error');
    }
  }

  // Track guest activity for conversion incentives
  void trackGuestActivity(String action, Map<String, dynamic> data) {
    if (!GuestMode.isGuest) return;

    _guestActivity[action] = {
      ...data,
      'timestamp': DateTime.now().toIso8601String(),
    };

    // Cache activity for performance
    AppPerformanceService().cacheData('guest_activity', _guestActivity);

    notifyListeners();
  }

  // Convert guest to registered user with preserved activity
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
    try {
      // Track conversion attempt
      trackGuestActivity('conversion_attempted', {
        'user_type': userType,
        'city': city,
        'language': language,
      });

      // Convert through auth service
      final user = await AuthService().convertGuestToUser(
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

      // Transfer guest activity to user profile
      await _transferGuestActivity(user);

      // Mark onboarding as completed
      await _completeOnboarding();

      return user;
    } catch (error) {
      trackGuestActivity('conversion_failed', {
        'error': error.toString(),
      });
      rethrow;
    }
  }

  // Skip to next onboarding step
  void nextStep() {
    final steps = OnboardingStep.values;
    final currentIndex = steps.indexOf(_currentStep);

    if (currentIndex < steps.length - 1) {
      _currentStep = steps[currentIndex + 1];
      notifyListeners();
    }
  }

  // Skip to previous onboarding step
  void previousStep() {
    final steps = OnboardingStep.values;
    final currentIndex = steps.indexOf(_currentStep);

    if (currentIndex > 0) {
      _currentStep = steps[currentIndex - 1];
      notifyListeners();
    }
  }

  // Skip onboarding entirely
  Future<void> skipOnboarding() async {
    await _completeOnboarding();
    await startGuestExperience();
  }

  // Complete onboarding flow
  Future<void> completeOnboarding() async {
    await _completeOnboarding();
  }

  // Get guest activity summary for conversion incentives
  Map<String, dynamic> getGuestActivitySummary() {
    if (_guestActivity.isEmpty) return {};

    final summary = <String, dynamic>{};

    // Count different activity types
    int dealsViewed = 0;
    int roomsVisited = 0;
    int searchesPerformed = 0;

    for (final entry in _guestActivity.entries) {
      switch (entry.key) {
        case 'deal_viewed':
        case 'deal_saved':
        case 'deal_shared':
          dealsViewed++;
          break;
        case 'room_visited':
        case 'room_engaged':
          roomsVisited++;
          break;
        case 'search_performed':
        case 'filter_applied':
          searchesPerformed++;
          break;
      }
    }

    summary['total_activity'] = _guestActivity.length;
    summary['deals_viewed'] = dealsViewed;
    summary['rooms_visited'] = roomsVisited;
    summary['searches_performed'] = searchesPerformed;
    summary['session_start'] = _getEarliestActivity();
    summary['most_active_category'] = _getMostActiveCategory();

    return summary;
  }

  // Get personalized conversion message based on guest activity
  String getConversionMessage() {
    final summary = getGuestActivitySummary();

    if (summary.isEmpty) {
      return 'Join DeadHour to unlock exclusive deals and connect with the community!';
    }

    final dealsViewed = summary['deals_viewed'] ?? 0;
    final roomsVisited = summary['rooms_visited'] ?? 0;

    if (dealsViewed > 3) {
      return 'You\'ve viewed $dealsViewed deals! Sign up to save favorites and get personalized recommendations.';
    } else if (roomsVisited > 2) {
      return 'You\'ve explored $roomsVisited community rooms! Join to participate in discussions and get insider tips.';
    } else {
      return 'Ready to discover Morocco\'s best hidden deals? Create your account to get started!';
    }
  }

  // Reset onboarding state
  Future<void> resetOnboarding() async {
    _showOnboarding = true;
    _currentStep = OnboardingStep.welcome;
    _guestActivity.clear();
    await _saveOnboardingState();
    notifyListeners();
  }

  // Private helper methods
  Future<bool> _shouldShowOnboarding() async {
    // In real app, check shared preferences or secure storage
    await Future.delayed(const Duration(milliseconds: 100));
    return true; // Default to showing onboarding for new users
  }

  Future<void> _initializeGuestTracking() async {
    // Initialize guest activity tracking
    final cachedActivity = AppPerformanceService()
        .getCachedData<Map<String, dynamic>>('guest_activity');
    if (cachedActivity != null) {
      _guestActivity.addAll(cachedActivity);
    }
  }

  Future<void> _trackOnboardingProgress(String milestone) async {
    // Track onboarding completion for analytics
    await Future.delayed(const Duration(milliseconds: 100));
    debugPrint('Onboarding milestone: $milestone');
  }

  Future<void> _transferGuestActivity(DeadHourUser user) async {
    // In real app, transfer guest activity to user profile
    await Future.delayed(const Duration(milliseconds: 500));

    // Clear guest activity cache
    _guestActivity.clear();
    AppPerformanceService().cacheData('guest_activity', {});

    debugPrint('Transferred guest activity to user: ${user.id}');
  }

  Future<void> _completeOnboarding() async {
    _showOnboarding = false;
    await _saveOnboardingState();
    await _trackOnboardingProgress('onboarding_completed');
    notifyListeners();
  }

  Future<void> _saveOnboardingState() async {
    // In real app, save to shared preferences
    await Future.delayed(const Duration(milliseconds: 100));
  }

  String? _getEarliestActivity() {
    if (_guestActivity.isEmpty) return null;

    DateTime? earliest;
    for (final activity in _guestActivity.values) {
      final timestamp = DateTime.tryParse(activity['timestamp'] ?? '');
      if (timestamp != null &&
          (earliest == null || timestamp.isBefore(earliest))) {
        earliest = timestamp;
      }
    }

    return earliest?.toIso8601String();
  }

  String? _getMostActiveCategory() {
    if (_guestActivity.isEmpty) return null;

    final categoryCount = <String, int>{};

    for (final entry in _guestActivity.entries) {
      final activity = entry.value as Map<String, dynamic>;
      final category = activity['category'] as String?;
      if (category != null) {
        categoryCount[category] = (categoryCount[category] ?? 0) + 1;
      }
    }

    if (categoryCount.isEmpty) return null;

    return categoryCount.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }
}
