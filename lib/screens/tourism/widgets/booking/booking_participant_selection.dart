import '../../services/real_time_booking_service.dart';
import 'package:flutter/material.dart';
import '../../../../utils/theme.dart';

/// Participant count selection widget
class BookingParticipantSelection extends StatelessWidget {
  final int participants;
  final BookingSlot? selectedSlot;
  final Function(int) onParticipantsChanged;

  const BookingParticipantSelection({
    super.key,
    required this.participants,
    required this.selectedSlot,
    required this.onParticipantsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Number of Participants',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: participants > 1 ? () {
                onParticipantsChanged(participants - 1);
              } : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$participants ${participants == 1 ? 'person' : 'people'}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              onPressed: (selectedSlot == null || participants < selectedSlot!.availableSpots) 
                  ? () {
                      onParticipantsChanged(participants + 1);
                    } 
                  : null,
              icon: const Icon(Icons.add_circle_outline),
            ),
            if (selectedSlot != null) ...[
              const SizedBox(width: 16),
              Text(
                'Max: ${selectedSlot!.availableSpots}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondaryText,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}