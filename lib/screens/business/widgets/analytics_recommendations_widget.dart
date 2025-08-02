import 'package:flutter/material.dart';

class AnalyticsRecommendationsWidget extends StatelessWidget {
  const AnalyticsRecommendationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRecommendationCard(
          Icons.schedule,
          'Optimize Dead Hours',
          'Consider offering 20% more discount during 3-5 PM to increase utilization',
          Colors.orange,
        ),
        const SizedBox(height: 12),
        _buildRecommendationCard(
          Icons.people,
          'Target Tourists',
          'Your tourist customer rating is high. Consider tourist-specific deals',
          Colors.blue,
        ),
        const SizedBox(height: 12),
        _buildRecommendationCard(
          Icons.trending_up,
          'Group Bookings',
          'Group bookings show 35% higher profit margins. Promote group deals',
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(IconData icon, String title, String description, Color color) {
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}