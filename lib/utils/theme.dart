import 'package:flutter/material.dart';

class AppTheme {
  // Morocco-specific colors
  static const Color moroccoGreen = Color(0xFF00A859);
  static const Color moroccoGold = Color(0xFFFFD700);
  static const Color moroccoRed = Color(0xFFE74C3C);
  static const Color darkGreen = Color(0xFF007A42);
  
  // Text colors
  static const Color primaryText = Color(0xFF2C3E50);
  static const Color secondaryText = Color(0xFF7F8C8D);
  static const Color lightText = Color(0xFFBDC3C7);
  
  // Background colors
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardBackground = Colors.white;
  static const Color surfaceColor = Color(0xFFF5F6FA);
  
  // Additional colors for widgets
  static const Color cardColor = Colors.white;
  static const Color shadowColor = Color(0x1A000000);

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
      
      // Card Theme
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: moroccoGreen,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
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

