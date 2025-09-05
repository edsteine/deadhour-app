# User Model (DeadHourUser)

## Purpose
Revolutionary multi-role user account system that enables the dual-problem platform approach, allowing users to participate in both business optimization and social discovery through role stacking.

## Features
- **Multi-Role System**: Revolutionary role stacking (Consumer, Business, Guide, Premium, Driver, Host, Chef, Photographer)
- **Role Management**: Add/remove roles dynamically with role-specific capabilities and metrics
- **Network Effects**: Network effect multiplier that increases user value through multi-role participation
- **Cultural Integration**: Preferred language, location-based features, and cultural preferences
- **Revenue Optimization**: Monthly revenue potential calculation based on active roles
- **Cross-Role Metrics**: Performance tracking across multiple roles for platform optimization
- **Profile Management**: Comprehensive user profile with verification and preferences

## User Types
- **All User Roles**: Central model that defines all user types and their capabilities
- **Role Stacking**: Users can activate multiple roles simultaneously for enhanced platform value
- **Dynamic Switching**: Instagram-inspired interface for seamless role switching

## Navigation
- **Profile Screen**: User account management and role configuration
- **Role Switching Screen**: Select and manage active roles
- **Premium Role Screen**: Upgrade and role subscription management
- **Throughout App**: User context determines available features and navigation options

## Screen Category
Data Model - Core User System

## Integration Points
- **Authentication System**: User login, registration, and session management
- **Role Management**: Role activation, deactivation, and capability tracking
- **Business Dashboard**: Business role capabilities and venue management
- **Guide Services**: Local expertise sharing and guide features  
- **Premium Features**: Enhanced features across all active roles
- **Community Rooms**: Role-based room access and interaction features
- **Analytics**: Multi-role performance tracking and revenue optimization
- **Cultural Services**: Language preferences and cultural customization
- **Social Discovery**: Role-enhanced social features and networking

## Key Properties
- Set-based role management allowing multiple simultaneous active roles
- Network effect multiplier for platform value calculation (1.0 base, increases with role stacking)
- Monthly revenue potential calculation (€65+ for multi-role users)
- Comprehensive role capability tracking and cross-role metrics
- Cultural preferences and multi-language support (Arabic RTL, French, English)
- Generic hasRole() method for backward compatibility with existing code
- Role-specific getters for all user types (hasBusinessRole, hasGuideRole, etc.)
- Display formatting for user interface (userTypeIcon, displayRoles)
- Complete JSON serialization for Firebase integration