import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_error.dart';
import 'error_type.dart';
import 'theme.dart';
import 'timeout_exception.dart';

/// Comprehensive Error Handling for DeadHour App
class AppErrorHandler {
  /// Error model
  static AppError parseError(dynamic error) {
    if (error is SocketException) {
      return AppError(
        type: ErrorType.network,
        message: 'No internet connection. Please check your network.',
        userMessage: 'Check your internet connection',
        canRetry: true,
      );
    }

    if (error is TimeoutException) {
      return AppError(
        type: ErrorType.timeout,
        message: 'Request timed out. The server is taking too long to respond.',
        userMessage: 'Request timed out. Try again.',
        canRetry: true,
      );
    }

    if (error is PlatformException) {
      return _handlePlatformException(error);
    }

    if (error is HttpException) {
      return _handleHttpException(error);
    }

    // Default unknown error
    return AppError(
      type: ErrorType.unknown,
      message: error?.toString() ?? 'An unexpected error occurred',
      userMessage: 'Something went wrong. Please try again.',
      canRetry: true,
    );
  }

  static AppError _handlePlatformException(PlatformException error) {
    switch (error.code) {
      case 'location_permission_denied':
        return AppError(
          type: ErrorType.permission,
          message: 'Location permission denied',
          userMessage: 'Location access is needed to find nearby venues',
          canRetry: false,
          actionText: 'Settings',
        );
      case 'camera_permission_denied':
        return AppError(
          type: ErrorType.permission,
          message: 'Camera permission denied',
          userMessage: 'Camera access is needed to share photos',
          canRetry: false,
          actionText: 'Settings',
        );
      case 'notification_permission_denied':
        return AppError(
          type: ErrorType.permission,
          message: 'Notification permission denied',
          userMessage: 'Enable notifications to get deal alerts',
          canRetry: false,
          actionText: 'Settings',
        );
      default:
        return AppError(
          type: ErrorType.unknown,
          message: error.message ?? 'Platform error occurred',
          userMessage: 'A system error occurred. Please try again.',
          canRetry: true,
        );
    }
  }

  static AppError _handleHttpException(HttpException error) {
    final statusCode = error.uri?.queryParameters['status'];

    switch (statusCode) {
      case '401':
        return AppError(
          type: ErrorType.authentication,
          message: 'Authentication failed',
          userMessage: 'Please log in again',
          canRetry: false,
          actionText: 'Login',
        );
      case '403':
        return AppError(
          type: ErrorType.authentication,
          message: 'Access forbidden',
          userMessage: 'You don\'t have permission to access this',
          canRetry: false,
        );
      case '404':
        return AppError(
          type: ErrorType.server,
          message: 'Resource not found',
          userMessage: 'The requested content is not available',
          canRetry: false,
        );
      case '429':
        return AppError(
          type: ErrorType.server,
          message: 'Too many requests',
          userMessage: 'Please wait a moment before trying again',
          canRetry: true,
        );
      case '500':
        return AppError(
          type: ErrorType.server,
          message: 'Server error',
          userMessage: 'Our servers are having issues. Please try again later.',
          canRetry: true,
        );
      default:
        return AppError(
          type: ErrorType.server,
          message: 'HTTP error: ${error.message}',
          userMessage: 'Something went wrong. Please try again.',
          canRetry: true,
        );
    }
  }

  /// Show error dialog
  static void showErrorDialog(
    BuildContext context,
    AppError error, {
    VoidCallback? onRetry,
    VoidCallback? onAction,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          _getErrorIcon(error.type),
          color: _getErrorColor(error.type),
          size: 48,
        ),
        title: Text(_getErrorTitle(error.type)),
        content: Text(error.userMessage),
        actions: [
          if (error.canRetry && onRetry != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onRetry();
              },
              child: const Text('Try Again'),
            ),
          if (error.actionText != null)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (onAction != null) {
                  onAction();
                } else {
                  _handleDefaultAction(context, error.type);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.moroccoGreen,
                foregroundColor: Colors.white,
              ),
              child: Text(error.actionText!),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Show error snackbar
  static void showErrorSnackbar(
    BuildContext context,
    AppError error, {
    VoidCallback? onRetry,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _getErrorIcon(error.type),
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(error.userMessage)),
          ],
        ),
        backgroundColor: _getErrorColor(error.type),
        action: error.canRetry && onRetry != null
            ? SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: onRetry,
              )
            : null,
        duration: Duration(seconds: error.canRetry ? 4 : 3),
      ),
    );
  }

  /// Show bottom sheet error
  static void showErrorBottomSheet(
    BuildContext context,
    AppError error, {
    VoidCallback? onRetry,
    VoidCallback? onAction,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getErrorIcon(error.type),
              color: _getErrorColor(error.type),
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              _getErrorTitle(error.type),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error.userMessage,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                if (error.canRetry && onRetry != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onRetry();
                      },
                      child: const Text('Try Again'),
                    ),
                  ),
                if (error.canRetry &&
                    onRetry != null &&
                    error.actionText != null)
                  const SizedBox(width: 12),
                if (error.actionText != null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (onAction != null) {
                          onAction();
                        } else {
                          _handleDefaultAction(context, error.type);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.moroccoGreen,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(error.actionText!),
                    ),
                  ),
                if (!error.canRetry && error.actionText == null)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Cultural-specific error handling for Morocco
  static AppError createCulturalError(String culturalConstraint) {
    switch (culturalConstraint) {
      case 'prayer_time':
        return AppError(
          type: ErrorType.cultural,
          message: 'Operation not available during prayer time',
          userMessage:
              'Some features are paused during prayer time. Please try again after prayer.',
          canRetry: true,
        );
      case 'ramadan_hours':
        return AppError(
          type: ErrorType.cultural,
          message: 'Venue hours modified for Ramadan',
          userMessage:
              'Venue hours are adjusted for Ramadan. Check updated timings.',
          canRetry: false,
          actionText: 'View Hours',
        );
      case 'halal_only':
        return AppError(
          type: ErrorType.validation,
          message: 'Non-halal content filtered',
          userMessage:
              'Some options are hidden based on your halal preferences.',
          canRetry: false,
          actionText: 'Settings',
        );
      case 'friday_prayer':
        return AppError(
          type: ErrorType.cultural,
          message: 'Limited service during Friday prayer',
          userMessage:
              'Many venues have limited service during Friday prayer time.',
          canRetry: true,
        );
      default:
        return AppError(
          type: ErrorType.cultural,
          message: 'Cultural constraint applied',
          userMessage: 'This action respects local cultural preferences.',
          canRetry: false,
        );
    }
  }

  // Helper methods
  static IconData _getErrorIcon(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.authentication:
        return Icons.lock_outline;
      case ErrorType.validation:
        return Icons.warning_amber_outlined;
      case ErrorType.permission:
        return Icons.security;
      case ErrorType.server:
        return Icons.cloud_off;
      case ErrorType.timeout:
        return Icons.timer_off;
      case ErrorType.offline:
        return Icons.cloud_off;
      case ErrorType.cultural:
        return Icons.mosque;
      case ErrorType.unknown:
        return Icons.error_outline;
    }
  }

  static Color _getErrorColor(ErrorType type) {
    switch (type) {
      case ErrorType.network:
      case ErrorType.offline:
        return AppColors.info;
      case ErrorType.authentication:
      case ErrorType.permission:
        return AppColors.warning;
      case ErrorType.validation:
        return AppColors.warning;
      case ErrorType.server:
      case ErrorType.timeout:
        return AppColors.error;
      case ErrorType.cultural:
        return AppColors.prayerTime;
      case ErrorType.unknown:
        return AppColors.error;
    }
  }

  static String _getErrorTitle(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return 'Connection Problem';
      case ErrorType.authentication:
        return 'Authentication Required';
      case ErrorType.validation:
        return 'Invalid Input';
      case ErrorType.permission:
        return 'Permission Required';
      case ErrorType.server:
        return 'Server Error';
      case ErrorType.timeout:
        return 'Request Timeout';
      case ErrorType.offline:
        return 'You\'re Offline';
      case ErrorType.cultural:
        return 'Cultural Notice';
      case ErrorType.unknown:
        return 'Error';
    }
  }

  static void _handleDefaultAction(BuildContext context, ErrorType type) {
    switch (type) {
      case ErrorType.permission:
        // Open app settings
        break;
      case ErrorType.authentication:
        // Navigate to login
        break;
      case ErrorType.cultural:
        // Show cultural info
        break;
      default:
        break;
    }
  }
}