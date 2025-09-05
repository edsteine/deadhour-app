# Role Toggle Provider

## Purpose
State management for the revolutionary multi-role system, enabling Instagram-inspired role switching and role stacking functionality that powers the dual-problem platform approach.

## Features
- **Role Switching**: Seamless switching between active user roles (Consumer, Business, Guide, Premium)
- **Role Stacking**: Support for multiple simultaneous active roles per user account
- **Authentication Integration**: Role management tied to user login/logout state
- **Dynamic Role Addition**: Add new roles to user accounts during app usage
- **Primary Role Selection**: Set the current primary/active role for context-specific UI
- **Login State Management**: Track authentication status and role availability

## User Types
- **Multi-Role Users**: Primary target - users with multiple active roles (Business + Guide + Premium)
- **Role Switchers**: Users who frequently switch between different role contexts
- **All Authenticated Users**: Foundation for role-based feature access and UI customization

## Navigation
- **Role Switching Screen**: Primary interface for role selection and management
- **Profile Screen**: Role management and subscription status
- **Main Navigation**: Role-aware navigation items and feature access
- **Business Dashboard**: Business role context and features
- **Guide Services**: Guide role context and capabilities
- **Throughout App**: Role-specific UI elements and feature availability

## Screen Category
Provider - Role/Authentication Management

## Integration Points
- **User Model**: DeadHourUser multi-role system integration
- **Authentication Service**: Role management tied to user accounts
- **Business Dashboard**: Business role feature access
- **Guide Services**: Guide role capabilities
- **Premium Features**: Premium role enhancement across all roles
- **Navigation System**: Role-based navigation and feature availability
- **Revenue System**: Role subscription tracking and monetization
- **UI Components**: Role-specific interface elements and features

## Key Properties
- Primary role selection for current app context
- Active roles list supporting multiple simultaneous roles
- Authentication state integration (logged in/out)
- Dynamic role addition during app usage
- Role validation and feature access control
- Riverpod StateNotifier for reactive role state management

## Key Methods
- `setRole()`: Switch to a specific active role
- `toggleLogin()`: Handle authentication state changes
- `addRole()`: Add new roles to user account
- Role validation for feature access control