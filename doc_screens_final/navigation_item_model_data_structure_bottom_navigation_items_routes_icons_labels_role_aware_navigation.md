# Navigation Item Model

## Purpose
Simple data model for bottom navigation bar items, defining route, icon, active icon, and label for the main app navigation.

## Features
- **Route Definition**: Navigation route paths for Flutter routing
- **Icon Management**: Default and active state icons for navigation states
- **Label Display**: User-friendly labels for navigation items
- **Material Design Integration**: Uses Flutter Material Design icons

## User Types
- **All User Roles**: Used by all users regardless of role for main app navigation
- **Role-Aware Navigation**: Can be extended to show/hide items based on active user roles

## Navigation
- Core component of main bottom navigation bar
- Used in MainNavigationScreen and related navigation components
- Foundation for role-based navigation customization

## Screen Category
Data Model - Navigation component

## Integration Points
- **Main Navigation Screen**: Primary usage in bottom navigation bar
- **Role System**: Can be extended for role-specific navigation items
- **Flutter Router**: Route definitions for app navigation
- **Theme System**: Icon theming and styling integration
- **User Experience**: Core navigation pattern throughout the app

## Key Properties
- Simple, lightweight model for navigation configuration
- Material Design icon support for consistent UI
- Route-based navigation for Flutter routing system
- Active/inactive state management for visual feedback