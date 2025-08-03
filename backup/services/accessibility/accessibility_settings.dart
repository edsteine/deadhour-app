/// Accessibility settings management
class AccessibilitySettings {
  // Accessibility preferences
  final Map<String, dynamic> _settings = {
    'high_contrast': false,
    'large_text': false,
    'screen_reader_hints': true,
    'reduce_motion': false,
    'text_scale_factor': 1.0,
    'semantic_descriptions': true,
    'haptic_feedback': true,
  };

  /// Get current accessibility settings
  Map<String, dynamic> getSettings() {
    return Map.from(_settings);
  }

  /// Update accessibility settings
  void updateSettings(Map<String, dynamic> newSettings) {
    _settings.addAll(newSettings);
  }

  /// Get specific setting value
  T? getSetting<T>(String key) {
    return _settings[key] as T?;
  }

  /// Set specific setting value
  void setSetting(String key, dynamic value) {
    _settings[key] = value;
  }

  /// High contrast mode
  bool get isHighContrastEnabled => _settings['high_contrast'] ?? false;
  set isHighContrastEnabled(bool value) => _settings['high_contrast'] = value;

  /// Large text support
  bool get isLargeTextEnabled => _settings['large_text'] ?? false;
  set isLargeTextEnabled(bool value) => _settings['large_text'] = value;

  /// Screen reader hints
  bool get hasScreenReaderHints => _settings['screen_reader_hints'] ?? true;
  set hasScreenReaderHints(bool value) => _settings['screen_reader_hints'] = value;

  /// Motion reduction
  bool get isReduceMotionEnabled => _settings['reduce_motion'] ?? false;
  set isReduceMotionEnabled(bool value) => _settings['reduce_motion'] = value;

  /// Text scale factor
  double get textScaleFactor => _settings['text_scale_factor'] ?? 1.0;
  set textScaleFactor(double value) => _settings['text_scale_factor'] = value.clamp(0.8, 2.0);

  /// Semantic descriptions
  bool get hasSemanticDescriptions => _settings['semantic_descriptions'] ?? true;
  set hasSemanticDescriptions(bool value) => _settings['semantic_descriptions'] = value;

  /// Haptic feedback
  bool get hasHapticFeedback => _settings['haptic_feedback'] ?? true;
  set hasHapticFeedback(bool value) => _settings['haptic_feedback'] = value;
}