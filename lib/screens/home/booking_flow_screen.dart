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
  bool _inviteFriends = false;
  int _groupSize = 1;
  final List<String> _invitedFriends = [];
  final TextEditingController _specialRequestsController =
      TextEditingController();

  final List<String> _timeSlots = ['14:30', '15:00', '15:30', '16:00'];
  final List<String> _prayerTimes = ['Dhuhr (12:30)', 'Asr (15:45)', 'Maghrib (18:20)'];

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

            // Social booking coordination
            _buildSocialBookingOptions(),
            const SizedBox(height: 24),

            // Cultural timing considerations  
            _buildCulturalTimingOptions(),
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
                    backgroundColor:
                        isSelected ? AppTheme.moroccoGreen : Colors.grey[200],
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

  Widget _buildSocialBookingOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '👥 Social Booking:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        
        // Invite friends option
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Switch(
                    value: _inviteFriends,
                    onChanged: (value) {
                      setState(() {
                        _inviteFriends = value;
                        if (!value) {
                          _invitedFriends.clear();
                          _groupSize = 1;
                        }
                      });
                    },
                    activeColor: AppTheme.moroccoGreen,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Invite friends from community',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              
              if (_inviteFriends) ...[
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                
                // Group size selector
                Row(
                  children: [
                    const Text('Group size: '),
                    const SizedBox(width: 8),
                    DropdownButton<int>(
                      value: _groupSize,
                      items: List.generate(8, (index) => index + 1)
                          .map((size) => DropdownMenuItem(
                                value: size,
                                child: Text('$size ${size == 1 ? 'person' : 'people'}'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _groupSize = value!;
                        });
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Friend invitation interface
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.moroccoGreen.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Community members:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildFriendChip('Ahmed_Casa', false),
                          _buildFriendChip('Sarah_Guide', false),
                          _buildFriendChip('LocalFoodie', true),
                          _buildFriendChip('Student_Rbat', false),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_invitedFriends.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: Text(
                            'Invited: ${_invitedFriends.join(', ')}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Group booking benefits
                if (_groupSize >= 4)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.celebration, 
                             color: Colors.orange.shade700, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${_groupSize >= 6 ? '15%' : '10%'} group discount applied!',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.orange.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFriendChip(String name, bool isInvited) {
    return FilterChip(
      label: Text(name),
      selected: isInvited,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            if (!_invitedFriends.contains(name)) {
              _invitedFriends.add(name);
            }
          } else {
            _invitedFriends.remove(name);
          }
        });
      },
      selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
      checkmarkColor: AppTheme.moroccoGreen,
    );
  }

  Widget _buildCulturalTimingOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🕌 Cultural Timing:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Prayer time awareness
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.access_time, 
                               color: AppTheme.moroccoGreen, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Prayer times today:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.moroccoGreen,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              
              Wrap(
                spacing: 8,
                children: _prayerTimes.map((prayer) => Chip(
                  label: Text(prayer),
                  backgroundColor: Colors.grey.shade100,
                )).toList(),
              ),
              
              const SizedBox(height: 12),
              
              // Booking time validation
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _isTimeConflictWithPrayer() 
                      ? Colors.orange.shade50 
                      : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _isTimeConflictWithPrayer() 
                        ? Colors.orange.shade200 
                        : Colors.green.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isTimeConflictWithPrayer() 
                          ? Icons.warning_amber 
                          : Icons.check_circle,
                      size: 16,
                      color: _isTimeConflictWithPrayer() 
                          ? Colors.orange.shade700 
                          : Colors.green.shade700,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _isTimeConflictWithPrayer()
                            ? 'Selected time is near prayer time. Consider adjusting.'
                            : 'Selected time is prayer-friendly.',
                        style: TextStyle(
                          fontSize: 12,
                          color: _isTimeConflictWithPrayer() 
                              ? Colors.orange.shade700 
                              : Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _isTimeConflictWithPrayer() {
    // Mock logic: check if selected time conflicts with prayer times
    final selectedHour = int.parse(_selectedTime.split(':')[0]);
    return selectedHour == 12 || selectedHour == 15 || selectedHour == 18;
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
            Text(
                'Confirmation code: DH${DateTime.now().millisecondsSinceEpoch % 100000}'),
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
