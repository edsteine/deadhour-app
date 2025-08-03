import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../../../services/cultural_calendar_service.dart';

class TouristCulturalInsightsCard extends StatelessWidget {
  final CulturalCalendarService culturalService;

  const TouristCulturalInsightsCard({
    super.key,
    required this.culturalService,
  });

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final prayerTimes = culturalService.getTodaysPrayerTimes();
    const nextPrayer = 'Maghrib at 18:30';
    final isRamadan = culturalService.isRamadan();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.mosque,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                SizedBox(width: AppTheme.spacing12),
                Text(
                  'Cultural Context',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            if (isRamadan)
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing12),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                  border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.nightlight_round, color: Colors.purple),
                    const SizedBox(width: AppTheme.spacing12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ramadan Period',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Special schedules and experiences available\nCurrent time: ${currentTime.hour}:${currentTime.minute.toString().padLeft(2, '0')}\nPrayer times: ${prayerTimes['fajr'] ?? 'N/A'}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            
            const SizedBox(height: AppTheme.spacing12),
            
            // Prayer times
            const Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey),
                SizedBox(width: AppTheme.spacing8),
                Text(
                  'Next Prayer: $nextPrayer',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.spacing12),
            
            // Cultural tip
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: AppTheme.moroccoGreen),
                  SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Text(
                      'Tip: Many venues offer special tourist discounts during prayer times',
                      style: TextStyle(
                        color: AppTheme.moroccoGreen,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}