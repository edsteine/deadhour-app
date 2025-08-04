import 'event_type.dart';

/// Venue event model
class VenueEvent {
  final String id;
  final String venueId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final EventType eventType;
  final bool isRecurring;
  final int attendeeCount;

  VenueEvent({
    required this.id,
    required this.venueId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.eventType,
    required this.isRecurring,
    required this.attendeeCount,
  });
}