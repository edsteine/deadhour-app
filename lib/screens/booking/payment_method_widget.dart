import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String selectedPaymentMethod;
  final ValueChanged<String> onPaymentMethodChanged;

  const PaymentMethodWidget({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '💳 Payment Method:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        RadioListTile<String>(
          value: 'venue',
          groupValue: selectedPaymentMethod,
          onChanged: (String? value) {
            if (value != null) {
              onPaymentMethodChanged(value);
            }
          },
          title: const Row(
            children: [
              Icon(Icons.credit_card, size: 20),
              SizedBox(width: 8),
              Text('Pay at venue (Cash/Card)'),
            ],
          ),
          contentPadding: EdgeInsets.zero,
          activeColor: AppTheme.moroccoGreen,
        ),
        RadioListTile<String>(
          value: 'mobile',
          groupValue: selectedPaymentMethod,
          onChanged: (String? value) {
            if (value != null) {
              onPaymentMethodChanged(value);
            }
          },
          title: const Row(
            children: [
              Icon(Icons.phone_android, size: 20),
              SizedBox(width: 8),
              Text('Pay now (Mobile payment)'),
            ],
          ),
          contentPadding: EdgeInsets.zero,
          activeColor: AppTheme.moroccoGreen,
        ),
      ],
    );
  }
}