





import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Booking dialogs utility class
class BookingDialogs {
  /// Show booking success dialog
  static void showBookingSuccess(BuildContext context, Booking booking, String experienceTitle) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: AppTheme.moroccoGreen,
          size: 48,
        ),
        title: const Text('Booking Confirmed!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your booking has been confirmed for $experienceTitle',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Confirmation Code:'),
                      Text(
                        booking.confirmationCode,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Participants:'),
                      Text('${booking.participants} people'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Price:'),
                      Text(
                        '${booking.totalPrice.toInt()} MAD',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.moroccoGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'You will receive confirmation details via email shortly.',
              style: TextStyle(fontSize: 12, color: AppTheme.secondaryText),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close booking sheet
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  /// Show booking error dialog with alternative slots
  static void showBookingError(
    BuildContext context, 
    BookingResult result,
    Function(BookingSlot) onAlternativeSlotSelected,
    VoidCallback onContactSupport,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 48,
        ),
        title: const Text('Booking Failed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(result.message),
            if (result.alternativeSlots != null && result.alternativeSlots!.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Alternative Times Available:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ...result.alternativeSlots!.map((slot) => 
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.schedule, size: 16),
                  title: Text(
                    _formatDateTime(slot.dateTime),
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    '${slot.availableSpots} spots • ${slot.pricePerPerson.toInt()} MAD/person',
                    style: const TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onAlternativeSlotSelected(slot);
                  },
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Try Again'),
          ),
          if (result.errorType == BookingErrorType.noAvailability)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onContactSupport();
              },
              child: const Text('Contact Support'),
            ),
        ],
      ),
    );
  }

  /// Show support contact dialog
  static void showSupportContact(BuildContext context, SupportContact support) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('24/7 Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Need help with your booking? Our support team is available 24/7:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.phone, color: AppTheme.moroccoGreen),
              title: Text(support.phone),
              subtitle: const Text('Call us directly'),
              dense: true,
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: AppTheme.moroccoGreen),
              title: Text(support.whatsapp),
              subtitle: const Text('WhatsApp support'),
              dense: true,
            ),
            ListTile(
              leading: const Icon(Icons.email, color: AppTheme.moroccoGreen),
              title: Text(support.email),
              subtitle: const Text('Email support'),
              dense: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static String _formatDateTime(DateTime dateTime) {
    return '${_getWeekdayName(dateTime.weekday)} ${dateTime.day} ${_getMonthName(dateTime.month)} at ${_formatTime(dateTime)}';
  }

  static String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static String _getWeekdayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  static String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}