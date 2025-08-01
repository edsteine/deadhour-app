
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for guest mode state management
class GuestModeNotifier extends StateNotifier<bool> {
  GuestModeNotifier() : super(false) {
    _initialize();
  }

  Future<void> _initialize() async {
    await GuestMode.initialize();
    state = GuestMode.isGuest;
  }

  /// Enable guest mode
  Future<void> enableGuestMode() async {
    await GuestMode.enableGuestMode();
    state = true;
  }

  /// Disable guest mode (when user logs in or registers)
  Future<void> disableGuestMode() async {
    await GuestMode.disableGuestMode();
    state = false;
  }

  /// Get guest session ID
  String? get guestSessionId => GuestMode.guestSessionId;

  /// Check if user has seen onboarding
  bool get hasSeenOnboarding => GuestMode.hasSeenOnboarding;

  /// Mark onboarding as completed
  Future<void> markOnboardingCompleted() async {
    await GuestMode.markOnboardingCompleted();
  }
}

/// Provider instance
final guestModeProvider = StateNotifierProvider<GuestModeNotifier, bool>((ref) {
  return GuestModeNotifier();
});

/// Convenience provider for checking if user is in guest mode
final isGuestProvider = Provider<bool>((ref) {
  return ref.watch(guestModeProvider);
});
