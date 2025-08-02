import 'package:flutter/material.dart';

class AnalyticsWeeklyChartWidget extends StatelessWidget {
  const AnalyticsWeeklyChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily Revenue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '€12,450',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _buildChartBars(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((day) => Text(
                      day,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChartBars() {
    final data = [0.6, 0.8, 0.4, 0.9, 1.0, 0.7, 0.5]; // Relative heights
    final colors = [
      Colors.blue.shade300,
      Colors.blue.shade400,
      Colors.blue.shade200,
      Colors.blue.shade500,
      Colors.blue.shade600,
      Colors.blue.shade400,
      Colors.blue.shade300,
    ];

    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final height = entry.value;
      return Container(
        width: 24,
        height: 120 * height,
        decoration: BoxDecoration(
          color: colors[index],
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }).toList();
  }
}