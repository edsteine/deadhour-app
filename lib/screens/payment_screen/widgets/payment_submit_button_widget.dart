import 'package:deadhour/utils/haptic_feedback_type.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/app_theme.dart';
import 'package:deadhour/utils/performance_utils.dart';
import 'package:deadhour/utils/app_error_handler.dart';



/// Payment submit button widget
class PaymentSubmitButtonWidget extends StatefulWidget {
  final Deal deal;
  final Map<String, dynamic> bookingDetails;
  final PaymentState state;

  const PaymentSubmitButtonWidget({
    super.key,
    required this.deal,
    required this.bookingDetails,
    required this.state,
  });

  @override
  State<PaymentSubmitButtonWidget> createState() => _PaymentSubmitButtonWidgetState();
}

class _PaymentSubmitButtonWidgetState extends State<PaymentSubmitButtonWidget> {
  bool _isProcessing = false;

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
            onPressed: _isProcessing ? null : _processPayment,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.moroccoGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isProcessing
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
    switch (widget.state.selectedPaymentMethod) {
      case 'at_venue':
        return 'Reserve Now';
      case 'card':
        return 'Pay ${widget.deal.discountedPrice.toInt()} MAD';
      case 'mobile_money':
        return 'Send Payment Request';
      case 'bank_transfer':
        return 'Initiate Transfer';
      default:
        return 'Continue';
    }
  }

  Future<void> _processPayment() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);

      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      // Show success and navigate
      if (mounted) {
        _showPaymentSuccess();
      }
    } catch (error) {
      if (mounted) {
        final appError = AppErrorHandler.parseError(error);
        AppErrorHandler.showErrorSnackbar(context, appError,
            onRetry: _processPayment);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _showPaymentSuccess() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentSuccessDialog(
        selectedPaymentMethod: widget.state.selectedPaymentMethod,
        bookingDetails: widget.bookingDetails,
        onDone: () {
          context.pop(); // Close payment sheet
          context.pop(); // Close payment screen
          context.pop(); // Close booking screen
        },
      ),
    );
  }
}