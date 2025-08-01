/// Media thread for organized discussions
class MediaThread {
  final String id;
  final String roomId;
  final String mediaId;
  final String title;
  final String creatorId;
  final DateTime createdAt;
  final int messageCount;
  final int participantCount;
  final DateTime lastActivity;

  const MediaThread({
    required this.id,
    required this.roomId,
    required this.mediaId,
    required this.title,
    required this.creatorId,
    required this.createdAt,
    required this.messageCount,
    required this.participantCount,
    required this.lastActivity,
  });
}