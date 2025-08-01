/// Media statistics
class MediaStats {
  final int totalMedia;
  final int photoCount;
  final int videoCount;
  final int totalEngagement;
  final DateTime? recentActivity;

  const MediaStats({
    required this.totalMedia,
    required this.photoCount,
    required this.videoCount,
    required this.totalEngagement,  
    this.recentActivity,
  });
}