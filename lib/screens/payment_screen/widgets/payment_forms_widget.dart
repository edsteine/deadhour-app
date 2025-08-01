import 'package:flutter/material.dart';







/// Payment forms widget that displays the appropriate form based on selected method
class PaymentFormsWidget extends StatelessWidget {
  final PaymentState state;
  final Function(String) onProviderChanged;
  final Function(String) onBankChanged;
  final Function(bool) onSavePaymentMethodChanged;

  const PaymentFormsWidget({
    super.key,
    required this.state,
    required this.onProviderChanged,
    required this.onBankChanged,
    required this.onSavePaymentMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    switch (state.selectedPaymentMethod) {
      case 'at_venue':
        return const PaymentAtVenueForm();
      case 'card':
        return PaymentCardForm(
          state: state,
          onSavePaymentMethodChanged: onSavePaymentMethodChanged,
        );
      case 'mobile_money':
        return PaymentMobileMoneyForm(
          state: state,
          onProviderChanged: onProviderChanged,
        );
      case 'bank_transfer':
        return PaymentBankTransferForm(
          state: state,
          onBankChanged: onBankChanged,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}