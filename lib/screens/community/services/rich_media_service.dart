import 'dart:async';
import '../../../utils/mock_data.dart';
import 'media_type.dart';
import 'media_content.dart';
import 'media_thread.dart';
import 'media_upload_result.dart';
import 'media_stats.dart';



/// Rich media service for community content sharing
/// Addresses critical missing photos/videos from TAB_ANALYSIS_REPORT.md
class RichMediaService {
  static final RichMediaService _instance = RichMediaService._internal();
  factory RichMediaService() => _instance;
  RichMediaService._internal();

  // Media content storage
  final Map<String, List<MediaContent>> _roomMedia = {};
  final Map<String, List<MediaThread>> _mediaThreads = {};
  bool _isInitialized = false;

  /// Initialize with sample media content
  void initializeMediaService() {
    if (_isInitialized) return;
    
    _generateSampleMediaContent();
    _isInitialized = true;
  }

  /// Get media content for a room
  List<MediaContent> getRoomMedia(String roomId, {MediaType? type}) {
    final media = _roomMedia[roomId] ?? [];
    if (type != null) {
      return media.where((m) => m.type == type).toList();
    }
    return media..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  /// Get recent photos for room preview
  List<MediaContent> getRecentPhotos(String roomId, {int limit = 6}) {
    return getRoomMedia(roomId, type: MediaType.photo)
        .take(limit)
        .toList();
  }

  /// Get media threads (organized discussions around media)
  List<MediaThread> getMediaThreads(String roomId) {
    return _mediaThreads[roomId] ?? [];
  }

  /// Add media content to room
  Future<MediaUploadResult> uploadMedia({
    required String roomId,
    required String userId,
    required String userName,
    required MediaType type,
    required String content,
    String? caption,
    String? dealId,
  }) async {
    final mediaId = 'media_${DateTime.now().millisecondsSinceEpoch}';
    
    final mediaContent = MediaContent(
      id: mediaId,
      roomId: roomId,
      userId: userId,
      userName: userName,
      userAvatar: 'https://picsum.photos/50/50?random=${userId.hashCode}',
      type: type,
      content: content,
      caption: caption ?? '',
      timestamp: DateTime.now(),
      likes: 0,
      comments: 0,
      dealId: dealId,
      isFromDeal: dealId != null,
    );

    _roomMedia.putIfAbsent(roomId, () => []);
    _roomMedia[roomId]!.insert(0, mediaContent);

    // Keep only recent 50 media items per room
    if (_roomMedia[roomId]!.length > 50) {
      _roomMedia[roomId] = _roomMedia[roomId]!.take(50).toList();
    }

    return MediaUploadResult(
      success: true,
      message: 'Media uploaded successfully',
      mediaContent: mediaContent,
    );
  }

  /// Like/unlike media content
  Future<int> toggleLike(String mediaId, String userId) async {
    for (final roomMedia in _roomMedia.values) {
      final mediaIndex = roomMedia.indexWhere((m) => m.id == mediaId);
      if (mediaIndex != -1) {
        final media = roomMedia[mediaIndex];
        final newLikes = media.likes + (media.isLikedByUser ? -1 : 1);
        
        roomMedia[mediaIndex] = media.copyWith(
          likes: newLikes,
          isLikedByUser: !media.isLikedByUser,
        );
        
        return newLikes;
      }
    }
    return 0;
  }

  /// Add comment to media
  Future<bool> addComment({
    required String mediaId,
    required String userId,
    required String userName,
    required String comment,
  }) async {
    for (final roomMedia in _roomMedia.values) {
      final mediaIndex = roomMedia.indexWhere((m) => m.id == mediaId);
      if (mediaIndex != -1) {
        final media = roomMedia[mediaIndex];
        roomMedia[mediaIndex] = media.copyWith(
          comments: media.comments + 1,
        );
        return true;
      }
    }
    return false;
  }

  /// Create media thread for organized discussion
  Future<MediaThread?> createMediaThread({
    required String roomId,
    required String mediaId,
    required String title,
    required String creatorId,
  }) async {
    final threadId = 'thread_${DateTime.now().millisecondsSinceEpoch}';
    
    final thread = MediaThread(
      id: threadId,
      roomId: roomId,
      mediaId: mediaId,
      title: title,
      creatorId: creatorId,
      createdAt: DateTime.now(),
      messageCount: 0,
      participantCount: 1,
      lastActivity: DateTime.now(),
    );

    _mediaThreads.putIfAbsent(roomId, () => []);
    _mediaThreads[roomId]!.insert(0, thread);
    
    return thread;
  }

  /// Get media statistics for room
  MediaStats getRoomMediaStats(String roomId) {
    final media = _roomMedia[roomId] ?? [];
    final photos = media.where((m) => m.type == MediaType.photo).length;
    final videos = media.where((m) => m.type == MediaType.video).length;
    final totalLikes = media.fold(0, (sum, m) => sum + m.likes);
    final totalComments = media.fold(0, (sum, m) => sum + m.comments);
    
    return MediaStats(
      totalMedia: media.length,
      photoCount: photos,
      videoCount: videos,
      totalEngagement: totalLikes + totalComments,
      recentActivity: media.isNotEmpty ? media.first.timestamp : null,
    );
  }

  void _generateSampleMediaContent() {
    final rooms = MockData.rooms;
    
    for (final room in rooms.take(8)) {
      _generateRoomMedia(room.id, room.category);
    }
  }

  void _generateRoomMedia(String roomId, String category) {
    final mediaList = <MediaContent>[];
    final mediaCount = (roomId.hashCode % 8) + 3; // 3-10 media items per room
    
    for (int i = 0; i < mediaCount; i++) {
      final userId = 'user_${roomId}_$i';
      final mediaId = 'media_${roomId}_$i';
      final type = i % 3 == 0 ? MediaType.video : MediaType.photo;
      
      final mediaContent = MediaContent(
        id: mediaId,
        roomId: roomId,
        userId: userId,
        userName: _getSampleUserName(i),
        userAvatar: 'https://picsum.photos/50/50?random=${userId.hashCode}',
        type: type,
        content: type == MediaType.photo 
            ? 'https://picsum.photos/400/300?random=${mediaId.hashCode}'
            : 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        caption: _getSampleCaption(category, type, i),
        timestamp: DateTime.now().subtract(Duration(hours: i * 2)),
        likes: (mediaId.hashCode % 25) + 1,
        comments: (mediaId.hashCode % 8) + 1,
        dealId: i % 4 == 0 ? 'deal_$i' : null,
        isFromDeal: i % 4 == 0,
        isLikedByUser: i % 3 == 0,
      );
      
      mediaList.add(mediaContent);
    }
    
    _roomMedia[roomId] = mediaList;
    
    // Generate some media threads
    _generateMediaThreads(roomId, mediaList);
  }

  void _generateMediaThreads(String roomId, List<MediaContent> media) {
    final threads = <MediaThread>[];
    
    // Create threads for popular media (high engagement)
    final popularMedia = media.where((m) => m.likes > 15 || m.comments > 5).toList();
    
    for (final media in popularMedia.take(2)) {
      final thread = MediaThread(
        id: 'thread_${media.id}',
        roomId: roomId,
        mediaId: media.id,
        title: _getThreadTitle(media),
        creatorId: media.userId,
        createdAt: media.timestamp.add(const Duration(minutes: 30)),
        messageCount: (media.comments * 2) + (media.id.hashCode % 5),
        participantCount: media.comments + (media.id.hashCode % 3),
        lastActivity: DateTime.now().subtract(Duration(minutes: media.id.hashCode % 120)),
      );
      
      threads.add(thread);
    }
    
    _mediaThreads[roomId] = threads;
  }

  String _getSampleUserName(int index) {
    final names = [
      'Ahmed K.', 'Sarah M.', 'Youssef A.', 'Fatima R.',
      'Hassan B.', 'Aicha L.', 'Omar T.', 'Khadija N.',
      'Mohamed S.', 'Laila H.', 'Karim D.', 'Zineb F.'
    ];
    return names[index % names.length];
  }

  String _getSampleCaption(String category, MediaType type, int index) {
    final captions = {
      'food': [
        '🍽️ Amazing tagine during dead hours - 40% off!',
        '☕ Perfect mint tea spot for afternoon work',
        '🥖 Fresh bread from this morning\'s batch',
        '🍯 Traditional honey pastries - so authentic!',
      ],
      'entertainment': [
        '🎮 Gaming setup during quiet hours - love it!',
        '🎬 Private cinema experience with friends',
        '🎵 Live music session - incredible atmosphere',
        '🎯 Friendly competition during dead hours',
      ],
      'wellness': [
        '💆 Relaxing spa treatment - highly recommend!',
        '🧘 Peaceful meditation session in the garden',
        '💪 Great workout with amazing city views',
        '🛁 Traditional hammam experience',
      ],
      'tourism': [
        '🏛️ Beautiful architecture in the medina',
        '🌅 Sunrise from Atlas Mountains viewpoint',
        '🎨 Traditional crafts workshop experience',
        '🐪 Desert adventure - unforgettable!',
      ],
    };
    
    final categoryCaption = captions[category] ?? captions['food']!;
    return categoryCaption[index % categoryCaption.length];
  }

  String _getThreadTitle(MediaContent media) {
    if (media.isFromDeal) {
      return 'Discussion: ${media.caption.split(' - ').first}';
    }
    
    switch (media.type) {
      case MediaType.photo:
        return 'Photo Discussion: ${media.caption.split(' ').take(4).join(' ')}...';
      case MediaType.video:  
        return 'Video Discussion: ${media.caption.split(' ').take(4).join(' ')}...';
      case MediaType.audio:
        return 'Audio Discussion: ${media.caption.split(' ').take(4).join(' ')}...';
    }
  }
}

