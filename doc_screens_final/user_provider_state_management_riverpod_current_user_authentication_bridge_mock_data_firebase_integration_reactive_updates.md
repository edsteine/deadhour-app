# User Provider

## Purpose
Simple Riverpod provider for current user state management, serving as the central access point for user data throughout the application.

## Features
- **Current User Access**: Centralized access to the current authenticated user
- **Mock Data Integration**: Uses mock data during development phase
- **Reactive Updates**: Riverpod provider enables reactive UI updates when user changes
- **Authentication Bridge**: Foundation for connecting to authentication services
- **Future Firebase Integration**: Designed to easily integrate with Firebase Auth

## User Types
- **All Authenticated Users**: Provides access to current user data regardless of roles
- **Guest Users**: Returns null for unauthenticated users
- **Multi-Role Users**: Access to complete user profile including all active roles

## Navigation
- **Throughout App**: Used wherever current user context is needed
- **Profile Screens**: Primary user data access for profile display and editing
- **Authentication Flows**: User state management during login/logout
- **Role-Based Features**: User role checking for feature access

## Screen Category
Provider - Core User State

## Integration Points
- **User Model**: Provides access to DeadHourUser model instances
- **Authentication System**: Central point for user authentication state
- **Mock Data Service**: Currently uses MockData.currentUser for development
- **Firebase Integration**: Future integration point for Firebase Auth
- **Role System**: Access to user's active roles and capabilities
- **Profile Management**: User data for profile screens and editing
- **Business Logic**: User context for business rules and feature access
- **Analytics**: User data for tracking and personalization

## Key Properties
- Simple Provider pattern returning DeadHourUser or null
- Mock data integration for development and testing
- Designed for easy Firebase Auth integration
- Reactive updates throughout the application when user state changes

## Development Notes
- Currently uses mock data (MockData.currentUser)
- Placeholder for future Firebase Auth integration
- Simple pattern allows easy expansion for complex user state management