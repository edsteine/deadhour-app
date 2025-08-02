import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/models/user.dart';
import 'package:deadhour/providers/role_toggle_provider.dart';
import 'package:deadhour/providers/guest_mode_provider.dart';
import 'package:deadhour/widgets/cultural/prayer_times_widget.dart';
import 'package:deadhour/screens/profile/widgets/guest_welcome_section.dart';
import 'package:deadhour/screens/profile/widgets/authentication_section.dart';
import 'package:deadhour/screens/profile/widgets/user_profile_section.dart';
import 'package:deadhour/screens/profile/widgets/role_management_section.dart';
import 'package:deadhour/screens/profile/widgets/activity_section.dart';
import 'package:deadhour/screens/profile/widgets/app_features_section.dart';
import 'package:deadhour/screens/profile/widgets/settings_section.dart';
import 'package:deadhour/screens/profile/widgets/support_section.dart';

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
          if (_isGuest) ...[
            const GuestWelcomeSection(),
            const SizedBox(height: 24),
          ] else if (!_isLoggedIn) ...[
            const AuthenticationSection(),
            const SizedBox(height: 24),
          ] else ...[
            UserProfileSection(currentUser: _currentUser),
            const SizedBox(height: 24),
            RoleManagementSection(currentUser: _currentUser),
            const SizedBox(height: 24),
            ActivitySection(currentUser: _currentUser),
            const SizedBox(height: 24),
          ],

          const AppFeaturesSection(),
          const SizedBox(height: 24),
          SettingsSection(
            isLoggedIn: _isLoggedIn,
            isGuest: _isGuest,
          ),
          const SizedBox(height: 24),
          const SupportSection(),
          const SizedBox(height: 24),

          // Cultural integration
          const PrayerTimesWidget(),
        ],
      ),
    );
  }
}