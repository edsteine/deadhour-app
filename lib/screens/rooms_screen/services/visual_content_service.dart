import 'dart:async';

import 'package:deadhour/utils/mock_data.dart';












/// Service for managing visual content (photos, check-ins, stories)
/// Addresses the critical missing visual content from TAB_ANALYSIS_REPORT.md
class VisualContentService {
  static final VisualContentService _instance = VisualContentService._internal();
  factory VisualContentService() => _instance;
  VisualContentService._internal();

  // Visual content storage
  final Map<String, List<VenuePhoto>> _venuePhotos = {};
  final Map<String, List<CheckInStory>> _checkInStories = {};
  final Map<String, List<VenueEvent>> _venueEvents = {};

  /// Get photos for a venue
  List<VenuePhoto> getVenuePhotos(String venueId) {
    return _venuePhotos[venueId] ?? [];
  }

  /// Get recent check-in stories for a venue
  List<CheckInStory> getCheckInStories(String venueId) {
    return _checkInStories[venueId] ?? [];
  }

  /// Get current events at a venue
  List<VenueEvent> getVenueEvents(String venueId) {
    final now = DateTime.now();
    return (_venueEvents[venueId] ?? [])
        .where((event) => event.startTime.isBefore(now) && event.endTime.isAfter(now))
        .toList();
  }

  /// Add a photo to a venue
  Future<void> addVenuePhoto(String venueId, VenuePhoto photo) async {
    _venuePhotos.putIfAbsent(venueId, () => []);
    _venuePhotos[venueId]!.insert(0, photo); // Add to beginning
    
    // Keep only last 50 photos per venue
    if (_venuePhotos[venueId]!.length > 50) {
      _venuePhotos[venueId] = _venuePhotos[venueId]!.take(50).toList();
    }
  }

  /// Add a check-in story
  Future<void> addCheckInStory(String venueId, CheckInStory story) async {
    _checkInStories.putIfAbsent(venueId, () => []);
    _checkInStories[venueId]!.insert(0, story);
    
    // Keep only stories from last 24 hours
    final cutoff = DateTime.now().subtract(const Duration(hours: 24));
    _checkInStories[venueId] = _checkInStories[venueId]!
        .where((story) => story.timestamp.isAfter(cutoff))
        .toList();
  }

  /// Get venue photo summary
  VenuePhotoSummary getPhotoSummary(String venueId) {
    final photos = getVenuePhotos(venueId);
    final recentPhotos = photos.where((p) => 
      p.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 7)))
    ).toList();

    return VenuePhotoSummary(
      totalPhotos: photos.length,
      recentPhotos: recentPhotos.length,
      categories: _getPhotoCategories(photos),
      featuredPhoto: photos.isNotEmpty ? photos.first : null,
      averageRating: _calculateAveragePhotoRating(photos),
    );
  }

  /// Get venue activity summary
  VenueActivity getVenueActivity(String venueId) {
    final stories = getCheckInStories(venueId);
    final events = getVenueEvents(venueId);
    final photos = getVenuePhotos(venueId);
    
    final recentActivity = stories.where((s) => 
      s.timestamp.isAfter(DateTime.now().subtract(const Duration(hours: 2)))
    ).length;

    return VenueActivity(
      currentVisitors: recentActivity,
      recentCheckIns: stories.length,
      liveEvents: events.length,
      buzzLevel: _calculateBuzzLevel(stories, events, photos),
      lastActivity: stories.isNotEmpty ? stories.first.timestamp : null,
    );
  }

  /// Initialize with sample visual content
  void initializeSampleContent() {
    final venues = MockData.venues;
    
    for (final venue in venues.take(10)) { // Add content to first 10 venues
      _generateSamplePhotos(venue.id);
      _generateSampleCheckIns(venue.id);
      _generateSampleEvents(venue.id);
    }
  }

  void _generateSamplePhotos(String venueId) {
    final photos = <VenuePhoto>[
      VenuePhoto(
        id: 'photo_${venueId}_1',
        venueId: venueId,
        imageUrl: 'https://picsum.photos/400/300?random=${venueId.hashCode}',
        caption: 'Amazing atmosphere during dead hours! 📸',
        userId: 'user_123',
        userName: 'Sarah M.',
        userAvatar: 'https://picsum.photos/50/50?random=user123',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        category: PhotoCategory.atmosphere,
        likes: 12,
        isFromDeal: true,
        dealId: 'deal_1',
      ),
      VenuePhoto(
        id: 'photo_${venueId}_2', 
        venueId: venueId,
        imageUrl: 'https://picsum.photos/400/300?random=${venueId.hashCode + 1}',
        caption: 'Perfect quiet time for working ☕',
        userId: 'user_456',
        userName: 'Ahmed K.',
        userAvatar: 'https://picsum.photos/50/50?random=user456',
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        category: PhotoCategory.ambiance,
        likes: 8,
        isFromDeal: false,
      ),
      VenuePhoto(
        id: 'photo_${venueId}_3',
        venueId: venueId,
        imageUrl: 'https://picsum.photos/400/300?random=${venueId.hashCode + 2}',
        caption: 'Great deal on traditional mint tea! 🍃',
        userId: 'user_789',
        userName: 'Fatima R.',
        userAvatar: 'https://picsum.photos/50/50?random=user789',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        category: PhotoCategory.food,
        likes: 25,
        isFromDeal: true,
        dealId: 'deal_2',
      ),
    ];
    
    _venuePhotos[venueId] = photos;
  }

  void _generateSampleCheckIns(String venueId) {
    final stories = <CheckInStory>[
      CheckInStory(
        id: 'story_${venueId}_1',
        venueId: venueId,
        userId: 'user_111',
        userName: 'Youssef A.',
        userAvatar: 'https://picsum.photos/50/50?random=user111',
        message: 'Enjoying the peaceful afternoon here! Perfect for remote work.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        mood: CheckInMood.relaxed,
        hasPhoto: true,
        photoUrl: 'https://picsum.photos/150/150?random=${venueId.hashCode + 10}',
        dealUsed: true,
        savings: 25.0,
      ),
      CheckInStory(
        id: 'story_${venueId}_2',
        venueId: venueId,
        userId: 'user_222',
        userName: 'Aicha M.',
        userAvatar: 'https://picsum.photos/50/50?random=user222',
        message: 'Great service during off-peak hours!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        mood: CheckInMood.happy,
        hasPhoto: false,
        dealUsed: false,
      ),
    ];
    
    _checkInStories[venueId] = stories;
  }

  void _generateSampleEvents(String venueId) {
    final now = DateTime.now();
    final events = <VenueEvent>[
      VenueEvent(
        id: 'event_${venueId}_1',
        venueId: venueId,
        title: 'Quiet Hours - Perfect for Study',
        description: 'Peaceful environment ideal for work and study',
        startTime: now.subtract(const Duration(hours: 1)),
        endTime: now.add(const Duration(hours: 2)),
        eventType: EventType.quietHours,
        isRecurring: true,
        attendeeCount: 8,
      ),
      VenueEvent(
        id: 'event_${venueId}_2',
        venueId: venueId,
        title: 'Traditional Music Session',
        description: 'Local musicians playing traditional Moroccan music',
        startTime: now.add(const Duration(hours: 3)),
        endTime: now.add(const Duration(hours: 5)),
        eventType: EventType.liveMusic,
        isRecurring: false,
        attendeeCount: 15,
      ),
    ];
    
    _venueEvents[venueId] = events;
  }

  Map<PhotoCategory, int> _getPhotoCategories(List<VenuePhoto> photos) {
    final categories = <PhotoCategory, int>{};
    for (final photo in photos) {
      categories[photo.category] = (categories[photo.category] ?? 0) + 1;
    }
    return categories;
  }

  double _calculateAveragePhotoRating(List<VenuePhoto> photos) {
    if (photos.isEmpty) return 0.0;
    final totalLikes = photos.fold(0, (sum, photo) => sum + photo.likes);
    return totalLikes / photos.length;
  }

  BuzzLevel _calculateBuzzLevel(List<CheckInStory> stories, List<VenueEvent> events, List<VenuePhoto> photos) {
    final recentStories = stories.where((s) => 
      s.timestamp.isAfter(DateTime.now().subtract(const Duration(hours: 2)))
    ).length;
    
    final recentPhotos = photos.where((p) => 
      p.timestamp.isAfter(DateTime.now().subtract(const Duration(hours: 4)))
    ).length;
    
    final totalActivity = recentStories + events.length + recentPhotos;
    
    if (totalActivity >= 10) return BuzzLevel.buzzing;
    if (totalActivity >= 5) return BuzzLevel.active;
    if (totalActivity >= 2) return BuzzLevel.moderate;
    return BuzzLevel.quiet;
  }
}

