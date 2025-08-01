import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class TimeSelectionWidget extends StatelessWidget {
  final String selectedTime;
  final ValueChanged<String> onTimeChanged;
  final List<String> timeSlots;

  const TimeSelectionWidget({
    super.key,
    required this.selectedTime,
    required this.onTimeChanged,
    required this.timeSlots,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📅 Date & Time:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Today, March 15'),
        const SizedBox(height: 12),
        Row(
          children: timeSlots.map((time) {
            final isSelected = selectedTime == time;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ElevatedButton(
                  onPressed: () => onTimeChanged(time),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isSelected ? AppTheme.moroccoGreen : Colors.grey[200],
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(time),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}