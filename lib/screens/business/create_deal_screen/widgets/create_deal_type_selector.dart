import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class CreateDealTypeSelector extends StatelessWidget {
  final String dealType;
  final int discountPercentage;
  final ValueChanged<String> onDealTypeChanged;
  final ValueChanged<int> onDiscountPercentageChanged;

  const CreateDealTypeSelector({
    super.key,
    required this.dealType,
    required this.discountPercentage,
    required this.onDealTypeChanged,
    required this.onDiscountPercentageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('💰 Deal Type'),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              RadioListTile<String>(
                title: Text('📉 Percentage Discount ($discountPercentage% OFF)'),
                subtitle: Text(
                    'Preview: 45 MAD → ${(45 * (100 - discountPercentage) / 100).round()} MAD'),
                value: 'percentage',
                groupValue: dealType,
                onChanged: (value) => onDealTypeChanged(value!),
                activeColor: AppTheme.moroccoGreen,
              ),
              RadioListTile<String>(
                title: const Text('💰 Fixed Price (Coffee + Pastry = 25 MAD)'),
                value: 'fixed',
                groupValue: dealType,
                onChanged: (value) => onDealTypeChanged(value!),
                activeColor: AppTheme.moroccoGreen,
              ),
              RadioListTile<String>(
                title: const Text('🎁 Buy One Get One'),
                value: 'bogo',
                groupValue: dealType,
                onChanged: (value) => onDealTypeChanged(value!),
                activeColor: AppTheme.moroccoGreen,
              ),
            ],
          ),
        ),

        if (dealType == 'percentage') ...[
          const SizedBox(height: 16),
          Text('Discount Amount: $discountPercentage%'),
          Slider(
            value: discountPercentage.toDouble(),
            min: 10,
            max: 70,
            divisions: 12,
            label: '$discountPercentage%',
            onChanged: (value) => onDiscountPercentageChanged(value.round()),
            activeColor: AppTheme.moroccoGreen,
          ),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.moroccoGreen,
      ),
    );
  }
}