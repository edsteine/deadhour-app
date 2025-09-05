# Main (Application Entry Point)

## Purpose
The main entry point for the DeadHour Flutter application, handling app initialization, service setup, and performance optimization.

## Features
- Fast startup optimization with critical services only
- Background service initialization to avoid blocking UI
- Comprehensive service management including:
  - AuthService (critical - initialized first)
  - AppPerformanceService (background)
  - OnboardingService (background)
  - OfflineService (background)
  - MoroccoCulturalService (background)
  - DeploymentOptimizationService (background)
- Error handling for service initialization
- Performance monitoring and startup optimization
- Debug logging for service initialization status

## Technical Architecture
- Two-phase initialization:
  1. Critical services (AuthService) - synchronous, fast
  2. Background services - asynchronous, non-blocking
- Uses Flutter's WidgetsFlutterBinding.ensureInitialized()
- Microtask-based background service loading
- Production-ready deployment optimizations

## User Type
- System-level (all users benefit from optimized startup)

## Navigation
- Entry point for entire application
- Launches DeadHourApp widget

## Screen Category
Core Application Bootstrap