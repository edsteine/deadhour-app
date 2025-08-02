import 'package:flutter/material.dart';
import 'package:deadhour/services/accessibility/accessibility_settings.dart';
import 'package:deadhour/services/accessibility/voice_over_helper.dart';
import 'package:deadhour/services/accessibility/screen_reader_support.dart';

/// Accessibility service for DeadHour app
/// Handles screen reader support, high contrast mode, and inclusive design features
class AccessibilityService {
  static final AccessibilityService _instance = AccessibilityService._internal();
  factory AccessibilityService() => _instance;
  AccessibilityService._internal();

  // Accessibility settings
  bool _isHighContrastEnabled = false;
  bool _isLargeTextEnabled = false;
  bool _isScreenReaderEnabled = false;
  bool _isReduceMotionEnabled = false;
  double _textScaleFactor = 1.0;

  final AccessibilitySettings _settings = AccessibilitySettings();

  /// Initialize accessibility service and detect system settings
  void initialize() {
    _detectSystemAccessibilitySettings();
    _setupAccessibilityFeatures();
  }

  /// High contrast mode management
  bool get isHighContrastEnabled => _isHighContrastEnabled;
  
  void setHighContrast(bool enabled) {
    _isHighContrastEnabled = enabled;
    _settings.isHighContrastEnabled = enabled;
    _notifyAccessibilityChange();
  }

  /// Large text support
  bool get isLargeTextEnabled => _isLargeTextEnabled;
  double get textScaleFactor => _textScaleFactor;
  
  void setLargeText(bool enabled) {
    _isLargeTextEnabled = enabled;
    _textScaleFactor = enabled ? 1.3 : 1.0;
    _settings.isLargeTextEnabled = enabled;
    _settings.textScaleFactor = _textScaleFactor;
    _notifyAccessibilityChange();
  }

  void setTextScaleFactor(double factor) {
    _textScaleFactor = factor.clamp(0.8, 2.0);
    _settings.textScaleFactor = _textScaleFactor;
    _notifyAccessibilityChange();
  }

  /// Screen reader support
  bool get isScreenReaderEnabled => _isScreenReaderEnabled;
  
  void setScreenReader(bool enabled) {
    _isScreenReaderEnabled = enabled;
    _settings.hasScreenReaderHints = enabled;
    VoiceOverHelper.setScreenReader(enabled);
  }

  /// Motion reduction for accessibility
  bool get isReduceMotionEnabled => _isReduceMotionEnabled;
  
  void setReduceMotion(bool enabled) {
    _isReduceMotionEnabled = enabled;
    _settings.isReduceMotionEnabled = enabled;
  }

  /// Get semantic label for venues
  String getVenueSemantic(Map<String, dynamic> venue) {
    return VoiceOverHelper.getVenueSemantic(venue);
  }

  /// Get semantic label for deals
  String getDealSemantic(Map<String, dynamic> deal) {
    return VoiceOverHelper.getDealSemantic(deal);
  }

  /// Get semantic label for community rooms
  String getRoomSemantic(Map<String, dynamic> room) {
    return VoiceOverHelper.getRoomSemantic(room);
  }

  /// Get semantic label for navigation items
  String getNavigationSemantic(String routeName, bool isActive) {
    return VoiceOverHelper.getNavigationSemantic(routeName, isActive);
  }

  /// Get semantic label for buttons with context
  String getButtonSemantic(String action, {String? context, bool? isEnabled}) {
    return VoiceOverHelper.getButtonSemantic(action, context: context, isEnabled: isEnabled);
  }

  /// Accessible color contrast checker
  bool hasGoodContrast(Color foreground, Color background) {
    return ScreenReaderSupport.hasGoodContrast(foreground, background);
  }

  /// Get accessible color variant
  Color getAccessibleColor(Color originalColor, Color backgroundColor) {
    return ScreenReaderSupport.getAccessibleColor(
      originalColor, 
      backgroundColor, 
      isHighContrastEnabled: _isHighContrastEnabled,
    );
  }

  /// High contrast theme adjustments
  ThemeData applyAccessibilityTheme(ThemeData baseTheme) {
    return ScreenReaderSupport.applyAccessibilityTheme(
      baseTheme,
      isHighContrastEnabled: _isHighContrastEnabled,
      textScaleFactor: _textScaleFactor,
    );
  }

  /// Focus management for keyboard navigation
  void announceFocus(String message) {
    VoiceOverHelper.announceFocus(message);
  }

  /// Haptic feedback for accessibility
  void accessibilityFeedback({bool isError = false}) {
    VoiceOverHelper.accessibilityFeedback(
      isError: isError,
      hasHapticFeedback: _settings.hasHapticFeedback,
    );
  }

  /// Voice-over announcements for important actions
  void announceAction(String action) {
    VoiceOverHelper.announceAction(
      action,
      hasSemanticDescriptions: _settings.hasSemanticDescriptions,
    );
  }

  /// Cultural accessibility - Right-to-Left language support
  bool isRTL(String languageCode) {
    return VoiceOverHelper.isRTL(languageCode);
  }

  TextDirection getTextDirection(String languageCode) {
    return VoiceOverHelper.getTextDirection(languageCode);
  }

  /// Accessible venue card widget
  Widget buildAccessibleVenueCard({
    required Map<String, dynamic> venue,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    final semanticLabel = getVenueSemantic(venue);
    
    return Semantics(
      label: semanticLabel,
      button: true,
      child: Card(
        child: InkWell(
          onTap: () {
            accessibilityFeedback();
            announceAction('Opening ${venue['name']} details');
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  venue['name'] ?? 'Unknown venue',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: (Theme.of(context).textTheme.titleMedium?.fontSize ?? 16) * _textScaleFactor,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Semantics(
                      label: 'Rating ${venue['rating']} out of 5 stars',
                      child: Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (venue['rating'] ?? 0) ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16 * _textScaleFactor,
                          );
                        }),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      venue['categoryName'] ?? '',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14 * _textScaleFactor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Accessible deal card widget
  Widget buildAccessibleDealCard({
    required Map<String, dynamic> deal,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    final semanticLabel = getDealSemantic(deal);
    
    return Semantics(
      label: semanticLabel,
      button: true,
      child: Card(
        child: InkWell(
          onTap: () {
            accessibilityFeedback();
            announceAction('Viewing deal: ${deal['title']}');
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Semantics(
                      label: '${deal['discount']}% discount',
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: getAccessibleColor(Colors.red, Colors.white),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${deal['discount']}% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12 * _textScaleFactor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  deal['title'] ?? 'Special offer',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: (Theme.of(context).textTheme.titleMedium?.fontSize ?? 16) * _textScaleFactor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deal['venueName'] ?? '',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14 * _textScaleFactor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Get current accessibility settings
  Map<String, dynamic> getAccessibilitySettings() {
    return _settings.getSettings();
  }

  /// Update accessibility settings
  void updateAccessibilitySettings(Map<String, dynamic> newSettings) {
    _settings.updateSettings(newSettings);
    _applySettings();
  }

  // Private helper methods

  void _detectSystemAccessibilitySettings() {
    // In a real implementation, this would check system settings
    // For now, using default values
    _isHighContrastEnabled = false;
    _isLargeTextEnabled = false;
    _isScreenReaderEnabled = false;
    _isReduceMotionEnabled = false;
  }

  void _setupAccessibilityFeatures() {
    // Setup accessibility features based on detected settings
    _applySettings();
  }

  void _applySettings() {
    _isHighContrastEnabled = _settings.isHighContrastEnabled;
    _isLargeTextEnabled = _settings.isLargeTextEnabled;
    _textScaleFactor = _settings.textScaleFactor;
    _isReduceMotionEnabled = _settings.isReduceMotionEnabled;
  }

  void _notifyAccessibilityChange() {
    // Notify widgets about accessibility changes
    // In a real implementation, this might use a state management solution
  }
}