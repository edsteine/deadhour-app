/// Individual booking slot
class BookingSlot {
  final String id;
  final String experienceId;
  final DateTime dateTime;
  final Duration duration;
  final int maxCapacity;
  final int availableSpots;
  final bool isAvailable;
  final double pricePerPerson;
  final String guideId;
  final String guideName;

  const BookingSlot({
    required this.id,
    required this.experienceId,
    required this.dateTime,
    required this.duration,
    required this.maxCapacity,
    required this.availableSpots,
    required this.isAvailable,
    required this.pricePerPerson,
    required this.guideId,
    required this.guideName,
  });

  BookingSlot copyWith({
    String? id,
    String? experienceId,
    DateTime? dateTime,
    Duration? duration,
    int? maxCapacity,
    int? availableSpots,
    bool? isAvailable,
    double? pricePerPerson,
    String? guideId,
    String? guideName,
  }) {
    return BookingSlot(
      id: id ?? this.id,
      experienceId: experienceId ?? this.experienceId,
      dateTime: dateTime ?? this.dateTime,
      duration: duration ?? this.duration,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      availableSpots: availableSpots ?? this.availableSpots,
      isAvailable: isAvailable ?? this.isAvailable,
      pricePerPerson: pricePerPerson ?? this.pricePerPerson,
      guideId: guideId ?? this.guideId,
      guideName: guideName ?? this.guideName,
    );
  }
}