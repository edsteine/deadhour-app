import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';
import '../../providers/role_toggle_provider.dart';
import '../../utils/theme.dart';
import '../../widgets/cultural/prayer_times_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final roleNotifier = ref.watch(roleToggleProvider.notifier);
    final isLoggedIn = roleNotifier.isLoggedIn;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppTheme.moroccoGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Simple login section
            _buildSimpleLoginSection(),
            
            const SizedBox(height: 24),
            
            // Role switching section - only show when logged in
            if (isLoggedIn) ...[
              _buildRoleSwitchingSection(),
              const SizedBox(height: 24),
            ],
            
            // Cultural integration
            const PrayerTimesWidget(isVisible: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleLoginSection() {
    final roleNotifier = ref.watch(roleToggleProvider.notifier);
    final isLoggedIn = roleNotifier.isLoggedIn;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            // addonProvider.isLoggedIn ? Icons.person : Icons.person_outline,
            Icons.person_outline, // Placeholder
            size: 64,
            color: AppTheme.moroccoGreen,
          ),
          const SizedBox(height: 16),
          Text(
            // addonProvider.isLoggedIn ? 'Welcome back!' : 'Login to DeadHour',
            'Login to DeadHour', // Placeholder
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isLoggedIn 
                ? 'You are logged in. Switch between different roles to explore features'
                : 'Tap the button below to login and explore Role features',
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                roleNotifier.toggleLogin();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.moroccoGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isLoggedIn ? 'Logout' : 'Login (Mock)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSwitchingSection() {
    final roleNotifier = ref.watch(roleToggleProvider.notifier);
    final currentRole = ref.watch(roleToggleProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.swap_horiz,
                color: AppTheme.moroccoGreen,
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'Switch Roles',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Manage your active roles and subscription plans',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 16),
          ...roleNotifier.activeRoles.map((role) {
            return RadioListTile<UserRole>(
              title: Text(role.toString().split('.').last),
              value: role,
              groupValue: currentRole,
              onChanged: (UserRole? value) {
                if (value != null) {
                  roleNotifier.setRole(value);
                }
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
