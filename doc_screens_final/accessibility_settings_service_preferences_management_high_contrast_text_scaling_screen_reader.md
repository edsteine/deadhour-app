# Accessibility Settings Service

## Purpose
Service class that manages accessibility preferences and settings throughout the DeadHour app, ensuring the platform is accessible to users with disabilities and diverse needs.

## Features
- **High Contrast Mode**: Enhanced contrast for better visibility and readability
- **Large Text Support**: Adjustable text size scaling from 80% to 200% of normal size
- **Screen Reader Compatibility**: Optimized hints and descriptions for screen readers
- **Motion Reduction**: Reduces animations and motion effects for sensitive users
- **Text Scale Factor**: Precise text scaling control with safe bounds (0.8x to 2.0x)
- **Semantic Descriptions**: Enhanced semantic labels for navigation and UI elements
- **Haptic Feedback Control**: Customizable haptic feedback preferences
- **Settings Persistence**: Save and restore accessibility preferences across app sessions
- **Dynamic Updates**: Real-time application of accessibility changes without restart
- **Default Safe Settings**: Accessibility-friendly defaults that work for most users

## Implementation Details
- **Settings Storage**: In-memory map with key-value pairs for quick access
- **Type Safety**: Generic getter methods with proper type casting
- **Validation**: Built-in value validation (e.g., text scale clamping)
- **Property Getters/Setters**: Convenient boolean and numeric property access
- **Batch Updates**: Support for updating multiple settings simultaneously

## Integration Points
- **UI Components**: All widgets respect accessibility settings
- **Theme System**: High contrast mode integrates with app theming
- **Text Rendering**: Dynamic text scaling affects all text elements
- **Animation System**: Motion reduction controls app-wide animations
- **Navigation**: Screen reader hints improve navigation experience

## User Benefits
- **Visual Impairments**: High contrast and large text support
- **Motor Disabilities**: Reduced motion and enhanced touch targets
- **Cognitive Accessibility**: Clear semantic descriptions and simplified interactions
- **Hearing Impairments**: Haptic feedback alternatives for audio cues
- **Universal Design**: Better usability for all users regardless of abilities

## Service Category
**Accessibility** - Core accessibility settings management service