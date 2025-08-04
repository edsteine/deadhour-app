import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';

/// Cultural information bottom sheet with prayer times and Islamic calendar
class CulturalInfoBottomSheet extends StatelessWidget {
  const CulturalInfoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.mosque, color: AppTheme.moroccoGreen),
                SizedBox(width: 8),
                Text(
                  'Prayer Times & Cultural Info',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Prayer times section
          _buildPrayerTimesSection(),

          // Islamic calendar section
          _buildIslamicCalendarSection(),

          // Cultural events section
          _buildCulturalEventsSection(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPrayerTimesSection() {
    final prayerTimes = [
      {'name': 'Fajr', 'time': '05:30', 'arabic': 'الفجر'},
      {'name': 'Dhuhr', 'time': '12:45', 'arabic': 'الظهر'},
      {'name': 'Asr', 'time': '15:20', 'arabic': 'العصر'},
      {'name': 'Maghrib', 'time': '18:42', 'arabic': 'المغرب'},
      {'name': 'Isha', 'time': '20:15', 'arabic': 'العشاء'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today\'s Prayer Times - Casablanca',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.moroccoGreen,
            ),
          ),
          const SizedBox(height: 12),
          ...prayerTimes.map((prayer) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prayer['name']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        prayer['arabic']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  prayer['time']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildIslamicCalendarSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: AppTheme.moroccoGold,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Islamic Calendar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Text(
                'Today: ',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '15 Rajab 1446 AH',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.moroccoGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Next: Ramadan begins in 42 days',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCulturalEventsSection() {
    final events = [
      {
        'name': 'Gnawa World Music Festival',
        'location': 'Essaouira',
        'date': 'Jun 21-23',
        'type': 'Music Festival'
      },
      {
        'name': 'Rose Festival',
        'location': 'Kelaat M\'Gouna',
        'date': 'May 10-12',
        'type': 'Cultural Festival'
      },
      {
        'name': 'Marrakech International Film Festival',
        'location': 'Marrakech',
        'date': 'Nov 29 - Dec 7',
        'type': 'Film Festival'
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Upcoming Cultural Events',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...events.map((event) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.event,
                  color: Colors.purple,
                ),
              ),
              title: Text(
                event['name']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                '${event['location']} • ${event['date']}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  event['type']!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.purple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}