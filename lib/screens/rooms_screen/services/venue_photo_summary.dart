


/// Photo summary for venue
class VenuePhotoSummary {
  final int totalPhotos;
  final int recentPhotos;
  final Map<PhotoCategory, int> categories;
  final VenuePhoto? featuredPhoto;
  final double averageRating;

  VenuePhotoSummary({
    required this.totalPhotos,
    required this.recentPhotos,
    required this.categories,
    this.featuredPhoto,
    required this.averageRating,
  });
}