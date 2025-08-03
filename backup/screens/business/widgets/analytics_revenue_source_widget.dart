import 'package:flutter/material.dart';

class AnalyticsRevenueSourceWidget extends StatelessWidget {
  const AnalyticsRevenueSourceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sources = [
      {'name': 'Dead Hour Deals', 'amount': '€4,280', 'percentage': 34, 'color': Colors.green},
      {'name': 'Regular Pricing', 'amount': '€6,170', 'percentage': 50, 'color': Colors.blue},
      {'name': 'Group Bookings', 'amount': '€1,500', 'percentage': 12, 'color': Colors.orange},
      {'name': 'Events', 'amount': '€500', 'percentage': 4, 'color': Colors.purple},
    ];

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
        children: sources.map((source) => _buildRevenueSourceRow(
          source['name'] as String,
          source['amount'] as String,
          source['percentage'] as int,
          source['color'] as Color,
        )).toList(),
      ),
    );
  }

  Widget _buildRevenueSourceRow(String name, String amount, int percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}