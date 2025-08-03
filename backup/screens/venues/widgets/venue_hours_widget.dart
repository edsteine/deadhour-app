import 'package:flutter/material.dart';

class VenueHoursWidget extends StatelessWidget {
  const VenueHoursWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final hours = _getVenueHours();
    final currentDay = DateTime.now().weekday;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: hours.asMap().entries.map((entry) {
          final index = entry.key;
          final dayHours = entry.value;
          final isToday = index + 1 == currentDay;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dayHours['day'] ?? '',
                  style: TextStyle(
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: isToday ? Colors.green : Colors.black,
                  ),
                ),
                Text(
                  dayHours['hours'] ?? '',
                  style: TextStyle(
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: isToday ? Colors.green : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Map<String, String>> _getVenueHours() {
    return [
      {'day': 'Monday', 'hours': '9:00 AM - 11:00 PM'},
      {'day': 'Tuesday', 'hours': '9:00 AM - 11:00 PM'},
      {'day': 'Wednesday', 'hours': '9:00 AM - 11:00 PM'},
      {'day': 'Thursday', 'hours': '9:00 AM - 11:00 PM'},
      {'day': 'Friday', 'hours': '2:00 PM - 11:00 PM'},
      {'day': 'Saturday', 'hours': '9:00 AM - 12:00 AM'},
      {'day': 'Sunday', 'hours': '9:00 AM - 11:00 PM'},
    ];
  }
}