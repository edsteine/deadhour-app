import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../home/main_navigation_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _currentUser = MockData.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeadHourAppBar(
        title: 'Profile',
        actions: [
          IconButton(
            onPressed: _showSettings,
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            _buildProfileHeader(),

            // Stats section
            _buildStatsSection(),

            // Quick actions
            _buildQuickActions(),

            // Menu items
            _buildMenuItems(),

            // Bottom padding
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.moroccoGreen, AppTheme.darkGreen],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          // Profile picture
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(_currentUser.profilePicture),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // User info
          Text(
            _currentUser.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentUser.userTypeIcon,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                _currentUser.userTypeDisplay,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: Colors.white70,
              ),
              const SizedBox(width: 4),
              Text(
                _currentUser.city,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Member since and rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileStat(
                icon: Icons.calendar_today,
                label: 'Member since',
                value: _currentUser.memberSince,
              ),
              const SizedBox(width: 32),
              _buildProfileStat(
                icon: Icons.star,
                label: 'Rating',
                value: '${_currentUser.rating}★',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.white70,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Activity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.local_fire_department,
                  title: '${_currentUser.stats['dealsUsed']}',
                  subtitle: 'Deals Used',
                  color: AppColors.error,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.savings,
                  title: '${_currentUser.stats['totalSaved']} MAD',
                  subtitle: 'Total Saved',
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.forum,
                  title: '${_currentUser.stats['roomsJoined']}',
                  subtitle: 'Rooms Joined',
                  color: AppColors.info,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.people,
                  title: '${_currentUser.stats['connectionsCount']}',
                  subtitle: 'Connections',
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionButton(
              icon: Icons.edit,
              label: 'Edit Profile',
              onTap: _editProfile,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionButton(
              icon: Icons.share,
              label: 'Share Profile',
              onTap: _shareProfile,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionButton(
              icon: Icons.qr_code,
              label: 'QR Code',
              onTap: _showQRCode,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: AppTheme.moroccoGreen),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      {
        'icon': Icons.bookmark_outline,
        'title': 'Saved Deals',
        'subtitle': 'Your bookmarked deals',
        'onTap': () => _showSavedDeals(),
      },
      {
        'icon': Icons.history,
        'title': 'Deal History',
        'subtitle': 'Previously used deals',
        'onTap': () => _showDealHistory(),
      },
      {
        'icon': Icons.people_outline,
        'title': 'My Connections',
        'subtitle': 'Friends and contacts',
        'onTap': () => _showConnections(),
      },
      {
        'icon': Icons.workspace_premium,
        'title': 'Premium Features',
        'subtitle': 'Upgrade your experience',
        'onTap': () => _showPremiumFeatures(),
        'trailing': Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppTheme.moroccoGold,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'UPGRADE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      },
      {
        'icon': Icons.notifications_outlined,
        'title': 'Notifications',
        'subtitle': 'Manage your alerts',
        'onTap': () => _showNotificationSettings(),
      },
      {
        'icon': Icons.privacy_tip_outlined,
        'title': 'Privacy & Security',
        'subtitle': 'Account security settings',
        'onTap': () => _showPrivacySettings(),
      },
      {
        'icon': Icons.help_outline,
        'title': 'Help & Support',
        'subtitle': 'Get help or contact us',
        'onTap': () => _showHelpSupport(),
      },
      {
        'icon': Icons.info_outline,
        'title': 'About DeadHour',
        'subtitle': 'App info and terms',
        'onTap': () => _showAbout(),
      },
      {
        'icon': Icons.logout,
        'title': 'Sign Out',
        'subtitle': 'Log out of your account',
        'onTap': () => _signOut(),
        'textColor': AppColors.error,
      },
    ];

    return Container(
      margin: const EdgeInsets.all(16),
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
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: Colors.grey.shade200,
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            leading: Icon(
              item['icon'] as IconData,
              color: item['textColor'] as Color? ?? AppTheme.moroccoGreen,
            ),
            title: Text(
              item['title'] as String,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: item['textColor'] as Color? ?? AppTheme.primaryText,
              ),
            ),
            subtitle: Text(
              item['subtitle'] as String,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryText,
              ),
            ),
            trailing: item['trailing'] as Widget? ?? const Icon(Icons.chevron_right, color: AppTheme.lightText),
            onTap: item['onTap'] as VoidCallback,
          );
        },
      ),
    );
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: const Text('English'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
                activeColor: AppTheme.moroccoGreen,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Location Services'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
                activeColor: AppTheme.moroccoGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Bio',
                hintText: 'Tell us about yourself',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _shareProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile shared successfully!'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showQRCode() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your QR Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(
                  Icons.qr_code,
                  size: 100,
                  color: AppTheme.lightText,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Share this QR code to connect with other users',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSavedDeals() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Saved deals feature not implemented in mockup'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showDealHistory() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deal history feature not implemented in mockup'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showConnections() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Connections feature not implemented in mockup'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showPremiumFeatures() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.workspace_premium, color: AppTheme.moroccoGold),
            SizedBox(width: 8),
            Text('Premium Features'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Unlock premium features:'),
            SizedBox(height: 8),
            Text('• Access to premium rooms'),
            Text('• Local expert connections'),
            Text('• Priority deal notifications'),
            Text('• Ad-free experience'),
            Text('• Advanced filters'),
            SizedBox(height: 16),
            Text(
              'Pricing:\n75 MAD/month for locals\n450 MAD/month for tourists',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.secondaryText,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Premium upgrade not implemented in mockup'),
                  backgroundColor: AppColors.info,
                ),
              );
            },
            child: const Text('Upgrade Now'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification settings not implemented in mockup'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showPrivacySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Privacy settings not implemented in mockup'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showHelpSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Help & support not implemented in mockup'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About DeadHour'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DeadHour Morocco',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Version 1.0.0'),
            SizedBox(height: 16),
            Text(
              'Morocco\'s first dual-problem platform connecting businesses with customers during off-peak hours while building community through social discovery.',
            ),
            SizedBox(height: 16),
            Text(
              '© 2024 DeadHour Morocco. All rights reserved.',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryText,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _signOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
