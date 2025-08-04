import 'package:flutter/material.dart';

import '../../../utils/theme.dart';
import '../services/smart_notification_service.dart';

class SmartNotificationHeader extends StatelessWidget {
  final NotificationSummary summary;

  const SmartNotificationHeader({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.moroccoGreen.withValues(alpha: 0.1),
            AppTheme.moroccoGreen.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.smart_toy,
                color: AppTheme.moroccoGreen,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Smart Notification Management',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.moroccoGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSmartStat(
                  'Reduced',
                  '${summary.reductionPercentage}%',
                  'Notification fatigue reduced',
                  Icons.trending_down,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSmartStat(
                  'Groups',
                  '${summary.groupedCount}',
                  'vs ${summary.totalNotifications} total',
                  Icons.group_work,
                  AppTheme.moroccoGreen,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSmartStat(
                  'Urgent',
                  '${summary.highPriorityCount}',
                  'Need immediate attention',
                  Icons.priority_high,
                  Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmartStat(String label, String value, String subtitle, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppTheme.secondaryText,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 8,
            color: AppTheme.lightText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}