import 'package:deadhour/utils/error_type.dart';

/// Error model class
class AppError {
  final ErrorType type;
  final String message;
  final String userMessage;
  final bool canRetry;
  final String? actionText;

  AppError({
    required this.type,
    required this.message,
    required this.userMessage,
    required this.canRetry,
    this.actionText,
  });
}