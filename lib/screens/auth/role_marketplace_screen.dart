import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../utils/guest_mode.dart';

class RoleMarketplaceScreen extends StatefulWidget {
  const RoleMarketplaceScreen({super.key});

  @override
  State<RoleMarketplaceScreen> createState() => _RoleMarketplaceScreenState();
}

class _RoleMarketplaceScreenState extends State<RoleMarketplaceScreen> {
  final Set<String> _selectedRoles = {};

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
                'Welcome to Role Marketplace',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryText,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose your roles to unlock capabilities. Everything is completely free.',
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
                child: const Text(
                  '🚀 Following success patterns: Airbnb (€75B) + Instagram (2B users) + Facebook (3B users)',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.moroccoGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // Role cards
              Expanded(
                child: ListView.builder(
                  itemCount: AppConstants.availableRoles.length,
                  itemBuilder: (context, index) {
                    final role = AppConstants.availableRoles[index];
                    final isSelected = _selectedRoles.contains(role['id']);

                    return _buildRoleCard(
                      role: role,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedRoles.remove(role['id']);
                          } else {
                            _selectedRoles.add(role['id']!);
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
                  child: const Text(
                    'Create Free Account',
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

  Widget _buildRoleCard({
    required Map<String, String> role,
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
            color: isSelected
                ? AppTheme.moroccoGreen.withValues(alpha: 0.1)
                : Colors.white,
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
                  color: isSelected
                      ? AppTheme.moroccoGreen
                      : AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    role['icon']!,
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
                          role['name']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? AppTheme.moroccoGreen
                                : AppTheme.primaryText,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          role['price']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.moroccoGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      role['description']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildRoleFeatures(role['id']!),
                  ],
                ),
              ),

              // Selection indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppTheme.moroccoGreen : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.moroccoGreen
                        : Colors.grey.shade400,
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

  Widget _buildRoleFeatures(String roleId) {
    List<String> features = [];

    switch (roleId) {
      case 'business':
        features = ['Venue management', 'Deal creation', 'Analytics dashboard'];
        break;
      case 'guide':
        features = ['Local expertise', 'Cultural guidance', 'Tourism services'];
        break;
      case 'premium':
        features = [
          'Enhanced features',
          'Cross-Role analytics',
          'Priority support'
        ];
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
    // Create universal DeadHour account with selected roles
    // Store selected roles in user profile
    final rolesQuery = _selectedRoles.join(',');
    context.go('/register?roles=$rolesQuery');
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
