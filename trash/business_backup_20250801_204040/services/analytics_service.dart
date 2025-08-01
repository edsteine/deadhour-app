import 'dart:async';

import 'package:flutter/foundation.dart';


/// Analytics service for DeadHour app
/// Handles user behavior tracking, performance monitoring, and usage analytics
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  bool _isInitialized = false;
  bool _analyticsEnabled = true;
  String? _userId;
  String? _sessionId;
  DateTime? _sessionStartTime;

  // Event storage
  final List<Map<String, dynamic>> _eventQueue = [];
  final Map<String, dynamic> _userProperties = {};
  final Map<String, int> _eventCounts = {};
  final Map<String, List<Duration>> _timingEvents = {};

  // Analytics configuration
  final Map<String, dynamic> _config = {
    'batch_size': 50,
    'flush_interval_seconds': 30,
    'max_events_in_memory': 1000,
    'track_screen_views': true,
    'track_user_interactions': true,
    'track_performance_metrics': true,
    'track_crashes': false, // Simplified for this implementation
    'anonymize_ip': true,
    'respect_do_not_track': true,
  };

  // Morocco-specific analytics
  final Map<String, dynamic> _moroccoMetrics = {
    'prayer_time_interactions': 0,
    'halal_filter_usage': 0,
    'arabic_content_views': 0,
    'cultural_events_engagement': 0,
    'ramadan_special_bookings': 0,
  };

  // Dual-problem tracking
  final Map<String, dynamic> _dualProblemMetrics = {
    'business_to_consumer_conversion': 0,
    'community_to_booking_conversion': 0,
    'tourism_to_local_engagement': 0,
    'cross_role_interactions': 0,
  };

  Timer? _flushTimer;

  /// Initialize analytics service
  Future<void> initialize({
    required String userId,
    Map<String, dynamic>? initialProperties,
  }) async {
    if (_isInitialized) return;

    _userId = userId;
    _sessionId = _generateSessionId();
    _sessionStartTime = DateTime.now();

    if (initialProperties != null) {
      _userProperties.addAll(initialProperties);
    }

    _setupEventFlushing();
    _trackSessionStart();

    _isInitialized = true;

    if (kDebugMode) {
      print('AnalyticsService initialized for user: $userId');
    }
  }

  /// Track custom events
  void trackEvent(String eventName, {Map<String, dynamic>? properties}) {
    if (!_analyticsEnabled || !_isInitialized) return;

    final event = {
      'event_name': eventName,
      'timestamp': DateTime.now().toIso8601String(),
      'user_id': _userId,
      'session_id': _sessionId,
      'properties': {
        ...?properties,
        'platform': 'flutter',
        'app_version': '1.0.0', // Would be dynamic in production
      },
    };

    _addEvent(event);
    _incrementEventCount(eventName);

    if (kDebugMode) {
      print('Event tracked: $eventName');
    }
  }

  /// Track screen views
  void trackScreenView(String screenName, {Map<String, dynamic>? properties}) {
    if (!_config['track_screen_views'] || !_analyticsEnabled) return;

    trackEvent('screen_view', properties: {
      'screen_name': screenName,
      'screen_class': screenName.replaceAll('_', ''),
      ...?properties,
    });
  }

  /// Track user interactions
  void trackUserInteraction(String action, String target, {Map<String, dynamic>? properties}) {
    if (!_config['track_user_interactions'] || !_analyticsEnabled) return;

    trackEvent('user_interaction', properties: {
      'action': action,
      'target': target,
      'interaction_type': _getInteractionType(action),
      ...?properties,
    });
  }

  /// Track timing events (e.g., screen load times, API response times)
  void trackTiming(String category, String variable, Duration duration, {String? label}) {
    if (!_config['track_performance_metrics'] || !_analyticsEnabled) return;

    final timingKey = '${category}_$variable';
    _timingEvents.putIfAbsent(timingKey, () => []).add(duration);

    trackEvent('timing', properties: {
      'timing_category': category,
      'timing_variable': variable,
      'timing_value_ms': duration.inMilliseconds,
      'timing_label': label,
    });
  }

  /// Track business-specific events
  void trackBusinessEvent(String eventType, {
    String? venueId,
    String? dealId,
    double? revenueAmount,
    String? targetHour,
    Map<String, dynamic>? properties,
  }) {
    trackEvent('business_event', properties: {
      'event_type': eventType,
      'venue_id': venueId,
      'deal_id': dealId,
      'revenue_amount': revenueAmount,
      'target_hour': targetHour,
      'is_dead_hour': _isDeadHour(targetHour),
      ...?properties,
    });
  }

  /// Track community events
  void trackCommunityEvent(String eventType, {
    String? roomId,
    String? messageId,
    int? participantCount,
    Map<String, dynamic>? properties,
  }) {
    trackEvent('community_event', properties: {
      'event_type': eventType,
      'room_id': roomId,
      'message_id': messageId,
      'participant_count': participantCount,
      'community_engagement_level': _calculateEngagementLevel(participantCount),
      ...?properties,
    });
  }

  /// Track Morocco-specific cultural interactions
  void trackCulturalInteraction(String interactionType, {Map<String, dynamic>? properties}) {
    switch (interactionType) {
      case 'prayer_time_view':
        _moroccoMetrics['prayer_time_interactions'] = 
            (_moroccoMetrics['prayer_time_interactions'] as int) + 1;
        break;
      case 'halal_filter_applied':
        _moroccoMetrics['halal_filter_usage'] = 
            (_moroccoMetrics['halal_filter_usage'] as int) + 1;
        break;
      case 'arabic_content_viewed':
        _moroccoMetrics['arabic_content_views'] = 
            (_moroccoMetrics['arabic_content_views'] as int) + 1;
        break;
      case 'cultural_event_engaged':
        _moroccoMetrics['cultural_events_engagement'] = 
            (_moroccoMetrics['cultural_events_engagement'] as int) + 1;
        break;
      case 'ramadan_booking':
        _moroccoMetrics['ramadan_special_bookings'] = 
            (_moroccoMetrics['ramadan_special_bookings'] as int) + 1;
        break;
    }

    trackEvent('cultural_interaction', properties: {
      'interaction_type': interactionType,
      'cultural_context': 'morocco',
      ...?properties,
    });
  }

  /// Track dual-problem platform metrics
  void trackDualProblemMetric(String metricType, {Map<String, dynamic>? properties}) {
    switch (metricType) {
      case 'business_to_consumer':
        _dualProblemMetrics['business_to_consumer_conversion'] = 
            (_dualProblemMetrics['business_to_consumer_conversion'] as int) + 1;
        break;
      case 'community_to_booking':
        _dualProblemMetrics['community_to_booking_conversion'] = 
            (_dualProblemMetrics['community_to_booking_conversion'] as int) + 1;
        break;
      case 'tourism_to_local':
        _dualProblemMetrics['tourism_to_local_engagement'] = 
            (_dualProblemMetrics['tourism_to_local_engagement'] as int) + 1;
        break;
      case 'cross_role_interaction':
        _dualProblemMetrics['cross_role_interactions'] = 
            (_dualProblemMetrics['cross_role_interactions'] as int) + 1;
        break;
    }

    trackEvent('dual_problem_metric', properties: {
      'metric_type': metricType,
      'platform_effectiveness': _calculatePlatformEffectiveness(),
      ...?properties,
    });
  }

  /// Track multi-role account system usage
  void trackRoleUsage(String action, {
    List<String>? activeRoles,
    String? primaryRole,
    String? switchedFromRole,
    String? switchedToRole,
    Map<String, dynamic>? properties,
  }) {
    trackEvent('role_usage', properties: {
      'action': action,
      'active_roles': activeRoles,
      'primary_role': primaryRole,
      'switched_from_role': switchedFromRole,
      'switched_to_role': switchedToRole,
      'role_count': activeRoles?.length ?? 0,
      'is_multi_role_user': (activeRoles?.length ?? 0) > 1,
      ...?properties,
    });
  }

  /// Set user properties
  void setUserProperties(Map<String, dynamic> properties) {
    if (!_analyticsEnabled) return;

    _userProperties.addAll(properties);
    
    trackEvent('user_properties_updated', properties: {
      'updated_properties': properties.keys.toList(),
    });
  }

  /// Track conversion funnel
  void trackConversionFunnel(String funnelName, String step, {
    String? previousStep,
    Map<String, dynamic>? properties,
  }) {
    trackEvent('conversion_funnel', properties: {
      'funnel_name': funnelName,
      'step': step,
      'previous_step': previousStep,
      'step_order': _getFunnelStepOrder(funnelName, step),
      ...?properties,
    });
  }

  /// Track search behavior
  void trackSearch(String query, {
    int? resultCount,
    String? category,
    String? location,
    bool? hasFilters,
    Map<String, dynamic>? properties,
  }) {
    trackEvent('search', properties: {
      'query': query,
      'query_length': query.length,
      'result_count': resultCount,
      'category': category,
      'location': location,
      'has_filters': hasFilters ?? false,
      'search_type': _getSearchType(query),
      ...?properties,
    });
  }

  /// Track booking behavior
  void trackBooking(String bookingId, {
    String? venueId,
    String? dealId,
    double? amount,
    int? partySize,
    DateTime? bookingTime,
    String? bookingSource,
    Map<String, dynamic>? properties,
  }) {
    trackEvent('booking', properties: {
      'booking_id': bookingId,
      'venue_id': venueId,
      'deal_id': dealId,
      'amount': amount,
      'party_size': partySize,
      'booking_time': bookingTime?.toIso8601String(),
      'booking_source': bookingSource,
      'is_group_booking': (partySize ?? 1) > 1,
      'booking_advance_hours': bookingTime != null 
          ? DateTime.now().difference(bookingTime).inHours.abs()
          : null,
      ...?properties,
    });
  }

  /// Get analytics summary
  Map<String, dynamic> getAnalyticsSummary() {
    return {
      'session_info': {
        'user_id': _userId,
        'session_id': _sessionId,
        'session_duration_minutes': _sessionStartTime != null
            ? DateTime.now().difference(_sessionStartTime!).inMinutes
            : 0,
      },
      'event_counts': Map.from(_eventCounts),
      'morocco_metrics': Map.from(_moroccoMetrics),
      'dual_problem_metrics': Map.from(_dualProblemMetrics),
      'performance_timings': _getTimingsSummary(),
      'user_properties': Map.from(_userProperties),
      'events_queued': _eventQueue.length,
    };
  }

  /// Enable/disable analytics
  void setAnalyticsEnabled(bool enabled) {
    _analyticsEnabled = enabled;
    
    if (!enabled) {
      _eventQueue.clear();
    }
    
    if (kDebugMode) {
      print('Analytics ${enabled ? 'enabled' : 'disabled'}');
    }
  }

  /// Flush events immediately
  Future<void> flush() async {
    if (_eventQueue.isEmpty) return;

    try {
      await _flushEvents();
      if (kDebugMode) {
        print('Analytics events flushed');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to flush analytics events: $e');
      }
    }
  }

  /// Clean up resources
  void dispose() {
    _flushTimer?.cancel();
    flush(); // Final flush before disposal
  }

  // Private helper methods

  void _addEvent(Map<String, dynamic> event) {
    _eventQueue.add(event);
    
    // Prevent memory issues
    if (_eventQueue.length > _config['max_events_in_memory']) {
      _eventQueue.removeAt(0);
    }
    
    // Auto-flush if batch size reached
    if (_eventQueue.length >= _config['batch_size']) {
      _flushEvents();
    }
  }

  void _incrementEventCount(String eventName) {
    _eventCounts[eventName] = (_eventCounts[eventName] ?? 0) + 1;
  }

  void _setupEventFlushing() {
    _flushTimer = Timer.periodic(
      Duration(seconds: _config['flush_interval_seconds']),
      (timer) => _flushEvents(),
    );
  }

  Future<void> _flushEvents() async {
    if (_eventQueue.isEmpty) return;

    try {
      // In production, this would send events to analytics server
      final eventsToFlush = List<Map<String, dynamic>>.from(_eventQueue);
      _eventQueue.clear();

      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 200));

      if (kDebugMode) {
        print('Flushed ${eventsToFlush.length} analytics events');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to flush events: $e');
      }
    }
  }

  void _trackSessionStart() {
    trackEvent('session_start', properties: {
      'session_id': _sessionId,
      'platform': 'flutter',
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  String _generateSessionId() {
    return 'session_${DateTime.now().millisecondsSinceEpoch}';
  }

  String _getInteractionType(String action) {
    const interactionTypes = {
      'tap': 'touch',
      'click': 'touch',
      'swipe': 'gesture',
      'scroll': 'gesture',
      'long_press': 'touch',
      'double_tap': 'touch',
    };
    return interactionTypes[action] ?? 'unknown';
  }

  bool _isDeadHour(String? targetHour) {
    if (targetHour == null) return false;
    
    // Simple dead hour detection - would be more sophisticated in production
    const deadHours = ['14:00', '15:00', '16:00', '21:00', '22:00'];
    return deadHours.contains(targetHour);
  }

  String _calculateEngagementLevel(int? participantCount) {
    if (participantCount == null) return 'unknown';
    
    if (participantCount < 5) return 'low';
    if (participantCount < 15) return 'medium';
    return 'high';
  }

  double _calculatePlatformEffectiveness() {
    final totalConversions = _dualProblemMetrics.values
        .whereType<int>()
        .fold<int>(0, (sum, value) => sum + value);
    
    // Simple effectiveness calculation - would be more sophisticated in production
    return totalConversions > 0 ? (totalConversions / 100.0).clamp(0.0, 1.0) : 0.0;
  }

  int _getFunnelStepOrder(String funnelName, String step) {
    // Simple funnel step ordering - would be configurable in production
    const funnelSteps = {
      'booking': ['search', 'venue_view', 'deal_view', 'booking_form', 'payment', 'confirmation'],
      'registration': ['landing', 'role_selection', 'form_fill', 'verification', 'complete'],
    };
    
    final steps = funnelSteps[funnelName] ?? [];
    return steps.indexOf(step) + 1;
  }

  String _getSearchType(String query) {
    if (query.contains(RegExp(r'\d'))) return 'mixed';
    if (query.length < 3) return 'short';
    if (query.contains(' ')) return 'phrase';
    return 'keyword';
  }

  Map<String, dynamic> _getTimingsSummary() {
    final summary = <String, dynamic>{};
    
    for (final entry in _timingEvents.entries) {
      final timings = entry.value;
      if (timings.isNotEmpty) {
        final avgMs = timings.map((d) => d.inMilliseconds).reduce((a, b) => a + b) / timings.length;
        final minMs = timings.map((d) => d.inMilliseconds).reduce((a, b) => a < b ? a : b);
        final maxMs = timings.map((d) => d.inMilliseconds).reduce((a, b) => a > b ? a : b);
        
        summary[entry.key] = {
          'average_ms': avgMs.round(),
          'min_ms': minMs,
          'max_ms': maxMs,
          'count': timings.length,
        };
      }
    }
    
    return summary;
  }
}

