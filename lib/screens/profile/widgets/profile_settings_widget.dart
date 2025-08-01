import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/theme.dart';
import '../profile_screen_helpers.dart';

/// Settings section widget for profile screen
class ProfileSettingsWidget extends StatelessWidget {
  final bool isLoggedIn;
  final bool isGuest;
  final VoidCallback? onLogoutTap;

  const ProfileSettingsWidget({
    super.key,
    required this.isLoggedIn,
    required this.isGuest,
    this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.settings,
                color: AppTheme.moroccoGreen,
                size: 28,
              ),
              SizedBox(width: 12),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsTile(
            context,
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English, العربية, Français',
            onTap: () => context.go('/profile/settings'),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Manage notification preferences',
            onTap: () => context.go('/profile/settings'),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.location_on,
            title: 'Location',
            subtitle: 'Current city: Casablanca',
            onTap: () => context.go('/profile/settings'),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.privacy_tip,
            title: 'Privacy & Security',
            subtitle: 'Account security and privacy settings',
            onTap: () => context.go('/profile/settings'),
          ),
          if (isLoggedIn && !isGuest)
          if (isLoggedIn && !isGuest) ...[
            const Divider(height: 32),
            _buildSettingsTile(
              context,
              icon: Icons.logout,
              title: 'Logout',
              subtitle: 'Sign out of your account',
              onTap: onLogoutTap ?? () => ProfileScreenHelpers.logout(context),
              isDestructive: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : AppTheme.moroccoGreen,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : AppTheme.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}