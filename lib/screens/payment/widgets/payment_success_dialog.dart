import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/theme.dart';

class PaymentSuccessDialog {
  static void show({
    required BuildContext context,
    required String selectedPaymentMethod,
    required Map<String, dynamic> bookingDetails,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => PopScope(
        canPop: false,
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Payment Successful!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getSuccessMessage(selectedPaymentMethod),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.secondaryText,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Confirmation Code:'),
                        Text(
                          'DH${DateTime.now().millisecondsSinceEpoch % 100000}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Time:'),
                        Text(bookingDetails['time'] as String),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pop(); // Close payment sheet
                    context.pop(); // Close payment screen
                    context.pop(); // Close booking screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.moroccoGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _getSuccessMessage(String selectedPaymentMethod) {
    switch (selectedPaymentMethod) {
      case 'at_venue':
        return 'Your reservation is confirmed! Pay when you arrive at the venue.';
      case 'card':
        return 'Payment completed successfully. Your booking is confirmed!';
      case 'mobile_money':
        return 'Payment request sent. You\'ll receive an SMS confirmation shortly.';
      case 'bank_transfer':
        return 'Transfer initiated. Your booking will be confirmed once payment is received.';
      default:
        return 'Your booking has been processed successfully!';
    }
  }
}