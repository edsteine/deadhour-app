import 'package:flutter/material.dart';
import 'package:deadhour/app.dart';
import 'package:deadhour/utils/guest_mode.dart';
import 'package:deadhour/services/auth_service.dart';
import 'package:deadhour/services/app_performance_service.dart';
import 'package:deadhour/services/onboarding_service.dart';
import 'package:deadhour/services/offline_service.dart';
import 'package:deadhour/services/morocco_cultural_service.dart';
import 'package:deadhour/services/deployment_optimization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize core services
  await _initializeServices();

  runApp(const DeadHourApp());
}

Future<void> _initializeServices() async {
  try {
    // Initialize performance service first for monitoring startup
    await AppPerformanceService().initialize();

    // Initialize guest mode state
    await GuestMode.initialize();

    // Initialize authentication service
    await AuthService().initialize();

    // Initialize onboarding service
    await OnboardingService().initialize();

    // Initialize offline service
    await OfflineService().initialize();

    // Initialize Morocco cultural service
    await MoroccoCulturalService().initialize();

    // Initialize deployment optimizations for Morocco market
    await DeploymentOptimizationService().initializeProductionOptimizations();

    // Optimize app startup
    await AppPerformanceService().optimizeAppStartup();
  } catch (error) {
    // Handle initialization errors gracefully
    debugPrint('Service initialization error: $error');
  }
}
