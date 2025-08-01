import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class CulturalEvents extends StatelessWidget {
  const CulturalEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'date': 'March 20',
        'event': 'Spring Equinox 🌸',
        'description': 'Garden festivals begin'
      },
      {
        'date': 'April 10',
        'event': 'Ramadan Begins 🌙',
        'description': 'Special Iftar experiences'
      },
      {
        'date': 'May 15',
        'event': 'Rose Festival',
        'description': 'Kelaat M\'Gouna celebration'
      },
    ];

    return Column(
      children: events
          .map((event) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.tourismCategory.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        event['date']!.split(' ')[1],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event['event']!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            event['description']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
