import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../models/deal.dart';
import '../../utils/performance_utils.dart';
import '../../utils/error_utils.dart';

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

class _PaymentScreenState extends State<PaymentScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Payment method selection
  String _selectedPaymentMethod =
      'at_venue'; // 'at_venue', 'card', 'mobile_money', 'bank_transfer'

  // Card details
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();

  // Mobile money details
  final _phoneController = TextEditingController();
  String _selectedProvider = 'orange'; // 'orange', 'inwi', 'maroc_telecom'

  // Bank transfer details
  String _selectedBank = 'attijariwafa'; // Morocco banks
  final _accountController = TextEditingController();

  // Payment state
  bool _isProcessing = false;
  bool _savePaymentMethod = false;

  // Morocco-specific payment providers
  final List<Map<String, dynamic>> _mobileProviders = [
    {
      'id': 'orange',
      'name': 'Orange Money',
      'icon': '🟠',
      'color': Colors.orange
    },
    {'id': 'inwi', 'name': 'inwi Money', 'icon': '🔵', 'color': Colors.blue},
    {
      'id': 'maroc_telecom',
      'name': 'Maroc Telecom Cash',
      'icon': '🔴',
      'color': Colors.red
    },
  ];

  final List<Map<String, dynamic>> _banks = [
    {'id': 'attijariwafa', 'name': 'Attijariwafa Bank', 'icon': '🏦'},
    {'id': 'bmce', 'name': 'BMCE Bank', 'icon': '🏪'},
    {'id': 'bmci', 'name': 'BMCI', 'icon': '🏛️'},
    {'id': 'cih', 'name': 'CIH Bank', 'icon': '🏢'},
    {'id': 'credit_agricole', 'name': 'Crédit Agricole', 'icon': '🌾'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          _buildBookingSummary(),

          // Payment methods
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPaymentMethodSelection(),
                  const SizedBox(height: 16),
                  _buildPaymentForm(),
                ],
              ),
            ),
          ),

          // Payment button
          _buildPaymentButton(),
        ],
      ),
    );
  }

  Widget _buildBookingSummary() {
    final totalAmount = widget.deal.discountedPrice;
    final savings = widget.deal.originalPrice - widget.deal.discountedPrice;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.deal.statusIcon,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.deal.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Time: ${widget.bookingDetails['time']}',
            style: const TextStyle(fontSize: 14, color: AppTheme.secondaryText),
          ),
          Text(
            'Type: ${widget.bookingDetails['type']}',
            style: const TextStyle(fontSize: 14, color: AppTheme.secondaryText),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Original Price:'),
              Text(
                '${widget.deal.originalPrice.toInt()} MAD',
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: AppTheme.lightText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Discount:'),
              Text(
                '-${savings.toInt()} MAD',
                style: const TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${totalAmount.toInt()} MAD',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.moroccoGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelection() {
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
            final isSelected = _selectedPaymentMethod == method['id'];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = method['id'] as String;
                  });
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

  Widget _buildPaymentForm() {
    switch (_selectedPaymentMethod) {
      case 'at_venue':
        return _buildAtVenueForm();
      case 'card':
        return _buildCardForm();
      case 'mobile_money':
        return _buildMobileMoneyForm();
      case 'bank_transfer':
        return _buildBankTransferForm();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAtVenueForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.info_outline,
            color: AppColors.success,
            size: 32,
          ),
          const SizedBox(height: 12),
          const Text(
            'Reserve Your Spot',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your reservation will be confirmed instantly. Pay when you arrive at the venue.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.schedule, color: AppColors.warning, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Please arrive within 15 minutes of your reserved time to secure your spot.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardForm() {
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
            controller: _cardNumberController,
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
              _CardNumberInputFormatter(),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              // Expiry date
              Expanded(
                child: TextFormField(
                  controller: _expiryController,
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
                    _ExpiryDateInputFormatter(),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // CVV
              Expanded(
                child: TextFormField(
                  controller: _cvvController,
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
            controller: _cardHolderController,
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
            value: _savePaymentMethod,
            onChanged: (value) {
              setState(() {
                _savePaymentMethod = value ?? false;
              });
            },
            title: const Text('Save this card for future payments'),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppTheme.moroccoGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildMobileMoneyForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mobile Money Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Provider selection
          const Text('Select Provider:',
              style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _mobileProviders.map((provider) {
              final isSelected = _selectedProvider == provider['id'];
              return FilterChip(
                selected: isSelected,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(provider['icon'] as String),
                    const SizedBox(width: 4),
                    Text(provider['name'] as String),
                  ],
                ),
                onSelected: (selected) {
                  setState(() {
                    _selectedProvider = provider['id'] as String;
                  });
                },
                selectedColor:
                    (provider['color'] as Color).withValues(alpha: 0.2),
                checkmarkColor: provider['color'] as Color,
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Phone number
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: '+212 6 12 34 56 78',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(12),
            ],
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.info, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'You will receive an SMS with payment instructions.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankTransferForm() {
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
            value: _selectedBank,
            decoration: const InputDecoration(
              labelText: 'Select Your Bank',
              prefixIcon: Icon(Icons.account_balance),
              border: OutlineInputBorder(),
            ),
            items: _banks.map((bank) {
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
              setState(() {
                _selectedBank = value!;
              });
            },
          ),
          const SizedBox(height: 16),

          // Account number
          TextFormField(
            controller: _accountController,
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

  Widget _buildPaymentButton() {
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
    switch (_selectedPaymentMethod) {
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
      builder: (context) => PopScope(
        canPop: false,
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Payment Successful!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getSuccessMessage(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.secondaryText,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Confirmation Code:'),
                        Text(
                          'DH${DateTime.now().millisecondsSinceEpoch % 100000}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Time:'),
                        Text(widget.bookingDetails['time'] as String),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pop(); // Close payment sheet
                    context.pop(); // Close payment screen
                    context.pop(); // Close booking screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.moroccoGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSuccessMessage() {
    switch (_selectedPaymentMethod) {
      case 'at_venue':
        return 'Your reservation is confirmed! Pay when you arrive at the venue.';
      case 'card':
        return 'Payment completed successfully. Your booking is confirmed!';
      case 'mobile_money':
        return 'Payment request sent. You\'ll receive an SMS confirmation shortly.';
      case 'bank_transfer':
        return 'Transfer initiated. Your booking will be confirmed once payment is received.';
      default:
        return 'Your booking has been processed successfully!';
    }
  }
}

// Custom input formatters
class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }

    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
