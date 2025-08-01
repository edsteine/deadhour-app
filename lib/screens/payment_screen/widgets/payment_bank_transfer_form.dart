import 'package:flutter/material.dart';


/// Bank transfer payment form widget
class PaymentBankTransferForm extends StatelessWidget {
  final PaymentState state;
  final Function(String) onBankChanged;

  const PaymentBankTransferForm({
    super.key,
    required this.state,
    required this.onBankChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bank Transfer Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Bank selection
          DropdownButtonFormField<String>(
            value: state.selectedBank,
            decoration: const InputDecoration(
              labelText: 'Select Your Bank',
              prefixIcon: Icon(Icons.account_balance),
              border: OutlineInputBorder(),
            ),
            items: state.banks.map((bank) {
              return DropdownMenuItem(
                value: bank['id'] as String,
                child: Row(
                  children: [
                    Text(bank['icon'] as String),
                    const SizedBox(width: 8),
                    Text(bank['name'] as String),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onBankChanged(value);
              }
            },
          ),
          const SizedBox(height: 16),

          // Account number
          TextFormField(
            controller: state.accountController,
            decoration: const InputDecoration(
              labelText: 'Account Number',
              hintText: 'Enter your account number',
              prefixIcon: Icon(Icons.account_balance_wallet),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Processing Time',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Bank transfers may take 1-3 business days to process. Your booking will be confirmed once payment is received.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}