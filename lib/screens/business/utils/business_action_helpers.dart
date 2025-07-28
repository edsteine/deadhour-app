import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class BusinessActionHelpers {
  static void showOptimizationSuggestions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI Optimization Suggestions'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🎯 Targeted Deal Recommendations:'),
              SizedBox(height: 8),
              Text('• 25% off lunch combos (14:00-16:00)'),
              Text('• Buy-2-get-1 coffee deals (15:00-17:00)'),
              Text('• Happy hour pricing (20:00-22:00)'),
              SizedBox(height: 16),
              Text('📱 Marketing Boost:'),
              SizedBox(height: 8),
              Text('• Auto-post to social media during deals'),
              Text('• Send push notifications to nearby users'),
              Text('• Partner with local offices for bulk orders'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Optimization plan activated!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Activate All'),
          ),
        ],
      ),
    );
  }

  static void createTargetedDeal(
      BuildContext context, Map<String, dynamic> hour) {
    // Navigate to create deal screen with pre-filled time slot
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Creating targeted deal for ${hour['time']}...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  static void optimizeTimeSlot(
      BuildContext context, Map<String, dynamic> hour) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Optimize ${hour['time']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select optimization strategy:'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('Price Discount'),
              subtitle: const Text('20-30% off regular prices'),
              onTap: () =>
                  BusinessActionHelpers.applyOptimization(context, 'discount'),
            ),
            ListTile(
              leading: const Icon(Icons.group_add),
              title: const Text('Group Incentives'),
              subtitle: const Text('Deals for parties of 3+'),
              onTap: () =>
                  BusinessActionHelpers.applyOptimization(context, 'group'),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Loyalty Points'),
              subtitle: const Text('Double loyalty rewards'),
              onTap: () =>
                  BusinessActionHelpers.applyOptimization(context, 'loyalty'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  static void applyPricingRecommendation(
      BuildContext context, String timeSlot) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Applied pricing recommendation for $timeSlot'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  static void enableAutomatedPromotions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable Automated Promotions'),
        content: const Text(
          'AI will automatically create and launch promotions based on:\n\n'
          '• Low occupancy periods\n'
          '• Weather conditions\n'
          '• Local events\n'
          '• Competitor pricing\n\n'
          'You can review and approve before each launch.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Automated promotions enabled!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Enable'),
          ),
        ],
      ),
    );
  }

  static void togglePromotion(String title, bool value) {
    // This method doesn't need BuildContext if it only shows a SnackBar
    // If it needs to navigate or show dialogs, it will need BuildContext
    // For now, assuming it only shows SnackBar
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('$title ${value ? 'activated' : 'deactivated'}'),
    //     backgroundColor: value ? Colors.green : Colors.orange,
    //   ),
    // );
  }

  static void createFromTemplate(BuildContext context, String template) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Creating promotion from $template template...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  static void generateNewInsights(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generating new AI insights...'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  static void implementInsight(BuildContext context, String insight) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Implementing: $insight'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  static void applyOptimization(BuildContext context, String strategy) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Applied $strategy optimization strategy'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }
}
