import 'package:flutter/material.dart';
import '../../utils/theme.dart';

enum UserAddon {
  consumer('Consumer', '🛍️', AppTheme.primaryText),
  business('Business+', '🏢', AppTheme.moroccoGreen),
  guide('Guide+', '🧭', AppTheme.moroccoGold),
  premium('Premium', '💎', Colors.purple);

  const UserAddon(this.label, this.icon, this.color);

  final String label;
  final String icon;
  final Color color;
}

class AddonToggleProvider extends ChangeNotifier {
  UserAddon _currentAddon = UserAddon.consumer;
  bool _isLoggedIn = false;

  UserAddon get currentAddon => _currentAddon;
  bool get isLoggedIn => _isLoggedIn;

  void setAddon(UserAddon addon) {
    _currentAddon = addon;
    notifyListeners();
  }

  void toggleLogin() {
    _isLoggedIn = !_isLoggedIn;
    if (!_isLoggedIn) {
      _currentAddon = UserAddon.consumer;
    }
    notifyListeners();
  }

  bool hasFeatureAccess(String feature) {
    if (!_isLoggedIn) return false;
    
    switch (feature) {
      case 'business_dashboard':
        return _currentAddon == UserAddon.business;
      case 'guide_features':
        return _currentAddon == UserAddon.guide;
      case 'premium_tourism':
        return _currentAddon == UserAddon.premium;
      case 'basic_features':
        return true;
      default:
        return false;
    }
  }
}

class AddonToggleWidget extends StatelessWidget {
  final AddonToggleProvider provider;
  final Function(UserAddon) onAddonChanged;

  const AddonToggleWidget({
    super.key,
    required this.provider,
    required this.onAddonChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (!provider.isLoggedIn) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppTheme.hintText.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: UserAddon.values.map((addon) {
          final isSelected = provider.currentAddon == addon;
          
          return Expanded(
            child: GestureDetector(
              onTap: () => onAddonChanged(addon),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  vertical: AppTheme.spacing12,
                  horizontal: AppTheme.spacing8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? addon.color : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge - 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      addon.icon,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      addon.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.white : AppTheme.secondaryText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class MockAuthSection extends StatelessWidget {
  final AddonToggleProvider provider;
  final VoidCallback onToggleLogin;

  const MockAuthSection({
    super.key,
    required this.provider,
    required this.onToggleLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacing16),
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.moroccoGreen.withValues(alpha: 0.1),
            AppTheme.moroccoGold.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(
          color: AppTheme.moroccoGreen.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                provider.isLoggedIn ? Icons.person : Icons.person_outline,
                color: AppTheme.moroccoGreen,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                '🧪 Demo Mode',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.moroccoGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Switch(
                value: provider.isLoggedIn,
                onChanged: (value) => onToggleLogin(),
                activeColor: AppTheme.moroccoGreen,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          Text(
            provider.isLoggedIn 
                ? 'You\'re now logged in! Switch between ADDONs to see different features.'
                : 'Toggle this switch to simulate logging in and explore ADDON features.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.secondaryText,
            ),
          ),
          if (provider.isLoggedIn) ...[
            const SizedBox(height: AppTheme.spacing16),
            Text(
              'Current User Type:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.lightText,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Row(
              children: [
                Text(
                  provider.currentAddon.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  provider.currentAddon.label,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: provider.currentAddon.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}