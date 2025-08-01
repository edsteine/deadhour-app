/// Booking availability information
class BookingAvailability {
  final String experienceId;
  final bool isAvailable;
  final DateTime? nextAvailableSlot;
  final int totalSlots;
  final int availableSlots;
  final double averagePrice;
  final DateTime lastUpdated;
  final Duration bookingWindow;

  const BookingAvailability({
    required this.experienceId,
    required this.isAvailable,
    this.nextAvailableSlot,
    required this.totalSlots,
    required this.availableSlots,
    required this.averagePrice,
    required this.lastUpdated,
    required this.bookingWindow,
  });
}