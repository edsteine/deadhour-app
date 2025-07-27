import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../models/deal.dart';

class BookingFlowScreen extends StatefulWidget {
  final Deal deal;

  const BookingFlowScreen({
    super.key,
    required this.deal,
  });

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  String _selectedBookingType = 'solo';
  String _selectedTime = '15:00';
  String _selectedPaymentMethod = 'venue';
  bool _shareInCommunity = true;
  final TextEditingController _specialRequestsController = TextEditingController();

  final List<String> _timeSlots = ['14:30', '15:00', '15:30', '16:00'];
  
  @override
  void dispose() {
    _specialRequestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book: ${widget.deal.title}'),
        backgroundColor: AppTheme.moroccoGreen,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deal summary
            _buildDealSummary(),
            const SizedBox(height: 24),
            
            // Booking options
            _buildBookingOptions(),
            const SizedBox(height: 24),
            
            // Date & Time selection
            _buildTimeSelection(),
            const SizedBox(height: 24),
            
            // Community group option
            _buildCommunityGroupOption(),
            const SizedBox(height: 24),
            
            // Special requests
            _buildSpecialRequests(),
            const SizedBox(height: 24),
            
            // Payment method
            _buildPaymentMethod(),
            const SizedBox(height: 24),
            
            // Total & sharing option
            _buildTotalAndSharing(),
            const SizedBox(height: 32),
            
            // Confirm booking button
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDealSummary() {
    final savings = widget.deal.originalPrice - widget.deal.discountedPrice;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deal: ${widget.deal.discountDisplay} (saving ${savings.toInt()} MAD)',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.moroccoGreen,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.verified, color: AppTheme.moroccoGreen, size: 16),
              SizedBox(width: 4),
              Text('Community verified'),
              Spacer(),
              Icon(Icons.people, color: AppTheme.secondaryText, size: 16),
              SizedBox(width: 4),
              Text('12 going', style: TextStyle(color: AppTheme.secondaryText)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '👥 Booking Options:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildRadioOption('solo', 'Solo booking (just you)'),
        _buildRadioOption('join_group', 'Join community group (3 people)'),
        _buildRadioOption('create_group', 'Create new group (invite friends)'),
      ],
    );
  }

  Widget _buildRadioOption(String value, String label) {
    return RadioListTile<String>(
      value: value,
      groupValue: _selectedBookingType,
      onChanged: (String? newValue) {
        setState(() {
          _selectedBookingType = newValue!;
        });
      },
      title: Text(label),
      contentPadding: EdgeInsets.zero,
      activeColor: AppTheme.moroccoGreen,
    );
  }

  Widget _buildTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📅 Date & Time:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Today, March 15'),
        const SizedBox(height: 12),
        Row(
          children: _timeSlots.map((time) {
            final isSelected = _selectedTime == time;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTime = time;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? AppTheme.moroccoGreen : Colors.grey[200],
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(time),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCommunityGroupOption() {
    if (_selectedBookingType != 'join_group') return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '💬 Community Group Option:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ahmed_Casa\'s study group (3/4)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '"Working on project, friendly atmosphere, WiFi focused"',
                style: TextStyle(color: AppTheme.secondaryText),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Join This Group'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Chat First'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialRequests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📝 Special Requests:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _specialRequestsController,
          decoration: const InputDecoration(
            hintText: 'Window seat, quiet area for work',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(16),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '💳 Payment Method:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        RadioListTile<String>(
          value: 'venue',
          groupValue: _selectedPaymentMethod,
          onChanged: (String? value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
          title: const Row(
            children: [
              Icon(Icons.credit_card, size: 20),
              SizedBox(width: 8),
              Text('Pay at venue (Cash/Card)'),
            ],
          ),
          contentPadding: EdgeInsets.zero,
          activeColor: AppTheme.moroccoGreen,
        ),
        RadioListTile<String>(
          value: 'mobile',
          groupValue: _selectedPaymentMethod,
          onChanged: (String? value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
          title: const Row(
            children: [
              Icon(Icons.phone_android, size: 20),
              SizedBox(width: 8),
              Text('Pay now (Mobile payment)'),
            ],
          ),
          contentPadding: EdgeInsets.zero,
          activeColor: AppTheme.moroccoGreen,
        ),
      ],
    );
  }

  Widget _buildTotalAndSharing() {
    final savings = widget.deal.originalPrice - widget.deal.discountedPrice;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '💰 Total:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${widget.deal.discountedPrice.toInt()} MAD',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.moroccoGreen,
                    ),
                  ),
                  Text(
                    'was ${widget.deal.originalPrice.toInt()} MAD',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.secondaryText,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'You save: ${savings.toInt()} MAD + social discovery',
            style: const TextStyle(
              color: AppTheme.moroccoGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: _shareInCommunity,
            onChanged: (bool? value) {
              setState(() {
                _shareInCommunity = value!;
              });
            },
            title: const Text('Share booking in community room'),
            contentPadding: EdgeInsets.zero,
            activeColor: AppTheme.moroccoGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _confirmBooking,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.moroccoGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Confirm Booking',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _confirmBooking() {
    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Confirmed!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: AppTheme.moroccoGreen,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text('Your booking for ${widget.deal.title} is confirmed!'),
            const SizedBox(height: 8),
            Text('Time: $_selectedTime'),
            Text('Confirmation code: DH${DateTime.now().millisecondsSinceEpoch % 100000}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(); // Close dialog
              context.pop(); // Go back to previous screen
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}