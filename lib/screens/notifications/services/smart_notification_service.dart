import 'dart:async';

import 'package:flutter/material.dart';

import '../services/notification_service.dart';
import 'digest_item.dart';
import 'notification_action.dart';
import 'notification_digest.dart';
import 'notification_frequency.dart';
import 'notification_group.dart';
import 'notification_interaction.dart';
import 'notification_suggested_action.dart';
import 'notification_summary.dart';
import 'smart_notification.dart';
import 'user_notification_preferences.dart';


/// Smart notification service to fight notification fatigue
/// Addresses critical notification apocalypse from TAB_ANALYSIS_REPORT.md
class SmartNotificationService {
  static final SmartNotificationService _instance = SmartNotificationService._internal();
  factory SmartNotificationService() => _instance;
  SmartNotificationService._internal();

  final NotificationService _baseService = NotificationService();
  
  // Smart grouping state
  final Map<String, NotificationGroup> _groups = {};
  final Map<String, UserNotificationPreferences> _userPreferences = {};
  final Map<String, NotificationFrequency> _frequencyLimits = {};
  
  // ML-based relevance scoring (simplified)
  final Map<String, double> _userInterestScores = {};
  final Map<String, DateTime> _lastNotificationTimes = {};
  
  Timer? _groupingTimer;
  Timer? _digestTimer;
  
  bool _isInitialized = false;

  /// Initialize smart notification system
  void initializeSmartNotifications() {
    if (_isInitialized) return;
    
    _initializeUserPreferences();
    _initializeFrequencyLimits();
    _startSmartGrouping();
    _startDigestScheduler();
    _isInitialized = true;
  }

  /// Get intelligently grouped notifications
  List<NotificationGroup> getGroupedNotifications() {
    _updateGroups();
    return _groups.values.toList()
        ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
  }

  /// Get smart notification summary to reduce spam
  NotificationSummary getSmartSummary() {
    final allNotifications = _baseService.getAllNotifications();
    final grouped = getGroupedNotifications();
    
    return NotificationSummary(
      totalNotifications: allNotifications.length,
      groupedCount: grouped.length,
      reductionPercentage: _calculateReduction(allNotifications.length, grouped.length),
      highPriorityCount: grouped.where((g) => g.priority == 'urgent').length,
      canDefer: grouped.where((g) => g.canDefer).length,
      nextDigestTime: _getNextDigestTime(),
    );
  }

  /// Smart notification filtering based on user behavior
  List<SmartNotification> getRelevantNotifications({
    int limit = 10,
    double relevanceThreshold = 0.6,
  }) {
    final allNotifications = _baseService.getAllNotifications();
    final smartNotifications = allNotifications.map((notification) {
      return SmartNotification(
        notification: notification,
        relevanceScore: _calculateRelevanceScore(notification),
        shouldGroup: _shouldGroup(notification),
        canDefer: _canDefer(notification),
        suggestedAction: _getSuggestedAction(notification),
      );
    }).toList();

    // Filter by relevance and sort by priority + relevance
    return smartNotifications
        .where((sn) => sn.relevanceScore >= relevanceThreshold)
        .toList()
        ..sort((a, b) {
          // High priority always first
          final aPriority = _getPriorityIndex(a.notification['priority'] as String?);
          final bPriority = _getPriorityIndex(b.notification['priority'] as String?);
          if (aPriority != bPriority) {
            return bPriority.compareTo(aPriority);
          }
          // Then by relevance score
          return b.relevanceScore.compareTo(a.relevanceScore);
        })
        ..take(limit).toList();
  }

  /// Process new notification with smart filtering
  Future<NotificationAction> processNewNotification(Map<String, dynamic> notification) async {
    // Check frequency limits first
    if (_isOverFrequencyLimit(notification)) {
      return NotificationAction.defer;
    }

    // Calculate relevance
    final relevanceScore = _calculateRelevanceScore(notification);
    
    // Check if should be grouped
    if (_shouldGroup(notification)) {
      _addToGroup(notification);
      return NotificationAction.group;
    }

    // Check if should be shown immediately
    if (relevanceScore >= 0.8 && notification['priority'] == 'high') {
      _updateUserInteraction(notification, NotificationInteraction.shown);
      return NotificationAction.show;
    }

    // Defer low-relevance notifications
    if (relevanceScore < 0.4) {
      return NotificationAction.defer;
    }

    // Default: add to queue for next digest
    return NotificationAction.queue;
  }

  /// Generate notification digest to reduce frequency
  NotificationDigest generateDigest({
    Duration period = const Duration(hours: 4),
  }) {
    final now = DateTime.now();
    final cutoff = now.subtract(period);
    
    final recentNotifications = _baseService.getAllNotifications()
        .where((n) => (n['timestamp'] as DateTime).isAfter(cutoff))
        .toList();

    final digestItems = <DigestItem>[];
    final groupedByType = <String, List<Map<String, dynamic>>>{};
    
    // Group by type for digest
    for (final notification in recentNotifications) {
      groupedByType.putIfAbsent(notification['type'] as String, () => []).add(notification);
    }

    // Create digest items
    for (final entry in groupedByType.entries) {
      final type = entry.key;
      final notifications = entry.value;
      
      if (notifications.length == 1) {
        digestItems.add(DigestItem(
          type: type,
          count: 1,
          summary: notifications.first['title'] as String,
          notifications: notifications,
          priority: notifications.first['priority'] as String,
        ));
      } else {
        digestItems.add(DigestItem(
          type: type,
          count: notifications.length,
          summary: _generateGroupSummary(type, notifications),
          notifications: notifications,
          priority: _getHighestPriority(notifications),
        ));
      }
    }

    return NotificationDigest(
      period: period,
      totalNotifications: recentNotifications.length,
      items: digestItems,
      generatedAt: now,
    );
  }

  /// Update user preferences to reduce noise
  void updateUserPreferences({
    bool enableSmartGrouping = true,
    Duration digestFrequency = const Duration(hours: 4),
    Set<String> mutedTypes = const {},
    Map<String, String> typePriorities = const {},
    bool enableQuietHours = true,
    TimeOfDay? quietStart,
    TimeOfDay? quietEnd,
  }) {
    final userId = 'current_user'; // Get from auth
    _userPreferences[userId] = UserNotificationPreferences(
      enableSmartGrouping: enableSmartGrouping,
      digestFrequency: digestFrequency,
      mutedTypes: mutedTypes,
      typePriorities: typePriorities,
      enableQuietHours: enableQuietHours,
      quietStart: quietStart ?? const TimeOfDay(hour: 22, minute: 0),
      quietEnd: quietEnd ?? const TimeOfDay(hour: 8, minute: 0),
    );
  }

  /// Handle notification interaction for ML learning
  void recordInteraction(String notificationId, NotificationInteraction interaction) {
    final notification = _baseService.getAllNotifications()
        .firstWhere((n) => n['id'] == notificationId);
    
    _updateUserInteraction(notification, interaction);
    _updateInterestScores(notification, interaction);
  }

  void _initializeUserPreferences() {
    // Set sensible defaults to fight notification fatigue
    updateUserPreferences(
      enableSmartGrouping: true,
      digestFrequency: const Duration(hours: 4), // Max 6 notifications per day
      mutedTypes: {}, // Start with nothing muted
      enableQuietHours: true,
    );
  }

  void _initializeFrequencyLimits() {
    // Strict limits to prevent notification spam
    _frequencyLimits['deals'] = NotificationFrequency(
      maxPerHour: 2,
      maxPerDay: 8,
      cooldownMinutes: 15,
    );
    
    _frequencyLimits['community'] = NotificationFrequency(
      maxPerHour: 3,
      maxPerDay: 12,
      cooldownMinutes: 10,
    );
    
    _frequencyLimits['social'] = NotificationFrequency(
      maxPerHour: 1,
      maxPerDay: 4,
      cooldownMinutes: 30,
    );
    
    _frequencyLimits['cultural'] = NotificationFrequency(
      maxPerHour: 1,
      maxPerDay: 3,
      cooldownMinutes: 60,
    );
  }

  void _startSmartGrouping() {
    // Group notifications every 30 seconds
    _groupingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _updateGroups();
    });
  }

  void _startDigestScheduler() {
    // Send digest every 4 hours during active hours
    _digestTimer = Timer.periodic(const Duration(hours: 1), (timer) {
      final now = DateTime.now();
      if (now.hour % 4 == 0 && !_isQuietHours()) {
        _scheduleDigest();
      }
    });
  }

  void _updateGroups() {
    final notifications = _baseService.getAllNotifications();
    final newGroups = <String, NotificationGroup>{};
    
    for (final notification in notifications) {
      if (_shouldGroup(notification)) {
        final groupKey = _getGroupKey(notification);
        
        if (!newGroups.containsKey(groupKey)) {
          newGroups[groupKey] = NotificationGroup(
            id: groupKey,
            type: notification['type'] as String,
            title: _getGroupTitle(notification['type'] as String),
            notifications: [],
            priority: notification['priority'] as String,
            lastUpdated: notification['timestamp'] as DateTime,
            canDefer: _canDeferGroup(notification['type'] as String),
          );
        }
        
        newGroups[groupKey]!.notifications.add(notification);
        
        // Update group priority to highest
        final currentPriorityIndex = _getPriorityIndex(newGroups[groupKey]!.priority);
        final newPriorityIndex = _getPriorityIndex(notification['priority'] as String);
        if (newPriorityIndex > currentPriorityIndex) {
          newGroups[groupKey]!.priority = notification['priority'] as String;
        }
        
        // Update last updated time
        final notificationTime = notification['timestamp'] as DateTime;
        if (notificationTime.isAfter(newGroups[groupKey]!.lastUpdated)) {
          newGroups[groupKey]!.lastUpdated = notificationTime;
        }
      }
    }
    
    _groups.clear();
    _groups.addAll(newGroups);
  }

  double _calculateRelevanceScore(Map<String, dynamic> notification) {
    double score = 0.5; // Base score
    
    // User interest in notification type
    final interest = _userInterestScores[notification['type'] as String] ?? 0.5;
    score += interest * 0.3;
    
    // Recency bonus
    final age = DateTime.now().difference(notification['timestamp'] as DateTime);
    if (age.inMinutes < 30) {
      score += 0.2;
    } else if (age.inHours < 2) {
      score += 0.1;
    }
    
    // Priority boost
    switch (notification['priority'] as String?) {
      case 'urgent':
        score += 0.3;
        break;
      case 'high':
        score += 0.2;
        break;
      case 'medium':
        score += 0.1;
        break;
      case 'low':
        score -= 0.1;
        break;
    }
    
    // Cultural context (prayer times, etc.)
    if (_isCulturallyRelevant(notification)) {
      score += 0.15;
    }
    
    return score.clamp(0.0, 1.0);
  }

  bool _shouldGroup(Map<String, dynamic> notification) {
    // Group similar notifications together
    final groupableTypes = ['deals', 'community', 'social'];
    return groupableTypes.contains(notification['type'] as String);
  }

  bool _canDefer(Map<String, dynamic> notification) {
    return notification['priority'] != 'urgent' &&
           !_isCulturallyRelevant(notification);
  }

  bool _isOverFrequencyLimit(Map<String, dynamic> notification) {
    final limit = _frequencyLimits[notification['type'] as String];
    if (limit == null) return false;
    
    final now = DateTime.now();
    final lastTime = _lastNotificationTimes[notification['type'] as String];
    
    if (lastTime != null) {
      final timeSinceLastt = now.difference(lastTime);
      if (timeSinceLastt.inMinutes < limit.cooldownMinutes) {
        return true;
      }
    }
    
    return false;
  }

  void _addToGroup(Map<String, dynamic> notification) {
    final groupKey = _getGroupKey(notification);
    if (_groups.containsKey(groupKey)) {
      _groups[groupKey]!.notifications.add(notification);
    }
  }

  String _getGroupKey(Map<String, dynamic> notification) {
    return '${notification['type']}_group';
  }

  String _getGroupTitle(String type) {
    switch (type) {
      case 'deals':
        return 'Deal Updates';
      case 'community':
        return 'Community Activity';
      case 'social':
        return 'Social Updates';
      case 'cultural':
        return 'Cultural Events';
      default:
        return 'Updates';
    }
  }

  bool _canDeferGroup(String type) {
    return type != 'cultural'; // Cultural notifications are time-sensitive
  }

  NotificationSuggestedAction _getSuggestedAction(Map<String, dynamic> notification) {
    switch (notification['type'] as String?) {
      case 'deals':
        return NotificationSuggestedAction.viewDeal;
      case 'community':
        return NotificationSuggestedAction.openRoom;
      case 'booking':
        return NotificationSuggestedAction.viewBooking;
      default:
        return NotificationSuggestedAction.open;
    }
  }

  void _updateUserInteraction(Map<String, dynamic> notification, NotificationInteraction interaction) {
    _lastNotificationTimes[notification['type'] as String] = DateTime.now();
  }

  void _updateInterestScores(Map<String, dynamic> notification, NotificationInteraction interaction) {
    final currentScore = _userInterestScores[notification['type'] as String] ?? 0.5;
    double adjustment = 0.0;
    
    switch (interaction) {
      case NotificationInteraction.tapped:
        adjustment = 0.1;
        break;
      case NotificationInteraction.dismissed:
        adjustment = -0.05;
        break;
      case NotificationInteraction.snoozed:
        adjustment = 0.02;
        break;
      case NotificationInteraction.shown:
        adjustment = 0.01;
        break;
    }
    
    _userInterestScores[notification['type'] as String] = (currentScore + adjustment).clamp(0.0, 1.0);
  }

  bool _isCulturallyRelevant(Map<String, dynamic> notification) {
    return notification['type'] == 'cultural' || 
           notification['type'] == 'prayer' ||
           (notification['title'] as String).toLowerCase().contains('prayer') ||
           (notification['title'] as String).toLowerCase().contains('ramadan');
  }

  bool _isQuietHours() {
    final now = DateTime.now();
    final preferences = _userPreferences['current_user'];
    if (preferences == null || !preferences.enableQuietHours) return false;
    
    final currentTime = TimeOfDay.fromDateTime(now);
    final start = preferences.quietStart;
    final end = preferences.quietEnd;
    
    // Handle overnight quiet hours (e.g., 22:00 to 08:00)
    if (start.hour > end.hour) {
      return currentTime.hour >= start.hour || currentTime.hour < end.hour;
    }
    
    return currentTime.hour >= start.hour && currentTime.hour < end.hour;
  }

  void _scheduleDigest() {
    // Generate and potentially send digest
    final digest = generateDigest();
    if (digest.totalNotifications > 3) {
      // Only send digest if there are enough notifications to justify it
      _sendDigestNotification(digest);
    }
  }

  void _sendDigestNotification(NotificationDigest digest) {
    // This would integrate with actual push notification service
    // For now, we'll add it to the notification list as a special digest type
  }

  String _generateGroupSummary(String type, List<Map<String, dynamic>> notifications) {
    switch (type) {
      case 'deals':
        return '${notifications.length} new deals available';
      case 'community':
        return '${notifications.length} community updates';
      case 'social':
        return '${notifications.length} social activities';
      default:
        return '${notifications.length} updates';
    }
  }

  String _getHighestPriority(List<Map<String, dynamic>> notifications) {
    final priorities = notifications.map((n) => n['priority'] as String).toList();
    final priorityOrder = ['urgent', 'high', 'medium', 'low'];
    String highest = 'low';
    for (final priority in priorities) {
      if (priorityOrder.indexOf(priority) < priorityOrder.indexOf(highest)) {
        highest = priority;
      }
    }
    return highest;
  }

  int _calculateReduction(int original, int grouped) {
    if (original == 0) return 0;
    return ((original - grouped) / original * 100).round();
  }

  DateTime _getNextDigestTime() {
    final now = DateTime.now();
    final preferences = _userPreferences['current_user'];
    final frequency = preferences?.digestFrequency ?? const Duration(hours: 4);
    return now.add(frequency);
  }

  int _getPriorityIndex(String? priority) {
    switch (priority) {
      case 'urgent': return 3;
      case 'high': return 2;
      case 'medium': return 1;
      case 'low': return 0;
      default: return 0;
    }
  }

  void dispose() {
    _groupingTimer?.cancel();
    _digestTimer?.cancel();
  }
}

