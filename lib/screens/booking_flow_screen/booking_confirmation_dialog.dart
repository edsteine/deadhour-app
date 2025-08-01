

import 'package:deadhour/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookingConfirmationDialog {
  static void show(BuildContext context, Deal deal, String selectedTime) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Confirmed!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: AppTheme.moroccoGreen,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text('Your booking for ${deal.title} is confirmed!'),
            const SizedBox(height: 8),
            Text('Time: $selectedTime'),
            Text(
                'Confirmation code: DH${DateTime.now().millisecondsSinceEpoch % 100000}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(); // Close dialog
              context.pop(); // Go back to previous screen
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}