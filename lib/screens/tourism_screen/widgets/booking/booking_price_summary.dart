

import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Price summary widget for booking
class BookingPriceSummary extends StatelessWidget {
  final BookingSlot selectedSlot;
  final int participants;

  const BookingPriceSummary({
    super.key,
    required this.selectedSlot,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = selectedSlot.pricePerPerson * participants;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price Summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${selectedSlot.pricePerPerson.toInt()} MAD × $participants'),
              Text('${totalPrice.toInt()} MAD'),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '${totalPrice.toInt()} MAD',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.moroccoGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '• Free cancellation up to 24 hours before\n• Instant confirmation\n• 24/7 support available',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}