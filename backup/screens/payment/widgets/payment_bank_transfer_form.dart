import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class PaymentBankTransferForm extends StatelessWidget {
  final String selectedBank;
  final TextEditingController accountController;
  final Function(String) onBankChanged;

  const PaymentBankTransferForm({
    super.key,
    required this.selectedBank,
    required this.accountController,
    required this.onBankChanged,
  });

  @override
  Widget build(BuildContext context) {
    final banks = [
      {'id': 'attijariwafa', 'name': 'Attijariwafa Bank', 'icon': '🏦'},
      {'id': 'bmce', 'name': 'BMCE Bank', 'icon': '🏪'},
      {'id': 'bmci', 'name': 'BMCI', 'icon': '🏛️'},
      {'id': 'cih', 'name': 'CIH Bank', 'icon': '🏢'},
      {'id': 'credit_agricole', 'name': 'Crédit Agricole', 'icon': '🌾'},
    ];

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
            value: selectedBank,
            decoration: const InputDecoration(
              labelText: 'Select Your Bank',
              prefixIcon: Icon(Icons.account_balance),
              border: OutlineInputBorder(),
            ),
            items: banks.map((bank) {
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
            onChanged: (value) => onBankChanged(value!),
          ),
          const SizedBox(height: 16),

          // Account number
          TextFormField(
            controller: accountController,
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
              color: AppColors.warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: AppColors.warning, size: 20),
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