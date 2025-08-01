import 'media_content.dart';

/// Media upload result
class MediaUploadResult {
  final bool success;
  final String message;
  final MediaContent? mediaContent;

  const MediaUploadResult({
    required this.success,
    required this.message,
    this.mediaContent,
  });
}