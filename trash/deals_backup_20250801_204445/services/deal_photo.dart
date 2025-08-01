class DealPhoto {
  final String id;
  final String url;
  final String userId;
  final String userName;
  final String caption;
  final DateTime timestamp;
  final int likes;

  DealPhoto({
    required this.id,
    required this.url,
    required this.userId,
    required this.userName,
    required this.caption,
    required this.timestamp,
    required this.likes,
  });
}