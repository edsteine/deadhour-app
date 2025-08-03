import 'package:flutter/material.dart';
import '../../../../services/group_booking_service.dart';
import 'group_booking_card.dart';
import 'group_booking_empty_state.dart';

class GroupBookingMyTab extends StatelessWidget {
  final GroupBookingService groupBookingService;
  final Function(Map<String, dynamic>) onShowBookingDetails;
  final Function(String) onJoinGroup;
  final Function(String) onLeaveGroup;

  const GroupBookingMyTab({
    super.key,
    required this.groupBookingService,
    required this.onShowBookingDetails,
    required this.onJoinGroup,
    required this.onLeaveGroup,
  });

  @override
  Widget build(BuildContext context) {
    final userBookings = groupBookingService.getUserGroupBookings('user_current');
    
    if (userBookings.isEmpty) {
      return const GroupBookingEmptyState(
        title: 'No bookings yet', 
        subtitle: 'Join a group or create your own!',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: userBookings.length,
      itemBuilder: (context, index) {
        final booking = userBookings[index];
        return GroupBookingCard(
          booking: booking,
          isUserBooking: true,
          onTap: () => onShowBookingDetails(booking),
          onJoinGroup: () => onJoinGroup(booking['id']),
          onLeaveGroup: () => onLeaveGroup(booking['id']),
        );
      },
    );
  }
}