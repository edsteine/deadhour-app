# App Routes

## Purpose
Comprehensive navigation system for the DeadHour app using GoRouter, providing declarative routing with support for the dual-problem platform architecture and multi-role user system.

## Features
- **Declarative Routing**: Complete GoRouter configuration for all app screens
- **Role-Based Navigation**: Routes organized by user roles (Consumer, Business, Guide, Premium, Admin)
- **Tab Navigation**: Main app tabs with proper deep linking support
- **Parameter Passing**: Route parameters for venues, rooms, deals, and user context
- **Error Handling**: Custom error page with user-friendly messaging
- **Navigation Helpers**: Utility classes for easy navigation throughout the app
- **Mock Data Integration**: Development-friendly mock data for testing flows

## User Types
- **All User Roles**: Serves navigation for all user types with role-appropriate access
- **Authentication Flow**: Routes for login, registration, onboarding, and role selection
- **Business Role**: Business dashboard, deal creation, analytics, and revenue optimization
- **Guide Role**: Guide services, local expertise, and tourism features  
- **Premium Role**: Premium features and role management
- **Admin Role**: Network effects dashboard and community health monitoring

## Navigation
- **Entry Point**: Initial splash screen routing based on authentication state
- **Main Navigation**: Tab-based navigation for core app features
- **Deep Linking**: URL-based navigation with parameter support
- **Back Navigation**: Proper back button handling and navigation stack management
- **Error Handling**: Fallback navigation for invalid routes

## Screen Category
System Architecture - Navigation/Routing

## Integration Points
- **Authentication System**: Auth-based routing and access control
- **Main Navigation Screen**: Tab navigation integration
- **Role System**: Role-specific route access and features
- **Business Dashboard**: Business role navigation and deal management
- **Community System**: Room navigation and chat routing
- **Booking System**: Deal booking flow with parameter passing
- **Payment System**: Payment flow integration with mock data
- **Admin Tools**: Network effects and community health dashboards
- **Cultural Features**: Cultural ambassador application and tourism routing

## Key Features
- **Route Constants**: AppRoutes class with predefined route paths
- **Navigation Helpers**: AppNavigation class with convenience methods
- **Error Boundary**: Custom error page with home navigation fallback
- **Parameter Validation**: Required parameters (venueId, roomId) with type safety
- **Extra Data Passing**: Deal objects and booking details via route extras
- **Mock Data Integration**: Development-friendly mock data for testing
- **Deep Linking Support**: URL-based navigation for web and mobile
- **Tab Navigation**: Proper tab state management and navigation persistence

## Route Categories
- **Authentication**: Splash, onboarding, login, register, role marketplace
- **Main App**: Home, deals, venues, community, tourism, notifications, profile
- **Business**: Dashboard, deal creation, analytics, revenue optimization
- **Community**: Room details, chat, and social discovery
- **Tourism**: Local expert features and social discovery
- **Settings**: App settings, accessibility, offline settings
- **Admin**: Network effects and community health dashboards
- **Payments**: Mock payment flow for testing and development