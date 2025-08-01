import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: AppTheme.lightText,
          ),
          SizedBox(height: 16),
          Text(
            'No notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.secondaryText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Stay tuned for updates and alerts',
            style: TextStyle(color: AppTheme.lightText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}