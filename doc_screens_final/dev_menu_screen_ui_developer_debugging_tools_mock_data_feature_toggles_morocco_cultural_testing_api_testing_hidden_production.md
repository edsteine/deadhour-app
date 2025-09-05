# Dev Menu Screen

## Purpose
Developer and debugging menu screen that provides access to development tools, debugging features, testing utilities, and administrative functions for the DeadHour app development and testing phases.

## Features
- **Environment Switching**: Toggle between development, staging, and production environments
- **Mock Data Controls**: Enable/disable mock data, reset mock data, load test scenarios
- **Feature Toggles**: Enable/disable experimental features and beta functionality
- **Debug Information**: Display app version, build number, device info, and system details
- **Network Testing**: Test API endpoints, simulate network conditions, view API logs
- **User Role Simulation**: Switch between different user roles for testing purposes
- **Cultural Testing**: Test different languages, RTL layouts, and cultural preferences
- **Accessibility Testing**: Test screen reader compatibility and accessibility features
- **Performance Monitoring**: View memory usage, performance metrics, and app diagnostics
- **Error Simulation**: Trigger error states for testing error handling
- **Cache Management**: Clear app caches, reset local storage, force data refresh
- **Logging Controls**: Enable/disable detailed logging, export log files

## Development Tools
- **API Testing**: Test backend endpoints and view response data
- **Database Inspection**: View local database contents and run queries
- **State Debugging**: Inspect app state, provider states, and data flow
- **UI Testing**: Test different screen sizes, orientations, and device configurations
- **Payment Testing**: Test payment flows with sandbox/test payment methods
- **Notification Testing**: Send test notifications and verify delivery

## Morocco-Specific Testing
- **Language Testing**: Switch between Arabic, French, and English for UI testing
- **Cultural Calendar Testing**: Test Islamic holidays, prayer times, and Ramadan features
- **Location Testing**: Simulate different Morocco locations and regional settings
- **Currency Testing**: Test MAD/EUR conversion and pricing displays
- **Halal Filter Testing**: Test halal filtering and certification features

## Admin Functions
- **User Management**: View user accounts, reset passwords, manage roles
- **Content Moderation**: Review flagged content, moderate community rooms
- **Analytics Access**: View detailed analytics and business intelligence data
- **System Health**: Monitor server status, database health, and service availability
- **Feature Rollouts**: Control feature rollouts and A/B testing configurations

## Security Features
- **Access Control**: Restricted access to authorized developers and admins only
- **Audit Logging**: Log all admin actions and system changes
- **Environment Isolation**: Prevent accidental production changes during development
- **Data Protection**: Mask sensitive user data in development views
- **Session Management**: Secure developer session handling and timeout controls

## User Types
- **Developers**: Full access to development and debugging tools
- **QA Testers**: Access to testing utilities and simulation tools
- **Product Managers**: Access to feature toggles and user simulation
- **System Administrators**: Access to system health and user management tools
- **Support Staff**: Limited access to user troubleshooting tools

## Navigation
- Hidden from regular users, accessible only in development builds
- Long-press gesture on app logo or settings icon (development builds only)
- Secret key combination or developer authentication
- Direct access during development and testing phases

## Screen Category
**Development** - Developer tools and debugging utilities (hidden from production)