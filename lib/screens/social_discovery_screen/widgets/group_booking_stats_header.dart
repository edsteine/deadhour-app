import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';


/// Header widget displaying group booking statistics
class GroupBookingStatsHeader extends StatelessWidget {
  final Map<String, dynamic> stats;

  const GroupBookingStatsHeader({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Active Groups',
                  '${stats['active_bookings']}',
                  Icons.group,
                  Colors.blue,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'Avg Size',
                  stats['average_group_size'],
                  Icons.people,
                  Colors.green,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'Deal Success',
                  '${stats['deal_success_rate']}%',
                  Icons.local_offer,
                  Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.savings, color: AppTheme.moroccoGreen, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Total Community Savings: ${stats['total_savings'].toStringAsFixed(0)} MAD',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
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
            color: AppTheme.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}