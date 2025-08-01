import 'package:flutter/material.dart';

/// User notification preferences
class UserNotificationPreferences {
  final bool enableSmartGrouping;
  final Duration digestFrequency;
  final Set<String> mutedTypes;
  final Map<String, String> typePriorities;
  final bool enableQuietHours;
  final TimeOfDay quietStart;
  final TimeOfDay quietEnd;

  UserNotificationPreferences({
    required this.enableSmartGrouping,
    required this.digestFrequency,
    required this.mutedTypes,
    required this.typePriorities,
    required this.enableQuietHours,
    required this.quietStart,
    required this.quietEnd,
  });
}