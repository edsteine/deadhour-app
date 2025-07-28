import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/theme.dart';
import '../../services/morocco_cultural_service.dart';

class PrayerTimesWidget extends ConsumerWidget {
  final bool isVisible;
  final bool showCompact;

  const PrayerTimesWidget({
    super.key,
    this.isVisible = true,
    this.showCompact = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isVisible) return const SizedBox.shrink();

    return ListenableBuilder(
      listenable: MoroccoCulturalService(),
      builder: (context, child) {
        final culturalService = MoroccoCulturalService();

        if (!culturalService.isInitialized) {
          return const SizedBox.shrink();
        }

        final nextPrayer = culturalService.getNextPrayer();

        if (showCompact) {
          return _buildCompactView(nextPrayer);
        }

        return _buildFullView(nextPrayer);
      },
    );
  }

  Widget _buildCompactView(NextPrayerInfo nextPrayer) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.access_time,
            size: 16,
            color: AppTheme.moroccoGreen,
          ),
          const SizedBox(width: 6),
          Text(
            'Next: ${nextPrayer.name}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryText,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            _formatTimeUntil(nextPrayer.timeUntil),
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.moroccoGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullView(NextPrayerInfo nextPrayer) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing16,
        vertical: AppTheme.spacing8,
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.prayerTime, AppColors.prayerActive],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppColors.prayerTime.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Prayer icon
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: const Icon(
              Icons.mosque,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),

          // Prayer info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next Prayer: ${nextPrayer.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  '${_formatTimeUntil(nextPrayer.timeUntil)} • ${_formatTime(nextPrayer.time)}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Qibla indicator
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.navigation,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  'Qibla',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  String _formatTimeUntil(Duration duration) {
    if (duration.inDays > 0) {
      return 'in ${duration.inDays}d ${duration.inHours % 24}h';
    } else if (duration.inHours > 0) {
      return 'in ${duration.inHours}h ${duration.inMinutes % 60}m';
    } else {
      return 'in ${duration.inMinutes}m';
    }
  }
}

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
