import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../state/premium_role_state.dart';

class PremiumHeroSection extends StatelessWidget {
  final PremiumRoleState state;

  const PremiumHeroSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: state.scaleAnimation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppTheme.spacing24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber,
              Colors.amber.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 48,
            ),
            const SizedBox(height: AppTheme.spacing16),
            const Text(
              'Premium Role',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              state.isPremiumUser 
                  ? 'You\'re a Premium member! Enjoy all advanced features.'
                  : 'Unlock advanced features and maximize your DeadHour experience',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            if (!state.isPremiumUser) ...[
              const SizedBox(height: AppTheme.spacing20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildHeroStat('8+', 'Premium Features'),
                  _buildHeroStat('24/7', 'Support'),
                  _buildHeroStat('30%', 'More Savings'),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeroStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}