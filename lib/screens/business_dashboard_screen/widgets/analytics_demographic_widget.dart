import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Demographics widget showing customer age breakdown
class AnalyticsDemographicWidget extends StatelessWidget {
  const AnalyticsDemographicWidget({super.key});

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
          _buildDemographicRow('Age 18-25', '32%', AppTheme.moroccoGreen),
          _buildDemographicRow('Age 26-35', '41%', AppTheme.moroccoGold),
          _buildDemographicRow('Age 36-45', '19%', Colors.blue),
          _buildDemographicRow('Age 45+', '8%', Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDemographicRow(String category, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
            child: Text(
              category,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}