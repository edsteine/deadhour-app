
import 'package:flutter/material.dart';



/// Tab displaying all available group bookings
class GroupBookingAllTab extends StatelessWidget {
  final GroupBookingService groupBookingService;
  final VoidCallback onRefresh;

  const GroupBookingAllTab({
    super.key,
    required this.groupBookingService,
    required this.onRefresh,
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
          groupBookingService: groupBookingService,
          onRefresh: onRefresh,
        );
      },
    );
  }
}