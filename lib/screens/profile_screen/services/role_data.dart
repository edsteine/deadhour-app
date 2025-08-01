

import 'package:deadhour/utils/app_theme.dart';
import 'package:flutter/material.dart';

/// Central role data configuration
class RoleData {
  static const Map<UserRole, Map<String, dynamic>> roleData = {
    UserRole.consumer: {
      'title': 'Consumer',
      'subtitle': 'Discover deals and experiences',
      'icon': Icons.shopping_bag,
      'color': Colors.blue,
      'price': 'Free',
      'features': [
        'Browse and book deals',
        'Join community rooms',
        'Access to local recommendations',
        'Basic cultural calendar',
      ],
      'description': 'Perfect for tourists and locals looking for great deals during dead hours.',
    },
    UserRole.business: {
      'title': 'Business',
      'subtitle': 'Optimize revenue during dead hours',
      'icon': Icons.business,
      'color': AppTheme.moroccoGreen,
      'price': '€30/month',
      'features': [
        'Create and manage deals',
        'Revenue analytics dashboard',
        'Customer engagement tools',
        'Dead hours optimization',
        'Community integration',
      ],
      'description': 'Ideal for restaurant owners, café managers, and venue operators.',
    },
    UserRole.guide: {
      'title': 'Local Guide',
      'subtitle': 'Share expertise and earn',
      'icon': Icons.person_pin,
      'color': Colors.orange,
      'price': '€20/month',
      'features': [
        'Create cultural experiences',
        'Guide booking management',
        'Expert recommendations',
        'Commission earnings',
        'Cultural content creation',
      ],
      'description': 'Perfect for local experts, cultural ambassadors, and tour guides.',
    },
    UserRole.premium: {
      'title': 'Premium',
      'subtitle': 'Enhanced features across all roles',
      'icon': Icons.star,
      'color': Colors.amber,
      'price': '€15/month',
      'features': [
        'Priority booking access',
        'Advanced analytics',
        'Multiple role discounts',
        'Premium customer support',
        'Early access to new features',
      ],
      'description': 'Upgrade that enhances all your active roles with premium benefits.',
    },
  };
}