import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class PlatformHealthMetricsWidget extends StatelessWidget {
  const PlatformHealthMetricsWidget({super.key});

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
            '📈 Platform Health Metrics:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildHealthMetric('Network Effects Score:', '8.7/10', true),
          _buildHealthMetric('Viral Growth Rate:', '1.34x', true),
          _buildHealthMetric('Cross-Problem LTV:', '247€', true),
          _buildHealthMetric('Community Health:', '4.8/5', true),
        ],
      ),
    );
  }

  Widget _buildHealthMetric(String label, String value, bool isHealthy) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppTheme.secondaryText),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isHealthy ? AppTheme.moroccoGreen : Colors.orange,
                ),
              ),
              const SizedBox(width: 4),
              if (isHealthy)
                const Icon(
                  Icons.check_circle,
                  color: AppTheme.moroccoGreen,
                  size: 16,
                ),
            ],
          ),
        ],
      ),
    );
  }
}