

/// Check-in story model
class CheckInStory {
  final String id;
  final String venueId;
  final String userId;
  final String userName;
  final String userAvatar;
  final String message;
  final DateTime timestamp;
  final CheckInMood mood;
  final bool hasPhoto;
  final String? photoUrl;
  final bool dealUsed;
  final double? savings;

  CheckInStory({
    required this.id,
    required this.venueId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.message,
    required this.timestamp,
    required this.mood,
    required this.hasPhoto,
    this.photoUrl,
    required this.dealUsed,
    this.savings,
  });
}