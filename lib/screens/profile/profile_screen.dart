import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/theme.dart';
import '../../widgets/common/addon_toggle.dart';
import '../../widgets/cultural/prayer_times_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final addonProvider = context.watch<AddonToggleProvider>();
    
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
            _buildSimpleLoginSection(addonProvider),
            
            const SizedBox(height: 32),
            
            // ADDON switching when logged in
            if (addonProvider.isLoggedIn) ...[
              _buildAddonSwitcher(addonProvider),
              const SizedBox(height: 24),
              _buildCurrentAddonInfo(addonProvider),
              const SizedBox(height: 24),
              const PrayerTimesWidget(isVisible: true),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleLoginSection(AddonToggleProvider addonProvider) {
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
            addonProvider.isLoggedIn ? Icons.person : Icons.person_outline,
            size: 64,
            color: AppTheme.moroccoGreen,
          ),
          const SizedBox(height: 16),
          Text(
            addonProvider.isLoggedIn ? 'Welcome back!' : 'Login to DeadHour',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            addonProvider.isLoggedIn 
                ? 'Switch between different user types to explore features'
                : 'Tap the button below to login and explore ADDON features',
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
              onPressed: () => addonProvider.toggleLogin(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.moroccoGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                addonProvider.isLoggedIn ? 'Logout' : 'Login (Mock)',
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

  Widget _buildAddonSwitcher(AddonToggleProvider addonProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.moroccoGreen.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🔄 Switch User Type',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Choose different user types to see how features change:',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 16),
          AddonToggleWidget(
            provider: addonProvider,
            onAddonChanged: (addon) => addonProvider.setAddon(addon),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentAddonInfo(AddonToggleProvider addonProvider) {
    final currentAddon = addonProvider.currentAddon;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: currentAddon.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: currentAddon.color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentAddon.icon,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(width: 12),
              Text(
                currentAddon.label,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: currentAddon.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _getAddonDescription(currentAddon),
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getAddonDescription(UserAddon addon) {
    switch (addon) {
      case UserAddon.consumer:
        return 'Basic user with access to deals and community features';
      case UserAddon.business:
        return 'Business owner with dashboard and deal creation tools';
      case UserAddon.guide:
        return 'Local guide with tourism and cultural expertise features';
      case UserAddon.premium:
        return 'Premium user with all features and exclusive access';
    }
  }
}
