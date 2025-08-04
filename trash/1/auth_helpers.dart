import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/theme.dart';
import '../providers/guest_mode_provider.dart';
import '../providers/role_toggle_provider.dart';

/// Helper class for handling authentication requirements throughout the app
class AuthHelpers {
  /// Check if user is authenticated and show login prompt if not
  /// Returns true if authenticated, false if guest/not logged in
  static bool requireAuth(
    BuildContext context,
    WidgetRef ref, {
    String? feature,
    String? message,
    bool showSnackBar = true,
  }) {
    final isGuest = ref.read(guestModeProvider);
    final isLoggedIn = ref.read(roleToggleProvider.notifier).isLoggedIn;

    // If user is authenticated, allow action
    if (!isGuest && isLoggedIn) {
      return true;
    }

    // Show authentication prompt
    _showAuthPrompt(context,
        feature: feature, message: message, showSnackBar: showSnackBar);
    return false;
  }

  /// Show authentication prompt dialog or navigate to profile
  static void _showAuthPrompt(
    BuildContext context, {
    String? feature,
    String? message,
    bool showSnackBar = true,
  }) {
    final defaultMessage = feature != null
        ? 'Please sign in to $feature'
        : 'Please sign in to continue';

    final displayMessage = message ?? defaultMessage;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.login, color: AppTheme.moroccoGreen),
            SizedBox(width: 12),
            Text('Sign In Required'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(displayMessage),
            const SizedBox(height: 16),
            const Text(
              'You can continue exploring as a guest or sign in to unlock all features.',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.secondaryText,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Continue as Guest'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/profile');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.moroccoGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }

  /// Quick method for booking features
  static bool requireAuthForBooking(BuildContext context, WidgetRef ref) {
    return requireAuth(
      context,
      ref,
      feature: 'book deals and venues',
      message:
          'Sign in to book deals, save favorites, and track your activity.',
    );
  }

  /// Quick method for community features
  static bool requireAuthForCommunity(BuildContext context, WidgetRef ref) {
    return requireAuth(
      context,
      ref,
      feature: 'join community discussions',
      message: 'Sign in to post messages, join rooms, and connect with others.',
    );
  }

  /// Quick method for business features
  static bool requireAuthForBusiness(BuildContext context, WidgetRef ref) {
    return requireAuth(
      context,
      ref,
      feature: 'access business features',
      message:
          'Sign in with a Business role to create deals and manage your venue.',
    );
  }

  /// Quick method for creating content
  static bool requireAuthForCreating(BuildContext context, WidgetRef ref,
      {String? contentType}) {
    final type = contentType ?? 'content';
    return requireAuth(
      context,
      ref,
      feature: 'create $type',
      message: 'Sign in to create and share $type with the community.',
    );
  }

  /// Show a simple snackbar for auth requirement (less intrusive)
  static void showAuthSnackBar(BuildContext context, {String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message ?? 'Sign in to access this feature'),
            ),
          ],
        ),
        backgroundColor: AppTheme.moroccoGreen,
        action: SnackBarAction(
          label: 'Sign In',
          textColor: Colors.white,
          onPressed: () => context.go('/profile'),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
