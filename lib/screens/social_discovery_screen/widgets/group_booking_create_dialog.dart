import 'package:flutter/material.dart';

/// Dialog for creating a new group booking
class GroupBookingCreateDialog {
  static void show(BuildContext context, {required VoidCallback onCreateBooking}) {
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
              onCreateBooking();
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}