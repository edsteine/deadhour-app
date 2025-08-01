import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';


class TopNetworkMultipliersWidget extends StatelessWidget {
  const TopNetworkMultipliersWidget({super.key});

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
            '🏆 Top Network Multipliers:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildMultiplierItem(
              '1.', '#coffee-afternoon-deals', '156 bookings', Icons.coffee),
          _buildMultiplierItem(
              '2.', '#cultural-experiences', '89 tourism€', Icons.attractions),
          _buildMultiplierItem(
              '3.', '#escape-rooms-weekend', '67 groups', Icons.games),
        ],
      ),
    );
  }

  Widget _buildMultiplierItem(
      String rank, String room, String metric, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            rank,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.moroccoGreen,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, color: AppTheme.secondaryText, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              room,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            metric,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.moroccoGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}