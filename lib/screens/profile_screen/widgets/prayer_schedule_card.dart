import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';
import 'package:deadhour/utils/app_colors.dart';


class PrayerScheduleCard extends StatelessWidget {
  const PrayerScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    final prayers = [
      {'name': 'Fajr', 'time': '05:30', 'status': 'completed'},
      {'name': 'Dhuhr', 'time': '13:15', 'status': 'current'},
      {'name': 'Asr', 'time': '15:45', 'status': 'upcoming'},
      {'name': 'Maghrib', 'time': '18:30', 'status': 'upcoming'},
      {'name': 'Isha', 'time': '20:00', 'status': 'upcoming'},
    ];

    return Container(
      margin: const EdgeInsets.all(AppTheme.spacing16),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: AppColors.prayerTime,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              const Text(
                'Prayer Schedule',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryText,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8,
                  vertical: AppTheme.spacing4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: const Text(
                  'Casablanca',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Prayer times list
          ...prayers.map((prayer) => _buildPrayerTimeItem(
                prayer['name']!,
                prayer['time']!,
                prayer['status']!,
              )),
        ],
      ),
    );
  }

  Widget _buildPrayerTimeItem(String name, String time, String status) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'completed':
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle;
        break;
      case 'current':
        statusColor = AppColors.prayerActive;
        statusIcon = Icons.radio_button_checked;
        break;
      default:
        statusColor = AppTheme.lightText;
        statusIcon = Icons.radio_button_unchecked;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 16,
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight:
                    status == 'current' ? FontWeight.w600 : FontWeight.w400,
                color: status == 'current'
                    ? AppTheme.primaryText
                    : AppTheme.secondaryText,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              fontWeight:
                  status == 'current' ? FontWeight.w600 : FontWeight.w400,
              color: status == 'current' ? statusColor : AppTheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}