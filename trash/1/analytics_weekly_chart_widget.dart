import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

/// Weekly chart widget showing occupancy data
class AnalyticsWeeklyChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> weeklyTraffic;

  const AnalyticsWeeklyChartWidget({
    super.key,
    required this.weeklyTraffic,
  });

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daily Occupancy %',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Peak: ${weeklyTraffic.map((d) => d['occupancy'] as int).reduce((a, b) => a > b ? a : b)}%',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: weeklyTraffic.map((day) {
                final occupancy = day['occupancy'] as int;
                final height = (occupancy / 100) * 120;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$occupancy%',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 20,
                      height: height,
                      decoration: BoxDecoration(
                        color: occupancy > 70
                            ? AppTheme.moroccoGreen
                            : occupancy > 40
                                ? AppTheme.moroccoGold
                                : AppTheme.moroccoRed,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      day['day'] as String,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}