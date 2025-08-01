import 'package:flutter/material.dart';
import 'error_handler.dart';

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