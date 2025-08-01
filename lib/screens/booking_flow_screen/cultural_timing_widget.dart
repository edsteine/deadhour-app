import 'package:deadhour/utils/app_theme.dart';
import 'package:flutter/material.dart';

class BookingCulturalTimingWidget extends StatelessWidget {
  final String selectedTime;
  final List<String> prayerTimes;

  const BookingCulturalTimingWidget({
    super.key,
    required this.selectedTime,
    required this.prayerTimes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🕌 Cultural Timing:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Prayer time awareness
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.access_time, 
                               color: AppTheme.moroccoGreen, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Prayer times today:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.moroccoGreen,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              
              Wrap(
                spacing: 8,
                children: prayerTimes.map((prayer) => Chip(
                  label: Text(prayer),
                  backgroundColor: Colors.grey.shade100,
                )).toList(),
              ),
              
              const SizedBox(height: 12),
              
              // Booking time validation
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _isTimeConflictWithPrayer() 
                      ? Colors.orange.shade50 
                      : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _isTimeConflictWithPrayer() 
                        ? Colors.orange.shade200 
                        : Colors.green.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isTimeConflictWithPrayer() 
                          ? Icons.warning_amber 
                          : Icons.check_circle,
                      size: 16,
                      color: _isTimeConflictWithPrayer() 
                          ? Colors.orange.shade700 
                          : Colors.green.shade700,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _isTimeConflictWithPrayer()
                            ? 'Selected time is near prayer time. Consider adjusting.'
                            : 'Selected time is prayer-friendly.',
                        style: TextStyle(
                          fontSize: 12,
                          color: _isTimeConflictWithPrayer() 
                              ? Colors.orange.shade700 
                              : Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _isTimeConflictWithPrayer() {
    // Mock logic: check if selected time conflicts with prayer times
    final selectedHour = int.parse(selectedTime.split(':')[0]);
    return selectedHour == 12 || selectedHour == 15 || selectedHour == 18;
  }
}