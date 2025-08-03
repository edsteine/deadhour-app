
/// Analytics data management and helper methods
class AnalyticsData {
  // Event storage
  final List<Map<String, dynamic>> eventQueue = [];
  final Map<String, dynamic> userProperties = {};
  final Map<String, int> eventCounts = {};
  final Map<String, List<Duration>> timingEvents = {};

  // Analytics configuration
  final Map<String, dynamic> config = {
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
  final Map<String, dynamic> moroccoMetrics = {
    'prayer_time_interactions': 0,
    'halal_filter_usage': 0,
    'arabic_content_views': 0,
    'cultural_events_engagement': 0,
    'ramadan_special_bookings': 0,
  };

  // Dual-problem tracking
  final Map<String, dynamic> dualProblemMetrics = {
    'business_to_consumer_conversion': 0,
    'community_to_booking_conversion': 0,
    'tourism_to_local_engagement': 0,
    'cross_role_interactions': 0,
  };

  // Helper methods
  String getInteractionType(String action) {
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

  bool isDeadHour(String? targetHour) {
    if (targetHour == null) return false;
    
    // Simple dead hour detection - would be more sophisticated in production
    const deadHours = ['14:00', '15:00', '16:00', '21:00', '22:00'];
    return deadHours.contains(targetHour);
  }

  String calculateEngagementLevel(int? participantCount) {
    if (participantCount == null) return 'unknown';
    
    if (participantCount < 5) return 'low';
    if (participantCount < 15) return 'medium';
    return 'high';
  }

  double calculatePlatformEffectiveness() {
    final totalConversions = dualProblemMetrics.values
        .whereType<int>()
        .fold<int>(0, (sum, value) => sum + value);
    
    // Simple effectiveness calculation - would be more sophisticated in production
    return totalConversions > 0 ? (totalConversions / 100.0).clamp(0.0, 1.0) : 0.0;
  }

  int getFunnelStepOrder(String funnelName, String step) {
    // Simple funnel step ordering - would be configurable in production
    const funnelSteps = {
      'booking': ['search', 'venue_view', 'deal_view', 'booking_form', 'payment', 'confirmation'],
      'registration': ['landing', 'role_selection', 'form_fill', 'verification', 'complete'],
    };
    
    final steps = funnelSteps[funnelName] ?? [];
    return steps.indexOf(step) + 1;
  }

  String getSearchType(String query) {
    if (query.contains(RegExp(r'\d'))) return 'mixed';
    if (query.length < 3) return 'short';
    if (query.contains(' ')) return 'phrase';
    return 'keyword';
  }

  Map<String, dynamic> getTimingsSummary() {
    final summary = <String, dynamic>{};
    
    for (final entry in timingEvents.entries) {
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

  void addEvent(Map<String, dynamic> event) {
    eventQueue.add(event);
    
    // Prevent memory issues
    if (eventQueue.length > config['max_events_in_memory']) {
      eventQueue.removeAt(0);
    }
  }

  void incrementEventCount(String eventName) {
    eventCounts[eventName] = (eventCounts[eventName] ?? 0) + 1;
  }

  String generateSessionId() {
    return 'session_${DateTime.now().millisecondsSinceEpoch}';
  }
}