# Deal Model

## Purpose
Core data model representing business deals with comprehensive properties for dead hours optimization, including cultural awareness features and booking management.

## Features
- **Deal Management**: Complete deal lifecycle with validation, expiration, and availability tracking
- **Discount Types**: Multiple discount formats (percentage, fixed price, BOGO, combo deals)
- **Time Management**: Valid date ranges, time slots, and day-of-week restrictions
- **Capacity Control**: Maximum capacity and current booking tracking
- **Cultural Integration**: Prayer time awareness and halal-only filtering
- **Real-time Status**: Dynamic availability, urgency levels, and occupancy tracking
- **Display Formatting**: User-friendly discount displays and status indicators

## User Types
- **Business Role**: Create and manage deals during dead hours
- **Consumer Role**: Browse, filter, and book available deals
- **Guide Role**: Recommend deals to tourists and locals
- **Premium Role**: Access to premium deal features and priority booking

## Navigation
- Used throughout the app wherever deals are displayed or managed
- Central to business dashboard, community rooms, and booking flows
- Integrated into venue details and social discovery features

## Screen Category
Data Model - Core business entity

## Integration Points
- **Business Dashboard**: Deal creation, editing, and performance tracking
- **Community Rooms**: Deal sharing and discussion in category-based rooms
- **Booking System**: Capacity management and reservation handling
- **Cultural Services**: Prayer time and halal filtering integration
- **Analytics**: Performance tracking and optimization metrics
- **Social Discovery**: Community-driven deal validation and recommendations

## Key Properties
- Complete deal lifecycle management (valid, expired, upcoming states)
- Cultural awareness (prayer time compatibility, halal certification)
- Real-time availability and urgency calculations
- Comprehensive display formatting and status indicators
- JSON serialization for Firebase integration
- Immutable copyWith pattern for state management