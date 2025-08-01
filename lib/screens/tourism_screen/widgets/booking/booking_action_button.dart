

import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Book now action button
class BookingActionButton extends StatelessWidget {
  final BookingSlot? selectedSlot;
  final int participants;
  final bool isLoading;
  final VoidCallback onBook;

  const BookingActionButton({
    super.key,
    required this.selectedSlot,
    required this.participants,
    required this.isLoading,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: selectedSlot != null && !isLoading ? onBook : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.moroccoGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: isLoading 
              ? const CircularProgressIndicator(color: Colors.white)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.flash_on),
                    const SizedBox(width: 8),
                    Text(
                      selectedSlot != null 
                          ? 'Book Now - ${(selectedSlot!.pricePerPerson * participants).toInt()} MAD'
                          : 'Select Time Slot',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}