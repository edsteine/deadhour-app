import 'package:flutter/material.dart';

/// Dialog showing detailed information about a group booking
class GroupBookingDetailsDialog {
  static void show(BuildContext context, Map<String, dynamic> booking) {
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

  static String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}