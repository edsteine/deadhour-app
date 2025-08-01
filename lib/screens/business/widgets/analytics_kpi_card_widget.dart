import 'package:flutter/material.dart';

/// KPI card widget showing key performance indicators
class AnalyticsKpiCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final Color color;
  final IconData icon;
  final bool isGood;

  const AnalyticsKpiCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.color,
    required this.icon,
    required this.isGood,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                isGood ? Icons.trending_up : Icons.trending_down,
                color: isGood ? Colors.green : Colors.red,
                size: 16,
              ),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  color: isGood ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}