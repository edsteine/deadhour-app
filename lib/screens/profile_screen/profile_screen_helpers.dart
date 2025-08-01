


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/utils/app_theme.dart';

import 'package:deadhour/utils/app_colors.dart';

// Helper methods for profile screen functionality
class ProfileScreenHelpers {
  // Action Methods
  static Future<void> continueAsGuest(BuildContext context) async {
    try {
      // Enable guest mode using provider if available
      if (context.mounted) {
        final container = ProviderScope.containerOf(context);
        await container.read(guestModeProvider.notifier).enableGuestMode();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Continuing as guest - explore all features!'),
            backgroundColor: AppColors.info,
            duration: Duration(seconds: 2),
          ),
        );
        // Navigate to home
        context.go('/home');
      }
    } catch (e) {
      // Fallback to direct guest mode if provider fails
      try {
        await GuestMode.enableGuestMode();
        if (context.mounted) {
          context.go('/home');
        }
      } catch (fallbackError) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error enabling guest mode'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }

  static void editProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Text('Profile editing will be available soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement logout logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
              context.go('/splash');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  // Utility Methods
  static String formatMemberSince(DateTime joinDate) {
    final now = DateTime.now();
    final difference = now.difference(joinDate);

    if (difference.inDays < 30) {
      return '${difference.inDays}d';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}mo';
    } else {
      return '${(difference.inDays / 365).floor()}y';
    }
  }

  static String getRoleName(UserRole role) {
    switch (role) {
      case UserRole.business:
        return 'Business Owner';
      case UserRole.guide:
        return 'Local Guide';
      case UserRole.premium:
        return 'Premium Member';
      case UserRole.consumer:
      default:
        return 'Consumer';
    }
  }

  static String getRoleDescription(UserRole role) {
    switch (role) {
      case UserRole.business:
        return 'Manage venues and create deals';
      case UserRole.guide:
        return 'Share local expertise and culture';
      case UserRole.premium:
        return 'Access exclusive features and content';
      case UserRole.consumer:
      default:
        return 'Discover deals and experiences';
    }
  }

  static IconData getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.business:
        return Icons.business;
      case UserRole.guide:
        return Icons.tour;
      case UserRole.premium:
        return Icons.workspace_premium;
      case UserRole.consumer:
      default:
        return Icons.person;
    }
  }

  // Build Role-specific features
  static List<Widget> buildRoleFeatures(BuildContext context, UserRole role) {
    switch (role) {
      case UserRole.business:
        return [
          _buildFeatureListTile(
            context: context,
            icon: Icons.dashboard,
            title: 'Business Dashboard',
            subtitle: 'Manage venue and analytics',
            route: '/business',
          ),
          _buildFeatureListTile(
            context: context,
            icon: Icons.local_offer,
            title: 'Create Deal',
            subtitle: 'Post deals for dead hours',
            route: '/business/create-deal',
          ),
          _buildFeatureListTile(
            context: context,
            icon: Icons.analytics,
            title: 'Revenue Analytics',
            subtitle: 'Track performance and ROI',
            route: '/business/analytics',
          ),
        ];
      case UserRole.guide:
        return [
          _buildFeatureListTile(
            context: context,
            icon: Icons.explore,
            title: 'Guide Dashboard',
            subtitle: 'Manage guide services',
            route: '/roles/guide',
          ),
          _buildFeatureListTile(
            context: context,
            icon: Icons.tour,
            title: 'Local Expert Services',
            subtitle: 'Offer cultural guidance',
            route: '/tourism/local-expert',
          ),
        ];
      case UserRole.premium:
        return [
          _buildFeatureListTile(
            context: context,
            icon: Icons.workspace_premium,
            title: 'Premium Features',
            subtitle: 'Access exclusive content',
            route: '/tourism',
          ),
        ];
      case UserRole.consumer:
      default:
        return [
          _buildFeatureListTile(
            context: context,
            icon: Icons.local_offer,
            title: 'Browse Deals',
            subtitle: 'Discover great offers',
            route: '/home/deals',
          ),
          _buildFeatureListTile(
            context: context,
            icon: Icons.people,
            title: 'Join Communities',
            subtitle: 'Connect with others',
            route: '/community',
          ),
        ];
    }
  }

  static Widget _buildFeatureListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String route,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.moroccoGreen),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => context.go(route),
    );
  }
}
