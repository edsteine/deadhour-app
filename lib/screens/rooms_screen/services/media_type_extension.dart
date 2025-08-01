

extension MediaTypeExtension on MediaType {
  String get displayName {
    switch (this) {
      case MediaType.photo:
        return 'Photo';
      case MediaType.video:
        return 'Video';
      case MediaType.audio:
        return 'Audio';
    }
  }

  String get icon {
    switch (this) {
      case MediaType.photo:
        return '📸';
      case MediaType.video:
        return '🎥';
      case MediaType.audio:
        return '🎵';
    }
  }
}