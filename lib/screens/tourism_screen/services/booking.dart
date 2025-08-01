

/// Booking record
class Booking {
  final String id;
  final String experienceId;
  final String slotId;
  final String userId;
  final String userName;
  final String userEmail;
  final int participants;
  final double totalPrice;
  final DateTime bookingTime;
  BookingStatus status;
  final String confirmationCode;
  final Map<String, dynamic>? specialRequests;
  final DateTime cancellationDeadline;
  final bool canCancel;

  Booking({
    required this.id,
    required this.experienceId,
    required this.slotId,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.participants,
    required this.totalPrice,
    required this.bookingTime,
    required this.status,
    required this.confirmationCode,
    this.specialRequests,
    required this.cancellationDeadline,
    required this.canCancel,
  });
}