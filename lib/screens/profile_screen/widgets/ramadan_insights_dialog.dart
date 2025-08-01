import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

class RamadanInsightsDialog {
  static void show(BuildContext context, Map<String, dynamic> insights) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.lightbulb, color: AppTheme.moroccoGold),
            SizedBox(width: 8),
            Text('Ramadan Business Insights'),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Key Insights:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...insights['keyInsights'].map<Widget>((insight) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(color: AppTheme.moroccoGold)),
                      Expanded(child: Text(insight, style: const TextStyle(fontSize: 14))),
                    ],
                  ),
                )),
                const SizedBox(height: 16),
                const Text(
                  'Action Items:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...insights['actionItems'].map<Widget>((action) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, size: 16, color: AppTheme.moroccoGreen),
                      const SizedBox(width: 6),
                      Expanded(child: Text(action, style: const TextStyle(fontSize: 14))),
                    ],
                  ),
                )),
                const SizedBox(height: 16),
                const Text(
                  'Success Metrics:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...insights['successMetrics'].map<Widget>((metric) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.timeline, size: 16, color: AppTheme.moroccoGold),
                      const SizedBox(width: 6),
                      Expanded(child: Text(metric, style: const TextStyle(fontSize: 14))),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}