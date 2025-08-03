import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// DeadHour app logging utility
/// Provides consistent logging across the application with easy filtering
class AppLogger {
  static const String _appName = 'DeadHour';

  /// Log general app information
  static void info(String message, {String? feature}) {
    developer.log(
      message,
      name: feature != null ? '$_appName:$feature' : _appName,
      level: 800, // Info level
    );
  }

  /// Log warnings
  static void warning(String message, {String? feature}) {
    developer.log(
      message,
      name: feature != null ? '$_appName:$feature' : _appName,
      level: 900, // Warning level
    );
  }

  /// Log errors
  static void error(String message, {String? feature, Object? error}) {
    developer.log(
      message,
      name: feature != null ? '$_appName:$feature' : _appName,
      level: 1000, // Error level
      error: error,
    );
  }

  /// Log service initialization
  static void serviceInit(String serviceName, {bool success = true}) {
    final status = success ? '✅' : '❌';
    final message = success 
        ? '$status $serviceName initialized successfully'
        : '$status $serviceName initialization failed';
    
    developer.log(
      message,
      name: '$_appName:Services',
      level: success ? 800 : 1000,
    );
  }

  /// Log performance metrics
  static void performance(String message) {
    developer.log(
      message,
      name: '$_appName:Performance',
      level: 800,
    );
  }

  /// Log cultural/Morocco-specific features
  static void cultural(String message) {
    developer.log(
      message,
      name: '$_appName:Cultural',
      level: 800,
    );
  }

  /// Log debugging information (only in debug mode)
  static void debug(String message, {String? feature}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: feature != null ? '$_appName:Debug:$feature' : '$_appName:Debug',
        level: 700, // Debug level
      );
    }
  }
}