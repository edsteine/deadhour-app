import 'package:flutter/material.dart';

class AnalyticsPeakHoursWidget extends StatelessWidget {
  const AnalyticsPeakHoursWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildPeakHourRow('12:00 - 14:00', '89%', Colors.green),
          _buildPeakHourRow('19:00 - 21:00', '76%', Colors.orange),
          _buildPeakHourRow('15:00 - 17:00', '45%', Colors.blue),
          _buildPeakHourRow('21:00 - 23:00', '34%', Colors.red),
        ],
      ),
    );
  }

  Widget _buildPeakHourRow(String timeRange, String utilization, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            timeRange,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              utilization,
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