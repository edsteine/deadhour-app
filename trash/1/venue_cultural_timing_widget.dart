import 'package:flutter/material.dart';

import '../../../utils/theme.dart';
import '../../profile/services/cultural_calendar_service.dart';

/// Cultural timing section widget
class VenueCulturalTimingWidget extends StatelessWidget {
  final CulturalCalendarService culturalCalendar;

  const VenueCulturalTimingWidget({
    super.key,
    required this.culturalCalendar,
  });

  @override
  Widget build(BuildContext context) {
    final prayerTimes = culturalCalendar.getFormattedPrayerTimes();
    final nextPrayer = culturalCalendar.getNextPrayer();
    final isRamadan = culturalCalendar.isRamadan();
    final todaysHoliday = culturalCalendar.getTodaysHoliday();
    final businessHours = culturalCalendar.getCulturalBusinessHours();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🕌 Cultural Timing',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        // Islamic date and special occasions
        if (todaysHoliday != null || isRamadan)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (todaysHoliday != null)
                  Text(
                    '🎉 Today: $todaysHoliday',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.moroccoGreen,
                    ),
                  ),
                if (isRamadan)
                  const Text(
                    '🌙 Ramadan Schedule Active',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.moroccoGreen,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  culturalCalendar.getIslamicDate(),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.moroccoGreen.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        
        // Next prayer info
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              const Icon(Icons.access_time, color: Colors.blue, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Next Prayer: ${nextPrayer.keys.first} at ${nextPrayer.values.first}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Prayer times grid
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Today\'s Prayer Times:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: prayerTimes.map((prayer) => Chip(
                  label: Text(
                    '${prayer['name']} ${prayer['time']}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey.shade300),
                )).toList(),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Cultural business recommendations
        if (businessHours['note'] != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange.shade700, size: 16),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Cultural Timing Advice:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  businessHours['note']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange.shade700,
                  ),
                ),
                if (businessHours['recommended_hours'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Recommended hours: ${businessHours['recommended_hours']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}