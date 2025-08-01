import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Premium subscription management section
class PremiumManagementSection extends StatelessWidget {
  final VoidCallback onBillingDetails;
  final VoidCallback onCancel;

  const PremiumManagementSection({
    super.key,
    required this.onBillingDetails,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Premium Subscription',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            const ListTile(
              leading: Icon(Icons.star, color: Colors.amber),
              title: Text('Premium Plan Active'),
              subtitle: Text('Next billing: March 15, 2024'),
              contentPadding: EdgeInsets.zero,
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onBillingDetails,
                    child: const Text('Billing Details'),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    child: const Text('Cancel Plan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}