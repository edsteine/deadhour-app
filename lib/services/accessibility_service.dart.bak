import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/semantics.dart';

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

  // Accessibility preferences
  final Map<String, dynamic> _accessibilitySettings = {
    'high_contrast': false,
    'large_text': false,
    'screen_reader_hints': true,
    'reduce_motion': false,
    'text_scale_factor': 1.0,
    'semantic_descriptions': true,
    'haptic_feedback': true,
  };

  /// Initialize accessibility service and detect system settings
  void initialize() {
    _detectSystemAccessibilitySettings();
    _setupAccessibilityFeatures();
  }

  /// High contrast mode management
  bool get isHighContrastEnabled => _isHighContrastEnabled;
  
  void setHighContrast(bool enabled) {
    _isHighContrastEnabled = enabled;
    _accessibilitySettings['high_contrast'] = enabled;
    _notifyAccessibilityChange();
  }

  /// Large text support
  bool get isLargeTextEnabled => _isLargeTextEnabled;
  double get textScaleFactor => _textScaleFactor;
  
  void setLargeText(bool enabled) {
    _isLargeTextEnabled = enabled;
    _textScaleFactor = enabled ? 1.3 : 1.0;
    _accessibilitySettings['large_text'] = enabled;
    _accessibilitySettings['text_scale_factor'] = _textScaleFactor;
    _notifyAccessibilityChange();
  }

  void setTextScaleFactor(double factor) {
    _textScaleFactor = factor.clamp(0.8, 2.0);
    _accessibilitySettings['text_scale_factor'] = _textScaleFactor;
    _notifyAccessibilityChange();
  }

  /// Screen reader support
  bool get isScreenReaderEnabled => _isScreenReaderEnabled;
  
  void setScreenReader(bool enabled) {
    _isScreenReaderEnabled = enabled;
    _accessibilitySettings['screen_reader_hints'] = enabled;
  }

  /// Motion reduction for accessibility
  bool get isReduceMotionEnabled => _isReduceMotionEnabled;
  
  void setReduceMotion(bool enabled) {
    _isReduceMotionEnabled = enabled;
    _accessibilitySettings['reduce_motion'] = enabled;
  }

  /// Get semantic label for venues
  String getVenueSemantic(Map<String, dynamic> venue) {
    final name = venue['name'] ?? 'Unknown venue';
    final category = venue['categoryName'] ?? 'venue';
    final rating = venue['rating']?.toString() ?? 'no rating';
    final distance = venue['distance']?.toString() ?? 'unknown distance';
    
    return '$name, $category, rated $rating stars, $distance away';
  }

  /// Get semantic label for deals
  String getDealSemantic(Map<String, dynamic> deal) {
    final title = deal['title'] ?? 'Special offer';
    final discount = deal['discount']?.toString() ?? 'discount';
    final venue = deal['venueName'] ?? 'venue';
    final validUntil = deal['validUntil'] ?? 'limited time';
    
    return '$title, $discount percent off at $venue, valid until $validUntil';
  }

  /// Get semantic label for community rooms
  String getRoomSemantic(Map<String, dynamic> room) {
    final name = room['name'] ?? 'Community room';
    final category = room['category'] ?? 'general';
    final memberCount = room['memberCount']?.toString() ?? 'members';
    final isActive = room['hasActiveDeals'] == true ? 'has active deals' : 'no active deals';
    
    return '$name, $category room, $memberCount members, $isActive';
  }

  /// Get semantic label for navigation items
  String getNavigationSemantic(String routeName, bool isActive) {
    final status = isActive ? 'currently selected' : 'not selected';
    return '$routeName tab, $status';
  }

  /// Get semantic label for buttons with context
  String getButtonSemantic(String action, {String? context, bool? isEnabled}) {
    final enabledText = isEnabled == false ? ', disabled' : '';
    final contextText = context != null ? ' for $context' : '';
    return '$action button$contextText$enabledText';
  }

  /// Accessible color contrast checker
  bool hasGoodContrast(Color foreground, Color background) {
    final fgLuminance = foreground.computeLuminance();
    final bgLuminance = background.computeLuminance();
    
    final lighter = fgLuminance > bgLuminance ? fgLuminance : bgLuminance;
    final darker = fgLuminance > bgLuminance ? bgLuminance : fgLuminance;
    
    final contrastRatio = (lighter + 0.05) / (darker + 0.05);
    return contrastRatio >= 4.5; // WCAG AA standard
  }

  /// Get accessible color variant
  Color getAccessibleColor(Color originalColor, Color backgroundColor) {
    if (!_isHighContrastEnabled) return originalColor;
    
    if (!hasGoodContrast(originalColor, backgroundColor)) {
      // Adjust color for better contrast
      final isLight = backgroundColor.computeLuminance() > 0.5;
      return isLight ? Colors.black87 : Colors.white;
    }
    
    return originalColor;
  }

  /// High contrast theme adjustments
  ThemeData applyAccessibilityTheme(ThemeData baseTheme) {
    if (!_isHighContrastEnabled) return baseTheme;
    
    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: Colors.blue[700], // Higher contrast primary
        onPrimary: Colors.white,
        secondary: Colors.orange[700], // Higher contrast secondary
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black87,
      ),
      textTheme: baseTheme.textTheme.apply(
        displayColor: Colors.black87,
        bodyColor: Colors.black87,
        fontSizeFactor: _textScaleFactor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue[700],
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16 * _textScaleFactor,
          ),
        ),
      ),
    );
  }

  /// Focus management for keyboard navigation
  void announceFocus(String message) {
    if (_isScreenReaderEnabled) {
      SemanticsService.announce(message, TextDirection.ltr);
    }
  }

  /// Haptic feedback for accessibility
  void accessibilityFeedback({bool isError = false}) {
    if (_accessibilitySettings['haptic_feedback']) {
      if (isError) {
        HapticFeedback.heavyImpact();
      } else {
        HapticFeedback.lightImpact();
      }
    }
  }

  /// Voice-over announcements for important actions
  void announceAction(String action) {
    if (_accessibilitySettings['semantic_descriptions']) {
      SemanticsService.announce(action, TextDirection.ltr);
    }
  }

  /// Cultural accessibility - Right-to-Left language support
  bool isRTL(String languageCode) {
    const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.contains(languageCode);
  }

  TextDirection getTextDirection(String languageCode) {
    return isRTL(languageCode) ? TextDirection.rtl : TextDirection.ltr;
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
    return Map.from(_accessibilitySettings);
  }

  /// Update accessibility settings
  void updateAccessibilitySettings(Map<String, dynamic> newSettings) {
    _accessibilitySettings.addAll(newSettings);
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
    _isHighContrastEnabled = _accessibilitySettings['high_contrast'] ?? false;
    _isLargeTextEnabled = _accessibilitySettings['large_text'] ?? false;
    _textScaleFactor = _accessibilitySettings['text_scale_factor'] ?? 1.0;
    _isReduceMotionEnabled = _accessibilitySettings['reduce_motion'] ?? false;
  }

  void _notifyAccessibilityChange() {
    // Notify widgets about accessibility changes
    // In a real implementation, this might use a state management solution
  }
}

/// Accessibility-focused widgets

class AccessibleFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String semanticLabel;
  final String? tooltip;

  const AccessibleFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.semanticLabel,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final accessibilityService = AccessibilityService();
    
    return Semantics(
      label: semanticLabel,
      button: true,
      child: FloatingActionButton(
        onPressed: () {
          accessibilityService.accessibilityFeedback();
          accessibilityService.announceAction(semanticLabel);
          onPressed();
        },
        tooltip: tooltip,
        child: child,
      ),
    );
  }
}

class AccessibleTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final List<String> semanticLabels;

  const AccessibleTabBar({
    super.key,
    required this.tabs,
    required this.semanticLabels,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final accessibilityService = AccessibilityService();
    
    return TabBar(
      controller: controller,
      tabs: tabs.asMap().entries.map((entry) {
        final index = entry.key;
        final tab = entry.value;
        final semanticLabel = index < semanticLabels.length 
            ? semanticLabels[index] 
            : 'Tab ${index + 1}';
        
        return Semantics(
          label: semanticLabel,
          button: true,
          selected: controller?.index == index,
          child: tab,
        );
      }).toList(),
      labelStyle: TextStyle(
        fontSize: 14 * accessibilityService.textScaleFactor,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14 * accessibilityService.textScaleFactor,
      ),
    );
  }
}

class AccessibleBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;
  final List<String> semanticLabels;

  const AccessibleBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.semanticLabels,
  });

  @override
  Widget build(BuildContext context) {
    final accessibilityService = AccessibilityService();
    
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        final label = index < semanticLabels.length 
            ? semanticLabels[index] 
            : 'Tab ${index + 1}';
        accessibilityService.accessibilityFeedback();
        accessibilityService.announceAction('Switched to $label');
        onTap(index);
      },
      items: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final semanticLabel = index < semanticLabels.length 
            ? accessibilityService.getNavigationSemantic(semanticLabels[index], currentIndex == index)
            : 'Navigation item ${index + 1}';
        
        return BottomNavigationBarItem(
          icon: Semantics(
            label: semanticLabel,
            child: item.icon,
          ),
          activeIcon: Semantics(
            label: semanticLabel,
            child: item.activeIcon,
          ),
          label: item.label,
        );
      }).toList(),
      selectedLabelStyle: TextStyle(
        fontSize: 12 * accessibilityService.textScaleFactor,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12 * accessibilityService.textScaleFactor,
      ),
    );
  }
}