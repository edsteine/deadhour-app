










import 'package:deadhour/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            DealSummaryWidget(deal: widget.deal),
            const SizedBox(height: 24),

            // Booking options
            BookingOptionsWidget(
              selectedBookingType: _selectedBookingType,
              onBookingTypeChanged: (value) {
                setState(() {
                  _selectedBookingType = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // Date & Time selection
            TimeSelectionWidget(
              selectedTime: _selectedTime,
              timeSlots: _timeSlots,
              onTimeChanged: (value) {
                setState(() {
                  _selectedTime = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // Social booking coordination
            SocialBookingWidget(
              inviteFriends: _inviteFriends,
              groupSize: _groupSize,
              invitedFriends: _invitedFriends,
              onInviteFriendsChanged: (value) {
                setState(() {
                  _inviteFriends = value;
                  if (!value) {
                    _invitedFriends.clear();
                    _groupSize = 1;
                  }
                });
              },
              onGroupSizeChanged: (value) {
                setState(() {
                  _groupSize = value;
                });
              },
              onFriendToggle: (name, selected) {
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
            ),
            const SizedBox(height: 24),

            // Cultural timing considerations  
            BookingCulturalTimingWidget(
              selectedTime: _selectedTime,
              prayerTimes: _prayerTimes,
            ),
            const SizedBox(height: 24),

            // Special requests
            SpecialRequestsWidget(controller: _specialRequestsController),
            const SizedBox(height: 24),

            // Payment method
            PaymentMethodWidget(
              selectedPaymentMethod: _selectedPaymentMethod,
              onPaymentMethodChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // Total & sharing option
            TotalAndSharingWidget(
              deal: widget.deal,
              shareInCommunity: _shareInCommunity,
              onShareChanged: (value) {
                setState(() {
                  _shareInCommunity = value;
                });
              },
            ),
            const SizedBox(height: 32),

            // Confirm booking button
            ConfirmBookingButton(
              onConfirmBooking: () => BookingConfirmationDialog.show(
                context,
                widget.deal,
                _selectedTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}