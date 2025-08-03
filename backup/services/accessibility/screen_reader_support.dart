import 'package:flutter/material.dart';

/// Screen reader support and high contrast utilities
class ScreenReaderSupport {
  /// Accessible color contrast checker
  static bool hasGoodContrast(Color foreground, Color background) {
    final fgLuminance = foreground.computeLuminance();
    final bgLuminance = background.computeLuminance();
    
    final lighter = fgLuminance > bgLuminance ? fgLuminance : bgLuminance;
    final darker = fgLuminance > bgLuminance ? bgLuminance : fgLuminance;
    
    final contrastRatio = (lighter + 0.05) / (darker + 0.05);
    return contrastRatio >= 4.5; // WCAG AA standard
  }

  /// Get accessible color variant
  static Color getAccessibleColor(Color originalColor, Color backgroundColor, {bool isHighContrastEnabled = false}) {
    if (!isHighContrastEnabled) return originalColor;
    
    if (!hasGoodContrast(originalColor, backgroundColor)) {
      // Adjust color for better contrast
      final isLight = backgroundColor.computeLuminance() > 0.5;
      return isLight ? Colors.black87 : Colors.white;
    }
    
    return originalColor;
  }

  /// High contrast theme adjustments
  static ThemeData applyAccessibilityTheme(ThemeData baseTheme, {
    bool isHighContrastEnabled = false,
    double textScaleFactor = 1.0,
  }) {
    if (!isHighContrastEnabled) return baseTheme;
    
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
        fontSizeFactor: textScaleFactor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue[700],
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16 * textScaleFactor,
          ),
        ),
      ),
    );
  }
}