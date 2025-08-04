import 'booking.dart';
import 'booking_error_type.dart';
import 'booking_slot.dart';

/// Booking result
class BookingResult {
  final bool success;
  final String message;
  final Booking? booking;
  final BookingErrorType? errorType;
  final List<BookingSlot>? alternativeSlots;

  const BookingResult({
    required this.success,
    required this.message,
    this.booking,
    this.errorType,
    this.alternativeSlots,
  });
}