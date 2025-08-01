import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_theme.dart';
import '../deals/models/deal.dart';
import 'payment_state.dart';
// Import modular payment widgets
import 'widgets/payment_booking_summary_widget.dart';
import 'widgets/payment_forms_widget.dart';
import 'widgets/payment_method_selector_widget.dart';
import 'widgets/payment_submit_button_widget.dart';

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
  late PaymentState _paymentState;

  @override
  void initState() {
    super.initState();
    _paymentState = PaymentState();
  }

  @override
  void dispose() {
    _paymentState.dispose();
    super.dispose();
  }

  void _onPaymentMethodChanged(String method) {
    setState(() {
      _paymentState.selectedPaymentMethod = method;
    });
  }

  void _onProviderChanged(String provider) {
    setState(() {
      _paymentState.selectedProvider = provider;
    });
  }

  void _onBankChanged(String bank) {
    setState(() {
      _paymentState.selectedBank = bank;
    });
  }

  void _onSavePaymentMethodChanged(bool save) {
    setState(() {
      _paymentState.savePaymentMethod = save;
    });
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
          PaymentBookingSummaryWidget(
            deal: widget.deal,
            bookingDetails: widget.bookingDetails,
          ),

          // Payment methods and forms
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PaymentMethodSelectorWidget(
                    selectedMethod: _paymentState.selectedPaymentMethod,
                    onMethodChanged: _onPaymentMethodChanged,
                  ),
                  const SizedBox(height: 16),
                  PaymentFormsWidget(
                    state: _paymentState,
                    onProviderChanged: _onProviderChanged,
                    onBankChanged: _onBankChanged,
                    onSavePaymentMethodChanged: _onSavePaymentMethodChanged,
                  ),
                ],
              ),
            ),
          ),

          // Payment button
          PaymentSubmitButtonWidget(
            deal: widget.deal,
            bookingDetails: widget.bookingDetails,
            state: _paymentState,
          ),
        ],
      ),
    );
  }
}