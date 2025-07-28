import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/user.dart';
import '../../providers/role_toggle_provider.dart';
import '../../utils/theme.dart';
import '../../providers/guest_mode_provider.dart';
import '../../widgets/cultural/prayer_times_widget.dart';
import 'profile_screen_helpers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isGuest = false;
  bool _isLoggedIn = false;
  DeadHourUser? _currentUser;

  @override
  void initState() {
    super.initState();
    _initializeUserState();
  }

  Future<void> _initializeUserState() async {
    try {
      // Initialize through provider
      final roleNotifier = ref.read(roleToggleProvider.notifier);

      setState(() {
        _isGuest = ref.read(guestModeProvider);
        _isLoggedIn = roleNotifier.isLoggedIn;

        // Mock user data for development - only if logged in and not guest
        if (_isLoggedIn && !_isGuest) {
          _currentUser = DeadHourUser(
            id: 'user_123',
            name: 'Ahmed Hassan',
            email: 'ahmed@example.com',
            phone: '+212 6XX XXX XXX',
            city: 'Casablanca',
            activeRoles: {UserRole.consumer, UserRole.business},
            profileImageUrl: null,
            joinDate: DateTime.now().subtract(const Duration(days: 30)),
          );
        } else {
          _currentUser = null;
        }
      });
    } catch (e) {
      print('Error initializing user state: $e');
      // Fallback to safe defaults
      setState(() {
        _isGuest = false;
        _isLoggedIn = false;
        _currentUser = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isGuest) ...[
            _buildGuestWelcomeSection(),
            const SizedBox(height: 24),
          ] else if (!_isLoggedIn) ...[
            _buildAuthenticationSection(),
            const SizedBox(height: 24),
          ] else ...[
            _buildUserProfileSection(),
            const SizedBox(height: 24),
            _buildRoleManagementSection(),
            const SizedBox(height: 24),
            _buildActivitySection(),
            const SizedBox(height: 24),
          ],

          _buildAppFeaturesSection(),
          const SizedBox(height: 24),
          _buildSettingsSection(),
          const SizedBox(height: 24),
          _buildSupportSection(),
          const SizedBox(height: 24),

          // Cultural integration
          const PrayerTimesWidget(isVisible: true),
        ],
      ),
    );
  }

  // Guest Mode Section
  Widget _buildGuestWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.moroccoGreen.withValues(alpha: 0.1),
            AppTheme.moroccoGold.withValues(alpha: 0.1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.explore,
                size: 32,
                color: AppTheme.moroccoGreen,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Exploring as Guest',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'You\'re currently exploring DeadHour as a guest. Create an account to unlock personalized features, save favorites, and access all roles.',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.go('/register'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.moroccoGreen,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Sign Up'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.go('/login'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.moroccoGreen,
                    side: const BorderSide(color: AppTheme.moroccoGreen),
                  ),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Authentication Section for non-logged in users
  Widget _buildAuthenticationSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
        children: [
          const Icon(
            Icons.account_circle_outlined,
            size: 80,
            color: AppTheme.moroccoGreen,
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome to DeadHour',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Morocco\'s first dual-problem platform connecting businesses and community for authentic experiences.',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => context.go('/register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.moroccoGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.person_add),
              label: const Text(
                'Create Account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context.go('/login'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.moroccoGreen,
                side: const BorderSide(color: AppTheme.moroccoGreen),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.login),
              label: const Text(
                'Login',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => ProfileScreenHelpers.continueAsGuest(context),
            child: const Text(
              'Continue as Guest',
              style: TextStyle(
                color: AppTheme.secondaryText,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // User Profile Section for logged in users
  Widget _buildUserProfileSection() {
    if (_currentUser == null) return const SizedBox.shrink();

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
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                child: _currentUser!.profileImageUrl != null
                    ? ClipOval(
                        child: Image.network(_currentUser!.profileImageUrl!,
                            fit: BoxFit.cover))
                    : Text(
                        _currentUser!.name.substring(0, 2).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.moroccoGreen,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentUser!.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _currentUser!.email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppTheme.secondaryText,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _currentUser!.city,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => ProfileScreenHelpers.editProfile(context),
                icon: const Icon(Icons.edit, color: AppTheme.moroccoGreen),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProfileStat('Active Roles',
                    _currentUser!.activeRoles.length.toString()),
                _buildProfileStat(
                    'Member Since',
                    ProfileScreenHelpers.formatMemberSince(
                        _currentUser!.joinDate)),
                _buildProfileStat('Active Roles',
                    _currentUser!.activeRoles.length.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Role Management Section
  Widget _buildRoleManagementSection() {
    if (_currentUser == null) return const SizedBox.shrink();

    final roleNotifier = ref.watch(roleToggleProvider.notifier);
    final currentRole = ref.watch(roleToggleProvider);

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
          Row(
            children: [
              const Icon(
                Icons.swap_horizontal_circle,
                color: AppTheme.moroccoGreen,
                size: 28,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Role Management',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryText,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.go('/user-type'),
                child: const Text('Add Role'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Switch between your active roles to access different features',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 20),
          ...(_currentUser!.activeRoles.map((role) {
            final isActive = role == currentRole;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isActive
                    ? AppTheme.moroccoGreen.withValues(alpha: 0.1)
                    : AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: isActive
                    ? Border.all(color: AppTheme.moroccoGreen, width: 2)
                    : null,
              ),
              child: ListTile(
                leading: Icon(
                  ProfileScreenHelpers.getRoleIcon(role),
                  color:
                      isActive ? AppTheme.moroccoGreen : AppTheme.secondaryText,
                ),
                title: Text(
                  ProfileScreenHelpers.getRoleName(role),
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color:
                        isActive ? AppTheme.moroccoGreen : AppTheme.primaryText,
                  ),
                ),
                subtitle: Text(ProfileScreenHelpers.getRoleDescription(role)),
                trailing: isActive
                    ? const Icon(Icons.check_circle,
                        color: AppTheme.moroccoGreen)
                    : const Icon(Icons.radio_button_unchecked,
                        color: AppTheme.secondaryText),
                onTap: () {
                  if (!isActive) {
                    roleNotifier.setRole(role);
                    setState(() {
                      // Role switching handled by role provider
                      // In real app this would sync with backend
                    });
                  }
                },
              ),
            );
          })),
          const SizedBox(height: 16),
          Column(
            children:
                ProfileScreenHelpers.buildRoleFeatures(context, currentRole),
          ),
        ],
      ),
    );
  }

  // Activity Section
  Widget _buildActivitySection() {
    if (_currentUser == null) return const SizedBox.shrink();

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
                Icons.history,
                color: AppTheme.moroccoGreen,
                size: 28,
              ),
              SizedBox(width: 12),
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            icon: Icons.local_offer,
            title: 'Booked deal at Café Atlas',
            subtitle: '2 hours ago • Saved 25 MAD',
            color: Colors.green,
          ),
          _buildActivityItem(
            icon: Icons.people,
            title: 'Joined 🍕 Food Community',
            subtitle: '1 day ago • Casablanca',
            color: Colors.blue,
          ),
          _buildActivityItem(
            icon: Icons.star,
            title: 'Left review for Restaurant Marrakech',
            subtitle: '3 days ago • 5 stars',
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          Center(
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Full activity history - Coming Soon')),
                );
              },
              child: const Text('View All Activity'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // App Features Section (available to all users)
  Widget _buildAppFeaturesSection() {
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
                Icons.apps,
                color: AppTheme.moroccoGreen,
                size: 28,
              ),
              SizedBox(width: 12),
              Text(
                'App Features',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFeatureGrid(),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid() {
    final features = [
      {
        'icon': Icons.local_offer,
        'title': 'Browse Deals',
        'route': '/home/deals'
      },
      {'icon': Icons.people, 'title': 'Communities', 'route': '/community'},
      {'icon': Icons.explore, 'title': 'Explore Morocco', 'route': '/tourism'},
      {'icon': Icons.favorite, 'title': 'Favorites', 'route': null},
      {'icon': Icons.history, 'title': 'Order History', 'route': null},
      {'icon': Icons.notifications, 'title': 'Notifications', 'route': null},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return GestureDetector(
          onTap: () {
            if (feature['route'] != null) {
              context.go(feature['route'] as String);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${feature['title']} - Coming Soon')),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  feature['icon'] as IconData,
                  color: AppTheme.moroccoGreen,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  feature['title'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Settings Section
  Widget _buildSettingsSection() {
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
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English, العربية, Français',
            onTap: () => context.go('/profile/settings'),
          ),
          _buildSettingsTile(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Manage notification preferences',
            onTap: () => context.go('/profile/settings'),
          ),
          _buildSettingsTile(
            icon: Icons.location_on,
            title: 'Location',
            subtitle: 'Current city: Casablanca',
            onTap: () => context.go('/profile/settings'),
          ),
          _buildSettingsTile(
            icon: Icons.privacy_tip,
            title: 'Privacy & Security',
            subtitle: 'Account security and privacy settings',
            onTap: () => context.go('/profile/settings'),
          ),
          if (_isLoggedIn && !_isGuest) ...[
            const Divider(height: 32),
            _buildSettingsTile(
              icon: Icons.logout,
              title: 'Logout',
              subtitle: 'Sign out of your account',
              onTap: () => ProfileScreenHelpers.logout(context),
              isDestructive: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
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

  // Support Section
  Widget _buildSupportSection() {
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
                Icons.support_agent,
                color: AppTheme.moroccoGreen,
                size: 28,
              ),
              SizedBox(width: 12),
              Text(
                'Support & Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSupportTile(
            icon: Icons.help_center,
            title: 'Help Center',
            subtitle: 'FAQs and guides',
          ),
          _buildSupportTile(
            icon: Icons.chat,
            title: 'Contact Support',
            subtitle: 'Get help from our team',
          ),
          _buildSupportTile(
            icon: Icons.feedback,
            title: 'Send Feedback',
            subtitle: 'Help us improve DeadHour',
          ),
          _buildSupportTile(
            icon: Icons.star_rate,
            title: 'Rate the App',
            subtitle: 'Share your experience',
          ),
          _buildSupportTile(
            icon: Icons.info,
            title: 'About DeadHour',
            subtitle: 'v1.0.0 - Morocco\'s dual-problem platform',
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Text(
                  '🇲🇦 Made with ❤️ for Morocco',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Connecting businesses and community for authentic experiences',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.moroccoGreen),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title - Coming Soon')),
        );
      },
    );
  }
}
