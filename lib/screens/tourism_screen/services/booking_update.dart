


/// Booking update for real-time notifications
class BookingUpdate {
  final BookingUpdateType type;
  final String experienceId;
  final Booking? booking;

  const BookingUpdate({
    required this.type,
    required this.experienceId,
    this.booking,
  });
}