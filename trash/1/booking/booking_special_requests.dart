import 'package:flutter/material.dart';

/// Special requests form for booking
class BookingSpecialRequests extends StatelessWidget {
  final TextEditingController specialRequestsController;

  const BookingSpecialRequests({
    super.key,
    required this.specialRequestsController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Special Requests (Optional)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: specialRequestsController,
          decoration: const InputDecoration(
            labelText: 'Any dietary restrictions, accessibility needs, etc.',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.note_add),
          ),
          maxLines: 3,
        ),
      ],
    );
  }
}