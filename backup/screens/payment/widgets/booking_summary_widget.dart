import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../../../models/deal.dart';

class BookingSummaryWidget extends StatelessWidget {
  final Deal deal;
  final Map<String, dynamic> bookingDetails;

  const BookingSummaryWidget({
    super.key,
    required this.deal,
    required this.bookingDetails,
  });

  @override
  Widget build(BuildContext context) {
    final totalAmount = deal.discountedPrice;
    final savings = deal.originalPrice - deal.discountedPrice;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                deal.statusIcon,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  deal.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Time: ${bookingDetails['time']}',
            style: const TextStyle(fontSize: 14, color: AppTheme.secondaryText),
          ),
          Text(
            'Type: ${bookingDetails['type']}',
            style: const TextStyle(fontSize: 14, color: AppTheme.secondaryText),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Original Price:'),
              Text(
                '${deal.originalPrice.toInt()} MAD',
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: AppTheme.lightText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Discount:'),
              Text(
                '-${savings.toInt()} MAD',
                style: const TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${totalAmount.toInt()} MAD',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.moroccoGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}