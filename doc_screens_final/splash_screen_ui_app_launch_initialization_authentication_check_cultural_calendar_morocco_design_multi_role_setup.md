# Splash Screen

## Purpose
App launch screen providing initial loading experience while the app initializes services and determines user authentication state.

## Features
- **Brand Identity**: DeadHour logo, branding elements, and visual identity
- **Loading Indicators**: Progress indicators for app initialization and service loading
- **Cultural Elements**: Moroccan design elements and cultural motifs
- **Authentication Check**: Determine if user is logged in and which roles are active
- **Service Initialization**: Initialize Firebase, location services, cultural calendar
- **Version Check**: Verify app version and handle updates if necessary
- **Network Status**: Check connectivity and prepare offline/online experience
- **Cultural Calendar Loading**: Initialize prayer times and cultural calendar data
- **Role Context Setup**: Prepare multi-role account system and active role context
- **Smooth Transitions**: Elegant animations to main app or onboarding

## User Types
- **All Users**: Everyone sees splash screen during app launch
- **New Users**: Directed to onboarding after splash
- **Existing Users**: Directed to main app with active role context
- **Returning Users**: Restored to previous app state and active roles

## Navigation
- Accessed from: App launch (entry point)
- Can navigate to: Onboarding screen, main navigation, login screen
- Back navigation: Cannot go back (app entry point)

## Screen Category
**App Initialization** - System loading and user state determination during app startup.

## Integration Points
- Connects with authentication services to determine user state
- Integrates with all platform services for initialization
- Links to role management system for multi-role context setup
- Supports offline service for cached data loading