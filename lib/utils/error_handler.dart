import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deadhour/utils/theme.dart';

/// Centralized error handling utility for the DeadHour app
class ErrorHandler {
  /// Show a user-friendly error message
  static void showError(
    BuildContext context, {
    String? title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
    bool isWarning = false,
  }) {
    final defaultTitle = isWarning ? 'Warning' : 'Something went wrong';
    final defaultMessage = isWarning
        ? 'Please check your input and try again.'
        : 'We encountered an unexpected error. Please try again.';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isWarning ? Icons.warning : Icons.error_outline,
              color: isWarning ? AppColors.warning : AppColors.error,
            ),
            const SizedBox(width: 12),
            Text(title ?? defaultTitle),
          ],
        ),
        content: Text(message ?? defaultMessage),
        actions: [
          if (onAction != null && actionLabel != null)
            TextButton(
              onPressed: onAction,
              child: Text(actionLabel),
            ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.moroccoGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Show a simple snackbar error
  static void showSnackBarError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.error,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  /// Show a success message
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Handle network errors specifically
  static void handleNetworkError(BuildContext context) {
    showError(
      context,
      title: 'Connection Error',
      message: 'Please check your internet connection and try again.',
      actionLabel: 'Retry',
      onAction: () => Navigator.of(context).pop(),
    );
  }

  /// Handle authentication errors
  static void handleAuthError(BuildContext context, {String? customMessage}) {
    showError(
      context,
      title: 'Authentication Required',
      message: customMessage ?? 'Please sign in to continue.',
      actionLabel: 'Sign In',
      onAction: () {
        Navigator.of(context).pop();
        // Navigate to profile/login
      },
    );
  }

  /// Handle permission errors
  static void handlePermissionError(BuildContext context, String permission) {
    showError(
      context,
      title: 'Permission Required',
      message: 'DeadHour needs $permission permission to provide this feature.',
      actionLabel: 'Open Settings',
      onAction: () {
        Navigator.of(context).pop();
        // Open app settings
      },
    );
  }

  /// Handle validation errors
  static void handleValidationError(BuildContext context, String field) {
    showError(
      context,
      title: 'Invalid Input',
      message: 'Please enter a valid $field.',
      isWarning: true,
    );
  }

  /// Safe execution wrapper
  static Future<T?> safeExecute<T>(
    Future<T> Function() operation, {
    required BuildContext context,
    String? errorMessage,
    bool showSnackBar = true,
  }) async {
    try {
      return await operation();
    } catch (e) {
      final message = errorMessage ?? 'Operation failed. Please try again.';

      if (showSnackBar) {
        showSnackBarError(context, message);
      } else {
        showError(context, message: message);
      }

      return null;
    }
  }

  /// Safe widget builder with error fallback
  static Widget safeBuild(
    Widget Function() builder, {
    Widget? fallback,
    String? errorMessage,
  }) {
    try {
      return builder();
    } catch (e) {
      return fallback ?? _buildErrorWidget(errorMessage);
    }
  }

  /// Default error widget
  static Widget _buildErrorWidget(String? message) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.error,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? 'Something went wrong',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  /// Vibrate for error feedback (if available)
  static void errorFeedback() {
    try {
      HapticFeedback.lightImpact();
    } catch (e) {
      // Ignore if haptic feedback not available
    }
  }

  /// Log error for debugging (in development)
  static void logError(String context, dynamic error,
      [StackTrace? stackTrace]) {
    // In development, print errors
    // In production, this would send to analytics/crash reporting
    debugPrint('Error in $context: $error');
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }
}

/// Error boundary widget for catching widget build errors
class ErrorBoundary extends StatelessWidget {
  final Widget child;
  final Widget? errorWidget;
  final String? errorMessage;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorWidget,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorHandler.safeBuild(
      () => child,
      fallback: errorWidget,
      errorMessage: errorMessage,
    );
  }
}
