import 'package:deadhour/utils/app_theme.dart';
import 'package:flutter/material.dart';


class DealSummaryWidget extends StatelessWidget {
  final Deal deal;

  const DealSummaryWidget({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context) {
    final savings = deal.originalPrice - deal.discountedPrice;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deal: ${deal.discountDisplay} (saving ${savings.toInt()} MAD)',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.moroccoGreen,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.verified, color: AppTheme.moroccoGreen, size: 16),
              SizedBox(width: 4),
              Text('Community verified'),
              Spacer(),
              Icon(Icons.people, color: AppTheme.secondaryText, size: 16),
              SizedBox(width: 4),
              Text('12 going', style: TextStyle(color: AppTheme.secondaryText)),
            ],
          ),
        ],
      ),
    );
  }
}