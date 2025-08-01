import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

class SocialStatsHeader extends StatelessWidget {
  final int experiencesCount;

  const SocialStatsHeader({
    super.key,
    required this.experiencesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              '$experiencesCount',
              'Experiences',
              Icons.explore,
              AppTheme.moroccoGreen,
            ),
          ),
          Expanded(
            child: _buildStatItem(
              '127',
              'Active Hosts',
              Icons.people,
              AppTheme.moroccoGold,
            ),
          ),
          Expanded(
            child: _buildStatItem(
              '89%',
              'Success Rate',
              Icons.star,
              Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
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
    );
  }
}
