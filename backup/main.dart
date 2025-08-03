import 'package:flutter/material.dart';
import 'app.dart';
import 'services/auth_service.dart';
import 'services/app_performance_service.dart';
import 'services/onboarding_service.dart';
import 'services/offline_service.dart';
import 'services/morocco_cultural_service.dart';
import 'services/deployment_optimization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize only critical services synchronously for fast startup
  await _initializeCriticalServices();

  // Start the app immediately
  runApp(const DeadHourApp());

  // Initialize remaining services in background after app starts
  _initializeBackgroundServices();
}

/// Initialize only essential services needed for app startup (fast)
Future<void> _initializeCriticalServices() async {
  try {
    // Only initialize what's absolutely needed for app to start
    await AuthService().initialize();
    
    debugPrint('✅ Critical services initialized - app ready to start');
  } catch (error) {
    debugPrint('Critical service initialization error: $error');
  }
}

/// Initialize remaining services in background (non-blocking)
void _initializeBackgroundServices() {
  // Run heavy services in background without blocking UI
  Future.microtask(() async {
    try {
      debugPrint('🔄 Initializing background services...');
      
      // Initialize performance monitoring
      await AppPerformanceService().initialize();
      
      // Initialize onboarding service
      await OnboardingService().initialize();
      
      // Initialize offline capabilities
      await OfflineService().initialize();
      
      // Initialize Morocco cultural features
      await MoroccoCulturalService().initialize();
      
      // Initialize production optimizations
      await DeploymentOptimizationService().initializeProductionOptimizations();
      
      // Optimize app performance after everything is loaded
      await AppPerformanceService().optimizeAppStartup();
      
      debugPrint('✅ All background services initialized');
    } catch (error) {
      debugPrint('Background service initialization error: $error');
    }
  });
}
