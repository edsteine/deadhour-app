import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';

/// App bar theming and styling configurations
class DeadHourAppBarTheme {
  
  /// Default app bar colors
  static const Color defaultBackgroundColor = AppTheme.moroccoGreen;
  static const Color defaultForegroundColor = Colors.white;
  static const double defaultElevation = 0;

  /// Title text styles
  static const TextStyle standardTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: defaultForegroundColor,
  );

  static const TextStyle businessTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle tourismTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle guideTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle premiumTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle lightTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppTheme.primaryText,
  );

  /// Subtitle text styles
  static TextStyle get standardSubtitleStyle => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: defaultForegroundColor.withValues(alpha: 0.8),
  );

  static TextStyle get businessSubtitleStyle => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white.withValues(alpha: 0.8),
  );

  static TextStyle get tourismSubtitleStyle => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white.withValues(alpha: 0.8),
  );

  static TextStyle get guideSubtitleStyle => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white.withValues(alpha: 0.8),
  );

  static TextStyle get premiumSubtitleStyle => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black87.withValues(alpha: 0.7),
  );

  static TextStyle get lightSubtitleStyle => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppTheme.primaryText.withValues(alpha: 0.7),
  );

  /// Get title style by role
  static TextStyle getTitleStyleByRole(String role) {
    switch (role.toLowerCase()) {
      case 'business':
        return businessTitleStyle;
      case 'tourism':
      case 'tourist':
        return tourismTitleStyle;
      case 'guide':
      case 'cultural':
        return guideTitleStyle;
      case 'premium':
        return premiumTitleStyle;
      case 'light':
        return lightTitleStyle;
      default:
        return standardTitleStyle;
    }
  }

  /// Get subtitle style by role
  static TextStyle getSubtitleStyleByRole(String role) {
    switch (role.toLowerCase()) {
      case 'business':
        return businessSubtitleStyle;
      case 'tourism':
      case 'tourist':
        return tourismSubtitleStyle;
      case 'guide':
      case 'cultural':
        return guideSubtitleStyle;
      case 'premium':
        return premiumSubtitleStyle;
      case 'light':
        return lightSubtitleStyle;
      default:
        return standardSubtitleStyle;
    }
  }

  /// Get background color by role
  static Color getBackgroundColorByRole(String role) {
    switch (role.toLowerCase()) {
      case 'business':
        return Colors.blue;
      case 'tourism':
      case 'tourist':
        return Colors.orange;
      case 'guide':
      case 'cultural':
        return Colors.purple;
      case 'premium':
        return AppTheme.moroccoGold;
      case 'light':
        return Colors.white;
      default:
        return defaultBackgroundColor;
    }
  }

  /// Get foreground color by role
  static Color getForegroundColorByRole(String role) {
    switch (role.toLowerCase()) {
      case 'premium':
        return Colors.black87;
      case 'light':
        return AppTheme.primaryText;
      default:
        return defaultForegroundColor;
    }
  }
}