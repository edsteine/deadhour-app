import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../../../utils/performance_utils.dart';

class PaymentMethodSelector extends StatelessWidget {
  final String selectedPaymentMethod;
  final Function(String) onPaymentMethodChanged;

  const PaymentMethodSelector({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      {
        'id': 'at_venue',
        'title': 'Pay at Venue',
        'subtitle': 'Reserve now, pay when you arrive',
        'icon': Icons.store,
        'color': AppTheme.moroccoGreen,
        'recommended': true,
      },
      {
        'id': 'card',
        'title': 'Credit/Debit Card',
        'subtitle': 'Visa, Mastercard accepted',
        'icon': Icons.credit_card,
        'color': Colors.blue,
        'recommended': false,
      },
      {
        'id': 'mobile_money',
        'title': 'Mobile Money',
        'subtitle': 'Orange Money, inwi Money, etc.',
        'icon': Icons.phone_android,
        'color': Colors.orange,
        'recommended': false,
      },
      {
        'id': 'bank_transfer',
        'title': 'Bank Transfer',
        'subtitle': 'Direct bank payment',
        'icon': Icons.account_balance,
        'color': Colors.green,
        'recommended': false,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...paymentMethods.map((method) {
            final isSelected = selectedPaymentMethod == method['id'];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () {
                  onPaymentMethodChanged(method['id'] as String);
                  PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (method['color'] as Color).withValues(alpha: 0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? (method['color'] as Color)
                          : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              (method['color'] as Color).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          method['icon'] as IconData,
                          color: method['color'] as Color,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  method['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (method['recommended'] as bool) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.success,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Recommended',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              method['subtitle'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: method['color'] as Color,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}