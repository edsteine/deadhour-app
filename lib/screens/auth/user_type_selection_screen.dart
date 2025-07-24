import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../utils/guest_mode.dart';

class UserTypeSelectionScreen extends StatefulWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  State<UserTypeSelectionScreen> createState() => _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen> {
  String? _selectedUserType;

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
                'Choose Your Experience',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryText,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select the type that best describes you to get personalized features and content.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.secondaryText,
                    ),
              ),
              const SizedBox(height: 48),

              // User type cards
              Expanded(
                child: ListView.builder(
                  itemCount: AppConstants.userTypes.length,
                  itemBuilder: (context, index) {
                    final userType = AppConstants.userTypes[index];
                    final isSelected = _selectedUserType == userType['id'];

                    return _buildUserTypeCard(
                      userType: userType,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedUserType = userType['id'];
                        });
                      },
                    );
                  },
                ),
              ),

              // Continue button (for registration)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedUserType != null ? () => _continueWithUserType() : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
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

  Widget _buildUserTypeCard({
    required Map<String, String> userType,
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
                    userType['icon']!,
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
                    Text(
                      userType['name']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? AppTheme.moroccoGreen : AppTheme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userType['description']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildUserTypeFeatures(userType['id']!),
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

  Widget _buildUserTypeFeatures(String userTypeId) {
    List<String> features = [];

    switch (userTypeId) {
      case 'local':
        features = ['Community rooms', 'Local deals', 'Social discovery'];
        break;
      case 'tourist':
        features = ['Premium features', 'Local experts', 'Cultural guides'];
        break;
      case 'business':
        features = ['Create deals', 'Analytics', 'Revenue optimization'];
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

  void _continueWithUserType() {
    // Store selected user type in shared preferences or state management
    // For now, navigate to registration with user type parameter
    context.go('/register?userType=$_selectedUserType');
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
