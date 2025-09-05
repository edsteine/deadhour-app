# Guest Mode Provider

## Purpose
State management for guest mode functionality, allowing users to explore the app without registration while tracking their session and onboarding status.

## Features
- **Guest Session Management**: Enable/disable guest mode with session tracking
- **Onboarding Integration**: Track whether guest users have seen onboarding flows
- **Session Persistence**: Maintain guest session state across app launches
- **Authentication Bridge**: Seamless transition from guest mode to authenticated user
- **Riverpod Integration**: Modern state management with reactive updates

## User Types
- **Guest Users**: Primary target - users exploring the app before registration
- **Converting Users**: Users transitioning from guest mode to authenticated accounts
- **All User Types**: Foundation for authentication state management

## Navigation
- **Splash Screen**: Initial guest mode detection and routing
- **Onboarding Screen**: Guest-specific onboarding flows
- **Authentication Screens**: Registration/login with guest mode context
- **Profile Screen**: Guest user experience and conversion prompts
- **Throughout App**: Guest-specific feature limitations and prompts

## Screen Category
Provider - Authentication/State Management

## Integration Points
- **Authentication System**: Guest mode as alternative to immediate registration
- **Onboarding Service**: Track guest user onboarding completion
- **User Experience**: Guest-specific UI elements and feature limitations
- **Analytics**: Track guest user behavior and conversion rates
- **Data Persistence**: Local storage for guest session management
- **Navigation**: Route guests through appropriate flows
- **Conversion Optimization**: Encourage guest-to-user conversion at optimal moments

## Key Properties
- Riverpod StateNotifier for reactive state management
- Guest session ID for tracking anonymous user behavior
- Onboarding completion tracking for improved user experience
- Seamless authentication transition methods
- Persistent guest mode state across app sessions