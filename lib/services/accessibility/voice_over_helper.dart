import 'package:flutter/services.dart';
import 'package:flutter/semantics.dart';

/// Voice-over and screen reader support utilities
class VoiceOverHelper {
  static bool _isScreenReaderEnabled = false;

  /// Screen reader support
  static bool get isScreenReaderEnabled => _isScreenReaderEnabled;
  
  static void setScreenReader(bool enabled) {
    _isScreenReaderEnabled = enabled;
  }

  /// Focus management for keyboard navigation
  static void announceFocus(String message) {
    if (_isScreenReaderEnabled) {
      SemanticsService.announce(message, TextDirection.ltr);
    }
  }

  /// Voice-over announcements for important actions
  static void announceAction(String action, {bool hasSemanticDescriptions = true}) {
    if (hasSemanticDescriptions) {
      SemanticsService.announce(action, TextDirection.ltr);
    }
  }

  /// Get semantic label for venues
  static String getVenueSemantic(Map<String, dynamic> venue) {
    final name = venue['name'] ?? 'Unknown venue';
    final category = venue['categoryName'] ?? 'venue';
    final rating = venue['rating']?.toString() ?? 'no rating';
    final distance = venue['distance']?.toString() ?? 'unknown distance';
    
    return '$name, $category, rated $rating stars, $distance away';
  }

  /// Get semantic label for deals
  static String getDealSemantic(Map<String, dynamic> deal) {
    final title = deal['title'] ?? 'Special offer';
    final discount = deal['discount']?.toString() ?? 'discount';
    final venue = deal['venueName'] ?? 'venue';
    final validUntil = deal['validUntil'] ?? 'limited time';
    
    return '$title, $discount percent off at $venue, valid until $validUntil';
  }

  /// Get semantic label for community rooms
  static String getRoomSemantic(Map<String, dynamic> room) {
    final name = room['name'] ?? 'Community room';
    final category = room['category'] ?? 'general';
    final memberCount = room['memberCount']?.toString() ?? 'members';
    final isActive = room['hasActiveDeals'] == true ? 'has active deals' : 'no active deals';
    
    return '$name, $category room, $memberCount members, $isActive';
  }

  /// Get semantic label for navigation items
  static String getNavigationSemantic(String routeName, bool isActive) {
    final status = isActive ? 'currently selected' : 'not selected';
    return '$routeName tab, $status';
  }

  /// Get semantic label for buttons with context
  static String getButtonSemantic(String action, {String? context, bool? isEnabled}) {
    final enabledText = isEnabled == false ? ', disabled' : '';
    final contextText = context != null ? ' for $context' : '';
    return '$action button$contextText$enabledText';
  }

  /// Haptic feedback for accessibility
  static void accessibilityFeedback({bool isError = false, bool hasHapticFeedback = true}) {
    if (hasHapticFeedback) {
      if (isError) {
        HapticFeedback.heavyImpact();
      } else {
        HapticFeedback.lightImpact();
      }
    }
  }

  /// Cultural accessibility - Right-to-Left language support
  static bool isRTL(String languageCode) {
    const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.contains(languageCode);
  }

  static TextDirection getTextDirection(String languageCode) {
    return isRTL(languageCode) ? TextDirection.rtl : TextDirection.ltr;
  }
}