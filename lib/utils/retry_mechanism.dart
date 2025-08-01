import 'dart:io';
import 'package:deadhour/utils/timeout_exception.dart';

/// Retry mechanism utility
class RetryMechanism {
  static Future<T> withRetry<T>(
    Future<T> Function() operation, {
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
    bool Function(dynamic error)? shouldRetry,
  }) async {
    dynamic lastError;

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        return await operation();
      } catch (error) {
        lastError = error;

        // Check if we should retry this error
        if (shouldRetry != null && !shouldRetry(error)) {
          rethrow;
        }

        // Don't delay on the last attempt
        if (attempt < maxRetries - 1) {
          await Future.delayed(delay * (attempt + 1)); // Exponential backoff
        }
      }
    }

    throw lastError;
  }

  static bool shouldRetryError(dynamic error) {
    if (error is SocketException) return true;
    if (error is TimeoutException) return true;
    if (error is HttpException) {
      // Retry on 5xx server errors but not 4xx client errors
      final statusCode = error.uri?.queryParameters['status'];
      if (statusCode != null) {
        final code = int.tryParse(statusCode);
        return code != null && code >= 500;
      }
    }
    return false;
  }
}