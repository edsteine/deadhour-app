import '../../../utils/theme.dart';
import 'package:flutter/material.dart';

enum UserRole {
  consumer,
  business,
  guide,
  premium,
  driver,
  host,
  chef,
  photographer;

  Color get color {
    switch (this) {
      case UserRole.consumer:
        return Colors.blueGrey;
      case UserRole.business:
        return AppTheme.moroccoGreen;
      case UserRole.guide:
        return AppColors.tourismCategory;
      case UserRole.premium:
        return AppTheme.moroccoGold;
      case UserRole.driver:
        return Colors.deepOrange;
      case UserRole.host:
        return Colors.indigo;
      case UserRole.chef:
        return Colors.brown;
      case UserRole.photographer:
        return Colors.purple;
    }
  }

  String get icon {
    switch (this) {
      case UserRole.consumer:
        return '👤';
      case UserRole.business:
        return '🏢';
      case UserRole.guide:
        return '🌍';
      case UserRole.premium:
        return '⭐';
      case UserRole.driver:
        return '🚗';
      case UserRole.host:
        return '🏠';
      case UserRole.chef:
        return '👨‍🍳';
      case UserRole.photographer:
        return '📸';
    }
  }

  String get label {
    switch (this) {
      case UserRole.consumer:
        return 'Consumer';
      case UserRole.business:
        return 'Business';
      case UserRole.guide:
        return 'Guide';
      case UserRole.premium:
        return 'Premium';
      case UserRole.driver:
        return 'Driver';
      case UserRole.host:
        return 'Host';
      case UserRole.chef:
        return 'Chef';
      case UserRole.photographer:
        return 'Photographer';
    }
  }
}