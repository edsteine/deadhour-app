# Voice Over Helper Service

## Purpose
Comprehensive voice-over and screen reader support service providing semantic labels, announcements, and accessibility feedback for the DeadHour app's Morocco-specific features.

## Features
- **Screen Reader Detection**: Monitor and manage screen reader enablement status
- **Voice Announcements**: Semantic announcements for important user actions
- **Focus Management**: Keyboard navigation and focus announcements
- **Haptic Feedback**: Accessibility-aware haptic feedback with error states
- **Cultural Accessibility**: RTL language support and Arabic text direction
- **Context-Aware Semantics**: Smart semantic labels for venues, deals, and rooms
- **Navigation Semantics**: Clear navigation state announcements
- **Button Context**: Enhanced button semantics with state and context information

## Semantic Label Generation
- **Venue Semantics**: "Name, category, rating stars, distance away"
- **Deal Semantics**: "Title, discount percent off at venue, valid until time"
- **Room Semantics**: "Name, category room, member count, active deals status"
- **Navigation Semantics**: "Tab name, selection status"
- **Button Semantics**: "Action button for context, enabled/disabled state"

## Voice-Over Features
- **Action Announcements**: Announce button presses and navigation changes
- **Focus Announcements**: Announce focus changes for keyboard navigation
- **State Changes**: Announce selection states and navigation updates
- **Error Feedback**: Heavy haptic feedback for errors, light feedback for success
- **Cultural Support**: Proper announcements in Arabic, French, and English

## Accessibility Integration
- **Semantic Service**: Integration with Flutter's SemanticsService
- **Haptic Feedback**: Platform-specific haptic feedback with accessibility preferences
- **Text Direction**: Automatic RTL/LTR text direction based on language
- **Screen Reader Status**: Dynamic screen reader enablement detection
- **Cultural Context**: Morocco-specific accessibility features and language support

## Morocco-Specific Features
- **RTL Language Support**: Arabic text direction and semantic announcements
- **Cultural Venue Context**: Semantic labels include halal status and cultural information
- **Prayer Time Accessibility**: Accessible announcements for prayer time features
- **Multi-Language Semantics**: Proper semantic support for Arabic, French, and English

## Service Category
**Accessibility** - Voice-over, screen reader, and semantic announcement support