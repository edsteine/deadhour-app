import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';


class TotalAndSharingWidget extends StatelessWidget {
  final Deal deal;
  final bool shareInCommunity;
  final ValueChanged<bool> onShareChanged;

  const TotalAndSharingWidget({
    super.key,
    required this.deal,
    required this.shareInCommunity,
    required this.onShareChanged,
  });

  @override
  Widget build(BuildContext context) {
    final savings = deal.originalPrice - deal.discountedPrice;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '💰 Total:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${deal.discountedPrice.toInt()} MAD',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.moroccoGreen,
                    ),
                  ),
                  Text(
                    'was ${deal.originalPrice.toInt()} MAD',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.secondaryText,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'You save: ${savings.toInt()} MAD + social discovery',
            style: const TextStyle(
              color: AppTheme.moroccoGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: shareInCommunity,
            onChanged: (bool? value) {
              if (value != null) {
                onShareChanged(value);
              }
            },
            title: const Text('Share booking in community room'),
            contentPadding: EdgeInsets.zero,
            activeColor: AppTheme.moroccoGreen,
          ),
        ],
      ),
    );
  }
}