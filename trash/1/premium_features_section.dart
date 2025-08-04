import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

/// Premium features grid section
class PremiumFeaturesSection extends StatelessWidget {
  const PremiumFeaturesSection({super.key});

  static const List<Map<String, dynamic>> _premiumFeatures = [
    {
      'icon': Icons.flash_on,
      'title': 'Priority Booking Access',
      'description': 'Skip the queue and get first access to limited deals',
      'color': Colors.orange,
    },
    {
      'icon': Icons.analytics,
      'title': 'Advanced Analytics',
      'description': 'Detailed insights across all your active roles',
      'color': Colors.blue,
    },
    {
      'icon': Icons.support_agent,
      'title': 'Premium Support',
      'description': '24/7 priority customer support and live chat',
      'color': AppTheme.moroccoGreen,
    },
    {
      'icon': Icons.star,
      'title': 'Exclusive Deals',
      'description': 'Access to premium-only deals and experiences',
      'color': Colors.amber,
    },
    {
      'icon': Icons.people_alt,
      'title': 'Multi-Role Optimization',
      'description': 'Smart suggestions for role combinations and savings',
      'color': Colors.purple,
    },
    {
      'icon': Icons.rocket_launch,
      'title': 'Early Access',
      'description': 'Beta features and new releases before everyone else',
      'color': Colors.red,
    },
    {
      'icon': Icons.verified,
      'title': 'Verified Badge',
      'description': 'Stand out with premium verification badge',
      'color': Colors.blue,
    },
    {
      'icon': Icons.trending_up,
      'title': 'Revenue Boost',
      'description': 'Enhanced promotion for business and guide roles',
      'color': AppTheme.moroccoGreen,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Premium Features',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: AppTheme.spacing12,
            mainAxisSpacing: AppTheme.spacing12,
          ),
          itemCount: _premiumFeatures.length,
          itemBuilder: (context, index) {
            final feature = _premiumFeatures[index];
            return _buildFeatureCard(feature);
          },
        ),
      ],
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing8),
              decoration: BoxDecoration(
                color: (feature['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Icon(
                feature['icon'] as IconData,
                color: feature['color'] as Color,
                size: 24,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            Text(
              feature['title'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Expanded(
              child: Text(
                feature['description'] as String,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}