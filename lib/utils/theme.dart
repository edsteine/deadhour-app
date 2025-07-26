import 'package:flutter/material.dart';

class AppTheme {
  // Professional Morocco-inspired palette
  static const Color moroccoGreen = Color(0xFF00A859);
  static const Color moroccoGold = Color(0xFFD4AF37); // More sophisticated gold
  static const Color moroccoRed = Color(0xFFD32F2F); // Refined red
  static const Color darkGreen = Color(0xFF00712D);
  static const Color lightGreen = Color(0xFFE8F5E8);
  static const Color darkBlue = Color(0xFF1A1A1A); // Using primaryText color
  static const Color accentColor = Color(0xFFD4AF37); // Using moroccoGold color
  static const Color nearlyWhite = Color(0xFFFFFFFF); // Pure white
  
  // Professional text hierarchy
  static const Color primaryText = Color(0xFF1A1A1A); // Darker for better contrast
  static const Color secondaryText = Color(0xFF666666);
  static const Color lightText = Color(0xFF999999);
  static const Color hintText = Color(0xFFCCCCCC);
  
  // Background system
  static const Color backgroundColor = Color(0xFFF8FFFE); // Subtle green tint
  static const Color cardBackground = Colors.white;
  static const Color cardColor = Colors.white; // Legacy support
  static const Color surfaceColor = Color(0xFFF5F8F7);
  static const Color overlayColor = Color(0x0D000000);
  
  // Elevation and depth
  static const Color shadowColor = Color(0x1A000000);
  static const Color lightShadow = Color(0x08000000);
  static const Color mediumShadow = Color(0x14000000);
  
  // Spacing system (8px grid)
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  
  // Border radius system
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: moroccoGreen,
        brightness: Brightness.light,
      ),
      primaryColor: moroccoGreen,
      scaffoldBackgroundColor: backgroundColor,
      
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: moroccoGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      
      // Professional Card Theme
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 2,
        shadowColor: lightShadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: spacing16, 
          vertical: spacing8,
        ),
      ),
      
      // Professional Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: moroccoGreen,
          foregroundColor: Colors.white,
          elevation: 3,
          shadowColor: mediumShadow,
          padding: const EdgeInsets.symmetric(
            horizontal: spacing24, 
            vertical: spacing16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: moroccoGreen,
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: moroccoGreen, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: moroccoGreen,
        unselectedItemColor: secondaryText,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryText,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: primaryText,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: primaryText,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryText,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: primaryText,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: primaryText,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: primaryText,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: primaryText,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: secondaryText,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: lightText,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: moroccoGreen,
        brightness: Brightness.dark,
      ),
      primaryColor: moroccoGreen,
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    );
  }
}

// Custom colors for specific use cases
class AppColors {
  static const Color primary = Color(0xFF00A859); // Morocco Green
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);
  
  // Deal status colors
  static const Color activeDeals = Color(0xFFE74C3C);
  static const Color upcomingDeals = Color(0xFFF39C12);
  static const Color expiredDeals = Color(0xFF95A5A6);
  
  // Prayer time colors
  static const Color prayerTime = Color(0xFF8E44AD);
  static const Color prayerActive = Color(0xFF9B59B6);
  
  // Room category colors
  static const Color foodCategory = Color(0xFFE67E22);
  static const Color entertainmentCategory = Color(0xFF3498DB);
  static const Color wellnessCategory = Color(0xFF1ABC9C);
  static const Color sportsCategory = Color(0xFF2ECC71);
  static const Color tourismCategory = Color(0xFFE91E63);
  static const Color familyCategory = Color(0xFF9C27B0);
  
  // Online status color
  static const Color online = Color(0xFF2ECC71);
}

// Design System Constants
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  // Specific spacing
  static const double cardPadding = 16.0;
  static const double screenPadding = 20.0;
  static const double sectionSpacing = 24.0;
  static const double itemSpacing = 12.0;
}

class AppBorderRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double circular = 50.0;
  
  // Specific radii
  static const double card = 12.0;
  static const double button = 8.0;
  static const double dialog = 16.0;
}

