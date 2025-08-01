import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';


/// Peak hours widget showing customer traffic patterns
class AnalyticsPeakHoursWidget extends StatelessWidget {
  const AnalyticsPeakHoursWidget({super.key});

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
          _buildPeakHourRow(
              '12:00-14:00', 'Lunch Rush', '89%', AppTheme.moroccoGreen),
          _buildPeakHourRow(
              '19:00-21:00', 'Dinner Time', '76%', AppTheme.moroccoGold),
          _buildPeakHourRow(
              '15:00-17:00', 'Afternoon Coffee', '34%', AppTheme.moroccoRed),
          _buildPeakHourRow(
              '21:00-23:00', 'Late Night', '28%', Colors.grey),
        ],
      ),
    );
  }

  Widget _buildPeakHourRow(
      String time, String label, String occupancy, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              occupancy,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}