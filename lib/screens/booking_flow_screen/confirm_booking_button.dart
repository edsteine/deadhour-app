import 'package:deadhour/utils/app_theme.dart';
import 'package:flutter/material.dart';

class ConfirmBookingButton extends StatelessWidget {
  final VoidCallback onConfirmBooking;

  const ConfirmBookingButton({
    super.key,
    required this.onConfirmBooking,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onConfirmBooking,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.moroccoGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Confirm Booking',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}