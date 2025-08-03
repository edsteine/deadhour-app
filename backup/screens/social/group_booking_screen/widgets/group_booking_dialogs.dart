import 'package:flutter/material.dart';
import '../../../../services/group_booking_service.dart';

class GroupBookingDialogs {
  static void showCreateBookingDialog(
    BuildContext context,
    GroupBookingService groupBookingService,
    VoidCallback onRefresh,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Group Booking'),
        content: const Text('Group booking creation form would go here with venue selection, date/time, requirements, etc.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _createMockBooking(groupBookingService, onRefresh);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  static void showBookingDetails(BuildContext context, Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking['title'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(booking['description']),
              const SizedBox(height: 16),
              Text('Venue: ${booking['venueName']}'),
              Text('Organizer: ${booking['organizer']}'),
              Text('Time: ${_formatDateTime(booking['dateTime'])}'),
              Text('Participants: ${(booking['currentParticipants'] as List).length}/${booking['maxParticipants']}'),
              if ((booking['waitlist'] as List).isNotEmpty)
                Text('Waitlist: ${(booking['waitlist'] as List).length}'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showNegotiateDealDialog(BuildContext context, Map<String, dynamic> opportunity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Negotiate Group Deal'),
        content: Text('Deal negotiation for ${opportunity['venueName']} would be handled here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Send Request'),
          ),
        ],
      ),
    );
  }

  static void _createMockBooking(GroupBookingService groupBookingService, VoidCallback onRefresh) {
    groupBookingService.createGroupBooking(
      venueId: 'venue_1',
      venueName: 'Café Central',
      organizerId: 'user_current',
      organizerName: 'Current User',
      title: 'Study Session',
      description: 'Group study for exams',
      dateTime: DateTime.now().add(const Duration(days: 1)),
      duration: 120,
      maxParticipants: 6,
      requestDeal: true,
      requestedDiscount: 15.0,
      requirements: ['wifi', 'quiet'],
    );
    
    onRefresh();
  }

  static String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}