import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../models/deal.dart';
import '../../utils/performance_utils.dart';
import '../../utils/error_utils.dart';
import 'widgets/booking_summary_widget.dart';
import 'widgets/payment_method_selector.dart';
import 'widgets/payment_at_venue_form.dart';
import 'widgets/payment_card_form.dart';
import 'widgets/payment_mobile_money_form.dart';
import 'widgets/payment_bank_transfer_form.dart';
import 'widgets/payment_submit_button.dart';
import 'widgets/payment_success_dialog.dart';

class PaymentScreen extends StatefulWidget {
  final Deal deal;
  final Map<String, dynamic> bookingDetails;

  const PaymentScreen({
    super.key,
    required this.deal,
    required this.bookingDetails,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Payment method selection
  String _selectedPaymentMethod = 'at_venue';

  // Card details
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();

  // Mobile money details
  final _phoneController = TextEditingController();
  String _selectedProvider = 'orange';

  // Bank transfer details
  String _selectedBank = 'attijariwafa';
  final _accountController = TextEditingController();

  // Payment state
  bool _isProcessing = false;
  bool _savePaymentMethod = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    _phoneController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: AppTheme.moroccoGreen,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Booking summary
          BookingSummaryWidget(
            deal: widget.deal,
            bookingDetails: widget.bookingDetails,
          ),

          // Payment methods
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PaymentMethodSelector(
                    selectedPaymentMethod: _selectedPaymentMethod,
                    onPaymentMethodChanged: (method) {
                      setState(() {
                        _selectedPaymentMethod = method;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildPaymentForm(),
                ],
              ),
            ),
          ),

          // Payment button
          PaymentSubmitButton(
            selectedPaymentMethod: _selectedPaymentMethod,
            deal: widget.deal,
            isProcessing: _isProcessing,
            onPressed: _processPayment,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentForm() {
    switch (_selectedPaymentMethod) {
      case 'at_venue':
        return const PaymentAtVenueForm();
      case 'card':
        return PaymentCardForm(
          cardNumberController: _cardNumberController,
          expiryController: _expiryController,
          cvvController: _cvvController,
          cardHolderController: _cardHolderController,
          savePaymentMethod: _savePaymentMethod,
          onSavePaymentMethodChanged: (value) {
            setState(() {
              _savePaymentMethod = value;
            });
          },
        );
      case 'mobile_money':
        return PaymentMobileMoneyForm(
          phoneController: _phoneController,
          selectedProvider: _selectedProvider,
          onProviderChanged: (provider) {
            setState(() {
              _selectedProvider = provider;
            });
          },
        );
      case 'bank_transfer':
        return PaymentBankTransferForm(
          selectedBank: _selectedBank,
          accountController: _accountController,
          onBankChanged: (bank) {
            setState(() {
              _selectedBank = bank;
            });
          },
        );
      default:
        return const SizedBox.shrink();
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
    PaymentSuccessDialog.show(
      context: context,
      selectedPaymentMethod: _selectedPaymentMethod,
      bookingDetails: widget.bookingDetails,
    );
  }
}