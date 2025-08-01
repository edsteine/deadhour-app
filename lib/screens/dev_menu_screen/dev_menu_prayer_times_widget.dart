import 'package:deadhour/utils/app_theme.dart';
import 'package:flutter/material.dart';

/// Prayer times widget specifically for dev menu
class DevMenuPrayerTimesWidget extends StatelessWidget {
  final bool isVisible;

  const DevMenuPrayerTimesWidget({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.access_time, color: AppTheme.moroccoGreen),
          SizedBox(width: 8),
          Text(
            'Next: Maghrib 18:42',
            style: TextStyle(
              color: AppTheme.moroccoGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}