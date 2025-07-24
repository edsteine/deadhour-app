import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../utils/guest_mode.dart';

class AddonMarketplaceScreen extends StatefulWidget {
  const AddonMarketplaceScreen({super.key});

  @override
  State<AddonMarketplaceScreen> createState() => _AddonMarketplaceScreenState();
}

class _AddonMarketplaceScreenState extends State<AddonMarketplaceScreen> {
  Set<String> _selectedAddons = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                onPressed: () => context.go('/onboarding'),
                icon: const Icon(Icons.arrow_back),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 24),

              // Header
              Text(
                'Welcome to ADDON Marketplace',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryText,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start as Consumer and add ADDONs to unlock capabilities. Each ADDON generates €30-€15/month revenue.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.secondaryText,
                    ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '🚀 Following success patterns: Airbnb (€75B) + Instagram (2B users) + Facebook (3B users)',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.moroccoGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // ADDON cards
              Expanded(
                child: ListView.builder(
                  itemCount: AppConstants.availableAddons.length,
                  itemBuilder: (context, index) {
                    final addon = AppConstants.availableAddons[index];
                    final isSelected = _selectedAddons.contains(addon['id']);

                    return _buildAddonCard(
                      addon: addon,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedAddons.remove(addon['id']);
                          } else {
                            _selectedAddons.add(addon['id']!);
                          }
                        });
                      },
                    );
                  },
                ),
              ),

              // Continue button (create universal account)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _createUniversalAccount(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _selectedAddons.isEmpty 
                        ? 'Create Consumer Account (Free)'
                        : 'Create Account with ADDONs (€${_calculateMonthlyRevenue()}/month)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Continue as Guest button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _continueAsGuest(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: AppTheme.moroccoGreen),
                  ),
                  child: const Text(
                    'Continue as Guest',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.moroccoGreen,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Login option
              Center(
                child: TextButton(
                  onPressed: () => context.go('/login'),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: AppTheme.secondaryText,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            color: AppTheme.moroccoGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddonCard({
    required Map<String, String> addon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.moroccoGreen.withValues(alpha: 0.1) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppTheme.moroccoGreen : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.moroccoGreen : AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    addon['icon']!,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          addon['name']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? AppTheme.moroccoGreen : AppTheme.primaryText,
                          ),
                        ),
                        Spacer(),
                        Text(
                          addon['price']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.moroccoGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      addon['description']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildAddonFeatures(addon['id']!),
                  ],
                ),
              ),

              // Selection indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.moroccoGreen : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppTheme.moroccoGreen : Colors.grey.shade400,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddonFeatures(String addonId) {
    List<String> features = [];

    switch (addonId) {
      case 'business':
        features = ['Venue management', 'Deal creation', 'Analytics dashboard'];
        break;
      case 'guide':
        features = ['Local expertise', 'Cultural guidance', 'Tourism services'];
        break;
      case 'premium':
        features = ['Enhanced features', 'Cross-ADDON analytics', 'Priority support'];
        break;
    }

    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: features.map((feature) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            feature,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.moroccoGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  void _createUniversalAccount() {
    // Create universal DeadHour account with selected ADDONs
    // Store selected addons in user profile
    final addonsQuery = _selectedAddons.join(',');
    context.go('/register?addons=$addonsQuery');
  }

  int _calculateMonthlyRevenue() {
    int total = 0;
    for (String addonId in _selectedAddons) {
      switch (addonId) {
        case 'business':
          total += 30;
          break;
        case 'guide':
          total += 20;
          break;
        case 'premium':
          total += 15;
          break;
      }
    }
    return total;
  }

  void _continueAsGuest() async {
    // Enable guest mode
    await GuestMode.enableGuestMode();
    
    // Navigate directly to home as guest user
    if (mounted) {
      context.go('/home');
    }
  }
}
