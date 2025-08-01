import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

class TimeFrameSelector extends StatelessWidget {
  final String selectedTimeFrame;
  final ValueChanged<String> onTimeFrameSelected;

  const TimeFrameSelector({
    super.key,
    required this.selectedTimeFrame,
    required this.onTimeFrameSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          'today',
          'week',
          'month',
          'quarter',
        ].map((timeFrame) {
          final isSelected = selectedTimeFrame == timeFrame;
          return GestureDetector(
            onTap: () => onTimeFrameSelected(timeFrame),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.moroccoGreen : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppTheme.moroccoGreen : Colors.grey[300]!,
                ),
              ),
              child: Text(
                timeFrame.toUpperCase(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
