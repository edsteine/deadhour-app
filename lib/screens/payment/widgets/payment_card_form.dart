import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/payment/utils/payment_input_formatters.dart';

class PaymentCardForm extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final TextEditingController cardHolderController;
  final bool savePaymentMethod;
  final Function(bool) onSavePaymentMethodChanged;

  const PaymentCardForm({
    super.key,
    required this.cardNumberController,
    required this.expiryController,
    required this.cvvController,
    required this.cardHolderController,
    required this.savePaymentMethod,
    required this.onSavePaymentMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Card Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Card number
          TextFormField(
            controller: cardNumberController,
            decoration: const InputDecoration(
              labelText: 'Card Number',
              hintText: '1234 5678 9012 3456',
              prefixIcon: Icon(Icons.credit_card),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CardNumberInputFormatter(),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              // Expiry date
              Expanded(
                child: TextFormField(
                  controller: expiryController,
                  decoration: const InputDecoration(
                    labelText: 'MM/YY',
                    hintText: '12/25',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    ExpiryDateInputFormatter(),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // CVV
              Expanded(
                child: TextFormField(
                  controller: cvvController,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    hintText: '123',
                    prefixIcon: Icon(Icons.security),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  obscureText: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Cardholder name
          TextFormField(
            controller: cardHolderController,
            decoration: const InputDecoration(
              labelText: 'Cardholder Name',
              hintText: 'Ahmed Ben Ali',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16),

          // Save payment method
          CheckboxListTile(
            value: savePaymentMethod,
            onChanged: (value) => onSavePaymentMethodChanged(value ?? false),
            title: const Text('Save this card for future payments'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppTheme.moroccoGreen,
          ),
        ],
      ),
    );
  }
}