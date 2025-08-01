import 'photo_category.dart';

/// Venue photo model
class VenuePhoto {
  final String id;
  final String venueId;
  final String imageUrl;
  final String caption;
  final String userId;
  final String userName;
  final String userAvatar;
  final DateTime timestamp;
  final PhotoCategory category;
  final int likes;
  final bool isFromDeal;
  final String? dealId;

  VenuePhoto({
    required this.id,
    required this.venueId,
    required this.imageUrl,
    required this.caption,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.timestamp,
    required this.category,
    required this.likes,
    required this.isFromDeal,
    this.dealId,
  });
}