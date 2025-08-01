



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




// Import modular widgets









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
          // Authentication section for guests/non-logged in users
          if (_isGuest || !_isLoggedIn) ...[
            ProfileAuthWidget(isGuest: _isGuest),
            const SizedBox(height: 24),
          ],

          // User profile section for logged in users
          if (_isLoggedIn && !_isGuest && _currentUser != null) ...[
            ProfileHeaderWidget(
              user: _currentUser!,
              onEditPressed: () => ProfileScreenHelpers.editProfile(context),
            ),
            const SizedBox(height: 24),
            
            // Role management section
            const RoleToggleWidget(),
            const SizedBox(height: 24),
            
            
            // Role management section
            ProfileRoleManagementWidget(user: _currentUser!),
            const SizedBox(height: 24),
            
            // Activity section
            const ProfileActivityWidget(),
            const SizedBox(height: 24),
          ],

          // App features section (available to all users)
          const ProfileAppFeaturesWidget(),
          const SizedBox(height: 24),
          
          // Settings section
          ProfileSettingsWidget(
            isLoggedIn: _isLoggedIn,
            isGuest: _isGuest,
            onLogoutTap: () => ProfileScreenHelpers.logout(context),
          ),
          const SizedBox(height: 24),
          
          // Support section
          const ProfileSupportWidget(),
          const SizedBox(height: 24),

          // Cultural integration
          const PrayerTimesWidget(),
        ],
      ),
    );
  }

}