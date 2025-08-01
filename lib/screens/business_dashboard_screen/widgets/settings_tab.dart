import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';
import 'package:deadhour/utils/app_colors.dart';

class SettingsTab extends StatelessWidget {
  final Function() showPremiumUpgrade;
  final Function() signOut;

  const SettingsTab({
    super.key,
    required this.showPremiumUpgrade,
    required this.signOut,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Business Information'),
          const SizedBox(height: AppTheme.spacing12),
          _buildBusinessSettings(),
          const SizedBox(height: AppTheme.spacing24),
          _buildSectionHeader('Notification Settings'),
          const SizedBox(height: AppTheme.spacing12),
          _buildNotificationSettings(),
          const SizedBox(height: AppTheme.spacing24),
          _buildSectionHeader('Account Management'),
          const SizedBox(height: AppTheme.spacing12),
          _buildAccountSettings(context),
        ],
      ),
    );
  }

  Widget _buildBusinessSettings() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('Business Details'),
            subtitle: const Text('Name, address, contact info'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Operating Hours'),
            subtitle: const Text('Set your business hours'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Photos & Media'),
            subtitle: const Text('Manage venue photos'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.book_online),
            title: const Text('New Bookings'),
            subtitle: const Text('Get notified of new bookings'),
            value: true,
            onChanged: (value) {},
            activeColor: AppTheme.moroccoGreen,
          ),
          const Divider(height: 1),
          SwitchListTile(
            secondary: const Icon(Icons.star),
            title: const Text('Reviews'),
            subtitle: const Text('Get notified of new reviews'),
            value: true,
            onChanged: (value) {},
            activeColor: AppTheme.moroccoGreen,
          ),
          const Divider(height: 1),
          SwitchListTile(
            secondary: const Icon(Icons.analytics),
            title: const Text('Analytics Reports'),
            subtitle: const Text('Weekly performance reports'),
            value: false,
            onChanged: (value) {},
            activeColor: AppTheme.moroccoGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.workspace_premium,
                color: AppTheme.moroccoGold),
            title: const Text('Upgrade to Premium'),
            subtitle: const Text('Get more features and analytics'),
            trailing: const Icon(Icons.chevron_right),
            onTap: showPremiumUpgrade,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            subtitle: const Text('Get help with your account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text('Sign Out'),
            subtitle: const Text('Sign out of business account'),
            onTap: signOut,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
