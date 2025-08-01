import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

/// Competitor comparison widget
class AnalyticsCompetitorWidget extends StatelessWidget {
  const AnalyticsCompetitorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _buildCompetitorMetric('Revenue per sqm', 'You: 1,200 MAD',
              'Market avg: 980 MAD', true),
          const Divider(),
          _buildCompetitorMetric(
              'Customer Rating', 'You: 4.7★', 'Market avg: 4.2★', true),
          const Divider(),
          _buildCompetitorMetric(
              'Pricing', 'You: 125 MAD', 'Market avg: 135 MAD', false),
          const Divider(),
          _buildCompetitorMetric(
              'Wait Time', 'You: 8 min', 'Market avg: 12 min', true),
        ],
      ),
    );
  }

  Widget _buildCompetitorMetric(
      String metric, String yours, String market, bool isBetter) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metric,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  yours,
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        isBetter ? AppTheme.moroccoGreen : AppTheme.moroccoRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  market,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isBetter ? Icons.check_circle : Icons.warning,
            color: isBetter ? AppTheme.moroccoGreen : AppTheme.moroccoGold,
          ),
        ],
      ),
    );
  }
}