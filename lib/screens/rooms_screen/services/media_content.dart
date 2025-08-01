

/// Media content model
class MediaContent {
  final String id;
  final String roomId;
  final String userId;
  final String userName;
  final String userAvatar;
  final MediaType type;
  final String content; // URL or path
  final String caption;
  final DateTime timestamp;
  final int likes;
  final int comments;
  final String? dealId;
  final bool isFromDeal;
  final bool isLikedByUser;

  const MediaContent({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.type,
    required this.content,
    required this.caption,
    required this.timestamp,
    required this.likes,
    required this.comments,
    this.dealId,
    required this.isFromDeal,
    this.isLikedByUser = false,
  });

  MediaContent copyWith({
    String? id,
    String? roomId,
    String? userId,
    String? userName,
    String? userAvatar,
    MediaType? type,
    String? content,
    String? caption,
    DateTime? timestamp,
    int? likes,
    int? comments,
    String? dealId,
    bool? isFromDeal,
    bool? isLikedByUser,
  }) {
    return MediaContent(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      type: type ?? this.type,
      content: content ?? this.content,
      caption: caption ?? this.caption,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      dealId: dealId ?? this.dealId,
      isFromDeal: isFromDeal ?? this.isFromDeal,
      isLikedByUser: isLikedByUser ?? this.isLikedByUser,
    );
  }
}