import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class RoleStackingBenefits extends StatelessWidget {
  const RoleStackingBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.layers,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                SizedBox(width: AppTheme.spacing12),
                Text(
                  'Role Stacking Benefits',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Stacking examples
            _buildStackingExample(
              'Business + Guide',
              'Venue owner who offers cultural tours',
              '€45/month',
              '€50/month',
              Icons.business,
              Icons.person_pin,
            ),
            
            const SizedBox(height: AppTheme.spacing12),
            
            _buildStackingExample(
              'Business + Premium',
              'Enhanced analytics and priority support',
              '€40/month',
              '€45/month',
              Icons.business,
              Icons.star,
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Text(
                      'Save money by combining roles! Multi-role users get automatic discounts.',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStackingExample(
    String combination,
    String description,
    String bundlePrice,
    String originalPrice,
    IconData icon1,
    IconData icon2,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Icon(icon1, color: AppTheme.moroccoGreen, size: 20),
              const SizedBox(width: AppTheme.spacing4),
              const Icon(Icons.add, color: Colors.grey, size: 16),
              const SizedBox(width: AppTheme.spacing4),
              Icon(icon2, color: Colors.orange, size: 20),
            ],
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  combination,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                bundlePrice,
                style: const TextStyle(
                  color: AppTheme.moroccoGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                originalPrice,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}