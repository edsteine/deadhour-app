

import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Time slot selection widget for booking
class BookingTimeSlotSelection extends StatelessWidget {
  final List<BookingSlot> slots;
  final BookingSlot? selectedSlot;
  final Function(BookingSlot) onSlotSelected;

  const BookingTimeSlotSelection({
    super.key,
    required this.slots,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Time',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        if (slots.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'No available slots for this date',
                style: TextStyle(color: AppTheme.secondaryText),
              ),
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: slots.map((slot) {
              final isSelected = selectedSlot?.id == slot.id;
              return GestureDetector(
                onTap: () => onSlotSelected(slot),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.moroccoGreen : Colors.white,
                    border: Border.all(
                      color: isSelected ? AppTheme.moroccoGreen : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _formatTime(slot.dateTime),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppTheme.primaryText,
                        ),
                      ),
                      Text(
                        '${slot.availableSpots} spots',
                        style: TextStyle(
                          fontSize: 10,
                          color: isSelected ? Colors.white : AppTheme.secondaryText,
                        ),
                      ),
                      Text(
                        '${slot.pricePerPerson.toInt()} MAD',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : AppTheme.moroccoGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}