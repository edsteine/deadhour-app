import 'dart:async';

/// Comprehensive notification system for DeadHour app
/// Handles deal alerts, community activity notifications, and cultural calendar reminders
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal() {
    // Initialize with AI recommendations
    generateAIRecommendationNotifications();
  }

  // Mock notification storage
  final List<Map<String, dynamic>> _notifications = [];
  final Map<String, Map<String, dynamic>> _userNotificationSettings = {
    'user_current': {
      'dealAlerts': true,
      'communityActivity': true,
      'prayerReminders': true,
      'bookingUpdates': true,
      'friendActivity': true,
      'venueUpdates': true,
      'culturalEvents': true,
    },
  };

  // Active notification subscriptions
  final Map<String, List<String>> _subscriptions = {
    'dealAlerts': ['venue_1', 'venue_2'],
    'venueUpdates': ['venue_1', 'venue_3'],
    'communityRooms': ['food', 'entertainment'],
  };

  // AI recommendation notifications
  void generateAIRecommendationNotifications() {
    // Generate AI-based venue recommendations as notifications
    final aiRecommendations = [
      {
        'id': 'ai_rec_${DateTime.now().millisecondsSinceEpoch}',
        'type': 'ai_recommendation',
        'title': '🤖 AI Suggestion: Discover Café Atlas',
        'body': 'Based on your preferences, you might enjoy this cozy café with great reviews!',
        'timestamp': DateTime.now(),
        'venueId': 'venue_atlas',
        'isRead': false,
        'priority': 'medium',
        'category': 'ai_recommendations',
        'actionUrl': '/venue/venue_atlas',
      },
      {
        'id': 'ai_rec_${DateTime.now().millisecondsSinceEpoch + 1}',
        'type': 'ai_recommendation', 
        'title': '✨ Personalized for You: Riad Spa',
        'body': 'AI noticed you like wellness venues. Try this highly-rated spa!',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'venueId': 'venue_riad_spa',
        'isRead': false,
        'priority': 'low',
        'category': 'ai_recommendations',
        'actionUrl': '/venue/venue_riad_spa',
      },
    ];
    
    // Add to notifications list
    _recentNotifications.addAll(aiRecommendations);
  }

  // Notification history
  final List<Map<String, dynamic>> _recentNotifications = [
    {
      'id': 'notif_1',
      'type': 'deal_alert',
      'title': '🔥 30% Off at Café Central',
      'body': 'Dead hour special until 4 PM - Save 45 MAD on your order!',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 15)),
      'venueId': 'venue_1',
      'dealId': 'deal_1',
      'isRead': false,
      'priority': 'high',
      'category': 'deals',
    },
    {
      'id': 'notif_2',
      'type': 'community_activity',
      'title': '👥 New check-in at Riad Restaurant',
      'body': 'Sarah_Guide visited and rated it 5 stars: "Perfect tagine!"',
      'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
      'venueId': 'venue_2',
      'userId': 'user_sarah',
      'isRead': false,
      'priority': 'medium',
      'category': 'community',
    },
    {
      'id': 'notif_3',
      'type': 'prayer_reminder',
      'title': '🕌 Asr Prayer in 15 minutes',
      'body': 'Prayer time at 15:45 - Plan your venue visits accordingly',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'prayerName': 'Asr',
      'prayerTime': '15:45',
      'isRead': true,
      'priority': 'medium',
      'category': 'cultural',
    },
    {
      'id': 'notif_4',
      'type': 'friend_activity',
      'title': '🎉 Ahmed_Casa booked a group table',
      'body': 'Join the group booking at Moroccan Palace tonight at 8 PM',
      'timestamp': DateTime.now().subtract(const Duration(hours: 3)),
      'venueId': 'venue_3',
      'bookingId': 'booking_1',
      'friendId': 'user_ahmed',
      'isRead': true,
      'priority': 'high',
      'category': 'social',
    },
  ];

  /// Get all notifications for current user
  List<Map<String, dynamic>> getAllNotifications() {
    return List.from(_recentNotifications)
      ..sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
  }

  /// Get unread notifications count
  int getUnreadCount() {
    return _recentNotifications.where((notif) => !notif['isRead']).length;
  }

  /// Get notifications by category
  List<Map<String, dynamic>> getNotificationsByCategory(String category) {
    return _recentNotifications.where((notif) => notif['category'] == category).toList()
      ..sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
  }

  /// Mark notification as read
  void markAsRead(String notificationId) {
    final index = _recentNotifications.indexWhere((notif) => notif['id'] == notificationId);
    if (index != -1) {
      _recentNotifications[index]['isRead'] = true;
    }
  }

  /// Mark all notifications as read
  void markAllAsRead() {
    for (final notif in _recentNotifications) {
      notif['isRead'] = true;
    }
  }

  /// Create and send deal alert notification
  void sendDealAlert({
    required String venueId,
    required String dealId,
    required String venueName,
    required String dealTitle,
    required double discountPercent,
    required String validUntil,
  }) {
    final notification = {
      'id': 'deal_${DateTime.now().millisecondsSinceEpoch}',
      'type': 'deal_alert',
      'title': '🔥 ${discountPercent.toInt()}% Off at $venueName',
      'body': '$dealTitle - Valid until $validUntil',
      'timestamp': DateTime.now(),
      'venueId': venueId,
      'dealId': dealId,
      'isRead': false,
      'priority': 'high',
      'category': 'deals',
      'actionUrl': '/venue/$venueId/deals',
    };

    _addNotification(notification);
  }

  /// Send community activity notification
  void sendCommunityActivityNotification({
    required String activityType,
    required String venueId,
    required String venueName,
    required String username,
    required String activityDescription,
  }) {
    final notification = {
      'id': 'community_${DateTime.now().millisecondsSinceEpoch}',
      'type': 'community_activity',
      'title': '👥 $activityType at $venueName',
      'body': '$username $activityDescription',
      'timestamp': DateTime.now(),
      'venueId': venueId,
      'username': username,
      'isRead': false,
      'priority': 'medium',
      'category': 'community',
      'actionUrl': '/venue/$venueId',
    };

    _addNotification(notification);
  }

  /// Send prayer time reminder
  void sendPrayerReminder({
    required String prayerName,
    required String prayerTime,
    required int minutesBefore,
  }) {
    final notification = {
      'id': 'prayer_${DateTime.now().millisecondsSinceEpoch}',
      'type': 'prayer_reminder',
      'title': '🕌 $prayerName Prayer in $minutesBefore minutes',
      'body': 'Prayer time at $prayerTime - Plan your venue visits accordingly',
      'timestamp': DateTime.now(),
      'prayerName': prayerName,
      'prayerTime': prayerTime,
      'isRead': false,
      'priority': 'medium',
      'category': 'cultural',
    };

    _addNotification(notification);
  }

  /// Send friend activity notification
  void sendFriendActivityNotification({
    required String friendId,
    required String friendName,
    required String activityType,
    required String activityDescription,
    String? venueId,
    String? bookingId,
  }) {
    final notification = {
      'id': 'friend_${DateTime.now().millisecondsSinceEpoch}',
      'type': 'friend_activity',
      'title': '🎉 $friendName $activityType',
      'body': activityDescription,
      'timestamp': DateTime.now(),
      'friendId': friendId,
      'friendName': friendName,
      'venueId': venueId,
      'bookingId': bookingId,
      'isRead': false,
      'priority': 'high',
      'category': 'social',
      'actionUrl': venueId != null ? '/venue/$venueId' : '/social',
    };

    _addNotification(notification);
  }

  /// Send booking update notification
  void sendBookingUpdateNotification({
    required String bookingId,
    required String venueName,
    required String updateType,
    required String updateMessage,
    String? venueId,
  }) {
    final notification = {
      'id': 'booking_${DateTime.now().millisecondsSinceEpoch}',
      'type': 'booking_update',
      'title': '📅 Booking $updateType - $venueName',
      'body': updateMessage,
      'timestamp': DateTime.now(),
      'bookingId': bookingId,
      'venueId': venueId,
      'isRead': false,
      'priority': 'high',
      'category': 'bookings',
      'actionUrl': '/bookings/$bookingId',
    };

    _addNotification(notification);
  }

  /// Send cultural event notification
  void sendCulturalEventNotification({
    required String eventName,
    required String eventDescription,
    required DateTime eventDate,
  }) {
    final notification = {
      'id': 'cultural_${DateTime.now().millisecondsSinceEpoch}',
      'type': 'cultural_event',
      'title': '🎊 $eventName Today',
      'body': eventDescription,
      'timestamp': DateTime.now(),
      'eventName': eventName,
      'eventDate': eventDate,
      'isRead': false,
      'priority': 'medium',
      'category': 'cultural',
    };

    _addNotification(notification);
  }

  /// Get notification settings for user
  Map<String, dynamic> getNotificationSettings() {
    return Map.from(_userNotificationSettings['user_current'] ?? {});
  }

  /// Update notification settings
  void updateNotificationSettings(Map<String, bool> newSettings) {
    _userNotificationSettings['user_current'] = {
      ..._userNotificationSettings['user_current'] ?? {},
      ...newSettings,
    };
  }

  /// Subscribe to venue updates
  void subscribeToVenue(String venueId) {
    if (!_subscriptions['venueUpdates']!.contains(venueId)) {
      _subscriptions['venueUpdates']!.add(venueId);
    }
  }

  /// Unsubscribe from venue updates
  void unsubscribeFromVenue(String venueId) {
    _subscriptions['venueUpdates']!.remove(venueId);
  }

  /// Subscribe to deal alerts for venue
  void subscribeToDealAlerts(String venueId) {
    if (!_subscriptions['dealAlerts']!.contains(venueId)) {
      _subscriptions['dealAlerts']!.add(venueId);
    }
  }

  /// Get notification statistics
  Map<String, dynamic> getNotificationStats() {
    final total = _recentNotifications.length;
    final unread = getUnreadCount();
    final byCategory = <String, int>{};
    
    for (final notif in _recentNotifications) {
      final category = notif['category'] as String;
      byCategory[category] = (byCategory[category] ?? 0) + 1;
    }

    return {
      'total': total,
      'unread': unread,
      'readRate': total > 0 ? ((total - unread) / total * 100).round() : 0,
      'byCategory': byCategory,
      'lastNotification': _recentNotifications.isNotEmpty 
          ? _recentNotifications.first['timestamp'] 
          : null,
    };
  }

  /// Get trending notification types
  List<Map<String, dynamic>> getTrendingNotificationTypes() {
    final typeCounts = <String, int>{};
    final recent = _recentNotifications
        .where((n) => DateTime.now().difference(n['timestamp']).inDays < 7)
        .toList();

    for (final notif in recent) {
      final type = notif['type'] as String;
      typeCounts[type] = (typeCounts[type] ?? 0) + 1;
    }

    final trending = typeCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return trending.map((entry) => {
      'type': entry.key,
      'count': entry.value,
      'displayName': _getDisplayName(entry.key),
      'icon': _getTypeIcon(entry.key),
    }).toList();
  }

  /// Schedule smart notifications based on user behavior
  void scheduleSmartNotifications() {
    // Mock implementation - would integrate with platform notification system
    
    // Schedule deal alerts for user's preferred times
    _scheduleDealAlerts();
    
    // Schedule prayer reminders
    _schedulePrayerReminders();
    
    // Schedule community activity digest
    _scheduleCommunityDigest();
  }

  /// Get notification delivery preferences
  Map<String, dynamic> getDeliveryPreferences() {
    return {
      'inApp': true,
      'push': true,
      'email': false,
      'sms': false,
      'quietHours': {
        'enabled': true,
        'start': '22:00',
        'end': '07:00',
      },
      'priorityOverride': true, // High priority notifications bypass quiet hours
      'groupSimilar': true, // Group similar notifications
      'smartDelivery': true, // AI-optimized delivery timing
    };
  }

  /// Process notification queue and deliver appropriately
  Future<void> processNotificationQueue() async {
    // Mock implementation for notification processing
    final unprocessed = _notifications.where((n) => n['status'] == 'pending').toList();
    
    for (final notification in unprocessed) {
      await _deliverNotification(notification);
      notification['status'] = 'delivered';
      notification['deliveredAt'] = DateTime.now();
    }
  }

  /// Clear old notifications (keep last 100)
  void clearOldNotifications() {
    if (_recentNotifications.length > 100) {
      _recentNotifications.removeRange(100, _recentNotifications.length);
    }
  }

  // Private helper methods

  void _addNotification(Map<String, dynamic> notification) {
    // Check if notifications are enabled for this type
    final settings = getNotificationSettings();
    final notificationType = notification['type'] as String;
    
    bool shouldSend = false;
    switch (notificationType) {
      case 'deal_alert':
        shouldSend = settings['dealAlerts'] ?? true;
        break;
      case 'community_activity':
        shouldSend = settings['communityActivity'] ?? true;
        break;
      case 'prayer_reminder':
        shouldSend = settings['prayerReminders'] ?? true;
        break;
      case 'friend_activity':
        shouldSend = settings['friendActivity'] ?? true;
        break;
      case 'booking_update':
        shouldSend = settings['bookingUpdates'] ?? true;
        break;
      case 'cultural_event':
        shouldSend = settings['culturalEvents'] ?? true;
        break;
    }

    if (shouldSend) {
      _recentNotifications.insert(0, notification);
      _notifications.add({...notification, 'status': 'pending'});
    }
  }

  Future<void> _deliverNotification(Map<String, dynamic> notification) async {
    // Mock delivery - would integrate with Firebase Cloud Messaging, etc.
    await Future.delayed(const Duration(milliseconds: 100));
  }

  void _scheduleDealAlerts() {
    // Mock scheduling for preferred deal alert times
    // Would integrate with platform scheduling services
  }

  void _schedulePrayerReminders() {
    // Mock scheduling for prayer time reminders
    // Would calculate prayer times and schedule accordingly
  }

  void _scheduleCommunityDigest() {
    // Mock scheduling for daily community activity digest
    // Would send summary of community activity at preferred time
  }

  String _getDisplayName(String type) {
    switch (type) {
      case 'deal_alert':
        return 'Deal Alerts';
      case 'community_activity':
        return 'Community Activity';
      case 'prayer_reminder':
        return 'Prayer Reminders';
      case 'friend_activity':
        return 'Friend Activity';
      case 'booking_update':
        return 'Booking Updates';
      case 'cultural_event':
        return 'Cultural Events';
      default:
        return type.replaceAll('_', ' ').split(' ').map((w) => 
            w.isEmpty ? w : w[0].toUpperCase() + w.substring(1)).join(' ');
    }
  }

  String _getTypeIcon(String type) {
    switch (type) {
      case 'deal_alert':
        return '🔥';
      case 'community_activity':
        return '👥';
      case 'prayer_reminder':
        return '🕌';
      case 'friend_activity':
        return '🎉';
      case 'booking_update':
        return '📅';
      case 'cultural_event':
        return '🎊';
      default:
        return '📱';
    }
  }

  /// Get smart notification suggestions
  List<Map<String, dynamic>> getSmartSuggestions() {
    return [
      {
        'type': 'venue_subscription',
        'title': 'Subscribe to favorite venues',
        'description': 'Get notified when your favorite venues post new deals',
        'action': 'subscribe',
        'priority': 'medium',
      },
      {
        'type': 'friend_notifications',
        'title': 'Enable friend activity alerts',
        'description': 'Know when your friends discover great venues',
        'action': 'enable_friends',
        'priority': 'low',
      },
      {
        'type': 'cultural_reminders',
        'title': 'Cultural event reminders',
        'description': 'Stay informed about Islamic holidays and cultural events',
        'action': 'enable_cultural',
        'priority': 'medium',
      },
    ];
  }
}