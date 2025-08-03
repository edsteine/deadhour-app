import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class PremiumManagementSection extends StatelessWidget {
  final VoidCallback onShowBillingDetails;
  final VoidCallback onShowCancelDialog;

  const PremiumManagementSection({
    super.key,
    required this.onShowBillingDetails,
    required this.onShowCancelDialog,
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
                    onPressed: onShowBillingDetails,
                    child: const Text('Billing Details'),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onShowCancelDialog,
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

  static void showBillingDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Billing Details'),
        content: const Text(
          'Next billing: March 15, 2024\n'
          'Amount: €15.00\n'
          'Payment method: **** 1234\n'
          'Billing address: Casablanca, Morocco',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Would navigate to billing management
            },
            child: const Text('Manage'),
          ),
        ],
      ),
    );
  }

  static void showCancelDialog(BuildContext context, VoidCallback onCancel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Premium'),
        content: const Text(
          'Are you sure you want to cancel your Premium subscription? You\'ll lose access to all premium features at the end of your current billing period.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep Premium'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onCancel();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cancel Subscription'),
          ),
        ],
      ),
    );
  }
}