# Room Model

## Purpose
Core data model for community rooms in the Discord-inspired chat system, supporting category-based deal discovery and social interaction with cultural awareness features.

## Features
- **Room Management**: Complete room lifecycle with membership and activity tracking
- **Category System**: Category-based organization (food, entertainment, wellness, sports, tourism, family)
- **Cultural Integration**: Prayer time awareness and halal-only filtering for culturally sensitive discussions
- **Activity Tracking**: Real-time activity status, member counts, and engagement metrics
- **Privacy Controls**: Public/private rooms with premium-only access options
- **Deal Integration**: Rooms can allow business deals for social commerce
- **Message Management**: Recent message tracking and conversation history
- **Geographic Targeting**: City-based room organization for local relevance

## User Types
- **Consumer Role**: Join public rooms, participate in discussions, discover deals
- **Business Role**: Share deals in appropriate category rooms, engage with community
- **Guide Role**: Share expertise in tourism and local guide rooms
- **Premium Role**: Access premium-only rooms with enhanced features
- **Admin Role**: Moderate rooms and manage community health

## Navigation
- **Community Tab**: Main access point through rooms screen
- **Room Chat**: Individual room conversations and deal discussions
- **Room Discovery**: Search and filter rooms by category, popularity, and preferences
- **Cross-Role Navigation**: Different room access based on active user roles

## Screen Category
Data Model - Social/Community

## Integration Points
- **Community Rooms Screen**: Room listing, filtering, and discovery
- **Room Chat Screen**: Individual room conversations and interactions
- **Deal System**: Business deals shared and discussed in category rooms
- **Cultural Services**: Prayer time and halal awareness in room settings
- **User Roles**: Role-based room access and features
- **Social Discovery**: Community-driven deal validation and recommendations
- **Analytics**: Room engagement and community health metrics

## Key Properties
- Category-based organization with emoji icons for visual identification
- Real-time activity tracking and engagement rate calculations
- Cultural awareness features for Morocco market (prayer times, halal filtering)
- Privacy and premium access controls for monetization
- Comprehensive activity status and member engagement metrics
- JSON serialization for Firebase real-time updates
- Room type classification (Premium, Private, Deal Room, Community)