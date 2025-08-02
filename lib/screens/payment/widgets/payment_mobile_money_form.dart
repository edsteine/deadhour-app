import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deadhour/utils/theme.dart';

class PaymentMobileMoneyForm extends StatelessWidget {
  final TextEditingController phoneController;
  final String selectedProvider;
  final Function(String) onProviderChanged;

  const PaymentMobileMoneyForm({
    super.key,
    required this.phoneController,
    required this.selectedProvider,
    required this.onProviderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final mobileProviders = [
      {
        'id': 'orange',
        'name': 'Orange Money',
        'icon': '🟠',
        'color': Colors.orange
      },
      {'id': 'inwi', 'name': 'inwi Money', 'icon': '🔵', 'color': Colors.blue},
      {
        'id': 'maroc_telecom',
        'name': 'Maroc Telecom Cash',
        'icon': '🔴',
        'color': Colors.red
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mobile Money Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Provider selection
          const Text('Select Provider:',
              style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: mobileProviders.map((provider) {
              final isSelected = selectedProvider == provider['id'];
              return FilterChip(
                selected: isSelected,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(provider['icon'] as String),
                    const SizedBox(width: 4),
                    Text(provider['name'] as String),
                  ],
                ),
                onSelected: (selected) => onProviderChanged(provider['id'] as String),
                selectedColor:
                    (provider['color'] as Color).withValues(alpha: 0.2),
                checkmarkColor: provider['color'] as Color,
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Phone number
          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: '+212 6 12 34 56 78',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(12),
            ],
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.info, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'You will receive an SMS with payment instructions.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}