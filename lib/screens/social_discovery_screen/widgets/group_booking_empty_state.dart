import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Empty state widget for group booking tabs
class GroupBookingEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const GroupBookingEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.group_off, size: 64, color: AppTheme.lightText),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: AppTheme.lightText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}