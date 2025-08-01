import '../../services/real_time_booking_service.dart';
import 'package:flutter/material.dart';
import '../../../../utils/theme.dart';

/// Real-time availability status display
class BookingAvailabilityStatus extends StatelessWidget {
  final BookingAvailability? availability;

  const BookingAvailabilityStatus({
    super.key,
    required this.availability,
  });

  @override
  Widget build(BuildContext context) {
    if (availability == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: availability!.isAvailable 
            ? AppTheme.moroccoGreen.withValues(alpha: 0.1)
            : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: availability!.isAvailable ? AppTheme.moroccoGreen : Colors.red,
        ),
      ),
      child: Row(
        children: [
          Icon(
            availability!.isAvailable ? Icons.check_circle : Icons.error,
            color: availability!.isAvailable ? AppTheme.moroccoGreen : Colors.red,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  availability!.isAvailable ? 'Available Now!' : 'Limited Availability',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: availability!.isAvailable ? AppTheme.moroccoGreen : Colors.red,
                  ),
                ),
                Text(
                  '${availability!.availableSlots} of ${availability!.totalSlots} slots available',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            'From ${availability!.averagePrice.toInt()} MAD',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.moroccoGreen,
            ),
          ),
        ],
      ),
    );
  }
}