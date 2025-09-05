# App (DeadHourApp)

## Purpose
Main application widget that bootstraps the DeadHour Flutter app with routing, state management, and core configuration.

## Features
- Flutter Riverpod state management integration (ProviderScope)
- App routing configuration using AppRouter
- Material Design app structure
- Performance monitoring capability (currently commented out)
- Debug banner disabled for cleaner UI
- App title: "DeadHour Morocco"

## Technical Details
- Uses MaterialApp.router for navigation
- Integrates with app_routes.dart for routing configuration
- State management through flutter_riverpod package
- Performance overlay temporarily disabled to avoid hiding UI elements
- Can be re-enabled for performance debugging when needed

## User Type
- All users (core app entry point)

## Navigation
- Root of the application
- Routes to all other screens via AppRouter configuration

## Screen Category
Core App Infrastructure