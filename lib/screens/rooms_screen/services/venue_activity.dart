

/// Venue activity summary
class VenueActivity {
  final int currentVisitors;
  final int recentCheckIns;
  final int liveEvents;
  final BuzzLevel buzzLevel;
  final DateTime? lastActivity;

  VenueActivity({
    required this.currentVisitors,
    required this.recentCheckIns,
    required this.liveEvents,
    required this.buzzLevel,
    this.lastActivity,
  });
}