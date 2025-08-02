import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/theme.dart';

class GuestWelcomeSection extends StatelessWidget {
  const GuestWelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
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
}