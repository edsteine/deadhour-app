import 'package:flutter/material.dart';
import 'voice_quality.dart';

extension VoiceQualityExtension on VoiceQuality {
  String get displayName {
    switch (this) {
      case VoiceQuality.excellent:
        return 'Excellent';
      case VoiceQuality.good:
        return 'Good';
      case VoiceQuality.fair:
        return 'Fair';
      case VoiceQuality.poor:
        return 'Poor';
    }
  }

  Color get color {
    switch (this) {
      case VoiceQuality.excellent:
        return const Color(0xFF4CAF50);
      case VoiceQuality.good:
        return const Color(0xFF8BC34A);
      case VoiceQuality.fair:
        return const Color(0xFFFF9800);
      case VoiceQuality.poor:
        return const Color(0xFFFF5722);
    }
  }
}