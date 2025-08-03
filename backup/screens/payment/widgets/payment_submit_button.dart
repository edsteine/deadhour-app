import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../../../models/deal.dart';

class PaymentSubmitButton extends StatelessWidget {
  final String selectedPaymentMethod;
  final Deal deal;
  final bool isProcessing;
  final VoidCallback onPressed;

  const PaymentSubmitButton({
    super.key,
    required this.selectedPaymentMethod,
    required this.deal,
    required this.isProcessing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isProcessing ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.moroccoGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: isProcessing
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    _getPaymentButtonText(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  String _getPaymentButtonText() {
    switch (selectedPaymentMethod) {
      case 'at_venue':
        return 'Reserve Now';
      case 'card':
        return 'Pay ${deal.discountedPrice.toInt()} MAD';
      case 'mobile_money':
        return 'Send Payment Request';
      case 'bank_transfer':
        return 'Initiate Transfer';
      default:
        return 'Continue';
    }
  }
}