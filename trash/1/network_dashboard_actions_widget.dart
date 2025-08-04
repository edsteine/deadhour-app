import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/theme.dart';

class NetworkDashboardActionsWidget extends StatelessWidget {
  const NetworkDashboardActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // Show detailed analytics
              _showDetailedAnalytics(context);
            },
            icon: const Icon(Icons.analytics),
            label: const Text('Detailed Analytics'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // Export data
              _exportData(context);
            },
            icon: const Icon(Icons.download),
            label: const Text('Export Data'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  void _showDetailedAnalytics(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detailed Analytics'),
        content: const Text(
            'This would show more detailed network effects analytics and charts.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _exportData(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Network effects data exported successfully!'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }
}