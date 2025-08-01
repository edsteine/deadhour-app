import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

class MonthlyNetworkEffectsWidget extends StatelessWidget {
  const MonthlyNetworkEffectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🌐 This Month\'s Network Effects:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildMetricRow('Social Discovery → Booking:', '89%'),
          _buildMetricRow('Business Success → Community:', '78%'),
          _buildMetricRow('Tourist-Local Connections:', '234'),
          _buildMetricRow('Cross-Category Usage:', '67%'),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppTheme.secondaryText),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.moroccoGreen,
            ),
          ),
        ],
      ),
    );
  }
}