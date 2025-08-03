import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/theme.dart';

class TouristQuickActions extends StatelessWidget {
  const TouristQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                context,
                'Find Deals',
                Icons.local_offer,
                Colors.orange,
                () => context.push('/deals'),
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: _buildQuickActionCard(
                context,
                'Local Experts',
                Icons.person_pin,
                Colors.blue,
                () => context.push('/local-expert'),
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: _buildQuickActionCard(
                context,
                'Community',
                Icons.people,
                AppTheme.moroccoGreen,
                () => context.go('/community'),
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: _buildQuickActionCard(
                context,
                'Venues',
                Icons.place,
                Colors.purple,
                () => context.push('/venues'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}