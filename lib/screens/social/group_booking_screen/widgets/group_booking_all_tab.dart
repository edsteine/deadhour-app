import 'package:flutter/material.dart';
import 'package:deadhour/services/group_booking_service.dart';
import 'package:deadhour/screens/social/group_booking_screen/widgets/group_booking_card.dart';
import 'package:deadhour/screens/social/group_booking_screen/widgets/group_booking_empty_state.dart';

class GroupBookingAllTab extends StatelessWidget {
  final GroupBookingService groupBookingService;
  final Function(Map<String, dynamic>) onShowBookingDetails;
  final Function(String) onJoinGroup;
  final Function(String) onLeaveGroup;

  const GroupBookingAllTab({
    super.key,
    required this.groupBookingService,
    required this.onShowBookingDetails,
    required this.onJoinGroup,
    required this.onLeaveGroup,
  });

  @override
  Widget build(BuildContext context) {
    final allBookings = groupBookingService.getAllGroupBookings();
    
    if (allBookings.isEmpty) {
      return const GroupBookingEmptyState(
        title: 'No group bookings yet', 
        subtitle: 'Be the first to create a group booking!',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: allBookings.length,
      itemBuilder: (context, index) {
        final booking = allBookings[index];
        return GroupBookingCard(
          booking: booking,
          onTap: () => onShowBookingDetails(booking),
          onJoinGroup: () => onJoinGroup(booking['id']),
          onLeaveGroup: () => onLeaveGroup(booking['id']),
        );
      },
    );
  }
}