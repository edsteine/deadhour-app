import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/theme.dart';
import '../profile_screen_helpers.dart';

class AuthenticationSection extends StatelessWidget {
  const AuthenticationSection({super.key});

  @override
  Widget build(BuildContext context) {
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
}