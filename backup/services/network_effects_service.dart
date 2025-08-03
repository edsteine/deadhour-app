/// Service for tracking network effects and cross-problem user engagement
/// Monitors how users engage with both business optimization and social discovery features
class NetworkEffectsService {
  static final NetworkEffectsService _instance = NetworkEffectsService._internal();
  factory NetworkEffectsService() => _instance;
  NetworkEffectsService._internal();

  // Mock analytics data - in production would be integrated with analytics service
  final Map<String, Map<String, dynamic>> _userEngagementMetrics = {
    'user_ahmed': {
      'userType': 'dual_engaged', // local + business owner
      'businessInteractions': 45, // deal posts, venue management
      'socialInteractions': 78, // community participation, check-ins
      'crossProblemConversions': 3, // found venues through community -> became business customer
      'networkContributions': 12, // helped others discover venues/deals
      'lastActivity': DateTime.now().subtract(const Duration(hours: 2)),
      'engagementScore': 85.5,
    },
    'user_sarah': {
      'userType': 'tourism_to_local', // tourist who became locally engaged
      'businessInteractions': 23,
      'socialInteractions': 56,
      'crossProblemConversions': 2,
      'networkContributions': 8,
      'lastActivity': DateTime.now().subtract(const Duration(hours: 1)),
      'engagementScore': 72.3,
    },
    'user_youssef': {
      'userType': 'community_focused', // primarily social discovery
      'businessInteractions': 12,
      'socialInteractions': 89,
      'crossProblemConversions': 1,
      'networkContributions': 15,
      'lastActivity': DateTime.now().subtract(const Duration(minutes: 30)),
      'engagementScore': 68.7,
    },
  };

  final Map<String, Map<String, dynamic>> _networkMetrics = {
    'overall': {
      'totalUsers': 1547,
      'dualEngagedUsers': 234, // users engaging with both problems
      'averageEngagementScore': 73.2,
      'crossProblemConversionRate': 0.34, // 34% conversion rate
      'networkGrowthRate': 0.23, // 23% monthly growth
      'communityToBusinessFlow': 156, // community members who became business customers
      'businessToCommunityFlow': 89, // business owners who joined community discussions
    },
    'community_discovery': {
      'totalCommunityMembers': 1201,
      'activeDiscussions': 45,
      'venueRecommendations': 234,
      'dealSharing': 178,
      'friendConnections': 567,
      'communityGrowthRate': 0.28,
    },
    'business_optimization': {
      'totalBusinesses': 346,
      'activeDeals': 123,
      'deadHourBookings': 789,
      'revenueOptimized': 45600.0, // MAD
      'averageBookingIncrease': 0.42, // 42% increase in dead hour bookings
      'businessSatisfaction': 4.3,
    },
  };

  final List<Map<String, dynamic>> _crossProblemJourney = [
    {
      'userId': 'user_tourist_1',
      'journey': 'tourism_to_local',
      'stages': [
        {
          'stage': 'discovery',
          'timestamp': DateTime.now().subtract(const Duration(days: 30)),
          'action': 'Found venue through community room',
          'venue': 'Café Central',
        },
        {
          'stage': 'engagement',
          'timestamp': DateTime.now().subtract(const Duration(days: 25)),
          'action': 'Booked deal during dead hours',
          'savings': 45.0,
        },
        {
          'stage': 'community_integration',
          'timestamp': DateTime.now().subtract(const Duration(days: 20)),
          'action': 'Posted venue review and photos',
          'impact': 'Influenced 3 other bookings',
        },
        {
          'stage': 'local_advocacy',
          'timestamp': DateTime.now().subtract(const Duration(days: 10)),
          'action': 'Recommended venue to other tourists',
          'networkEffect': 'Generated 8 new community discussions',
        },
      ],
    },
  ];

  /// Get overall network effects summary
  Map<String, dynamic> getNetworkEffectsSummary() {
    final overall = _networkMetrics['overall']!;
    final community = _networkMetrics['community_discovery']!;
    final business = _networkMetrics['business_optimization']!;
    
    return {
      'totalUsers': overall['totalUsers'],
      'dualEngagementRate': (overall['dualEngagedUsers'] / overall['totalUsers']).toStringAsFixed(2),
      'crossProblemConversionRate': overall['crossProblemConversionRate'],
      'networkGrowthRate': overall['networkGrowthRate'],
      'averageEngagementScore': overall['averageEngagementScore'],
      'communityToBusinessFlow': overall['communityToBusinessFlow'],
      'businessToCommunityFlow': overall['businessToCommunityFlow'],
      'revenueOptimized': business['revenueOptimized'],
      'deadHourBookings': business['deadHourBookings'],
      'communityRecommendations': community['venueRecommendations'],
    };
  }

  /// Get user engagement metrics
  Map<String, dynamic> getUserEngagementMetrics(String userId) {
    return _userEngagementMetrics[userId] ?? _getDefaultUserMetrics();
  }

  /// Track cross-problem interaction
  void trackCrossProblemInteraction(String userId, String fromProblem, String toProblem, String action) {
    if (!_userEngagementMetrics.containsKey(userId)) {
      _userEngagementMetrics[userId] = _getDefaultUserMetrics();
    }
    
    final userMetrics = _userEngagementMetrics[userId]!;
    
    // Update conversion counter
    userMetrics['crossProblemConversions'] = (userMetrics['crossProblemConversions'] ?? 0) + 1;
    
    // Update interaction counters
    if (toProblem == 'business') {
      userMetrics['businessInteractions'] = (userMetrics['businessInteractions'] ?? 0) + 1;
    } else if (toProblem == 'social') {
      userMetrics['socialInteractions'] = (userMetrics['socialInteractions'] ?? 0) + 1;
    }
    
    // Update engagement score
    _updateEngagementScore(userId);
    
    // Update overall network metrics
    _updateNetworkMetrics(fromProblem, toProblem);
  }

  /// Get dual-problem engagement analysis
  Map<String, dynamic> getDualProblemAnalysis() {
    final dualUsers = _userEngagementMetrics.values.where(
      (user) => user['userType'] == 'dual_engaged'
    ).toList();
    
    final communityToBusinessUsers = _userEngagementMetrics.values.where(
      (user) => user['crossProblemConversions'] > 0
    ).toList();
    
    return {
      'dualEngagedCount': dualUsers.length,
      'averageDualEngagementScore': dualUsers.isEmpty 
          ? 0.0 
          : dualUsers.map((u) => u['engagementScore']).reduce((a, b) => a + b) / dualUsers.length,
      'crossProblemConversions': communityToBusinessUsers.length,
      'averageConversionsPerUser': communityToBusinessUsers.isEmpty
          ? 0.0
          : communityToBusinessUsers.map((u) => u['crossProblemConversions']).reduce((a, b) => a + b) / communityToBusinessUsers.length,
      'networkContributions': _userEngagementMetrics.values.map((u) => u['networkContributions'] ?? 0).reduce((a, b) => a + b),
    };
  }

  /// Get tourism to local conversion metrics
  Map<String, dynamic> getTourismToLocalMetrics() {
    final tourismUsers = _userEngagementMetrics.values.where(
      (user) => user['userType'] == 'tourism_to_local'
    ).toList();
    
    return {
      'conversionCount': tourismUsers.length,
      'averageEngagement': tourismUsers.isEmpty 
          ? 0.0 
          : tourismUsers.map((u) => u['engagementScore']).reduce((a, b) => a + b) / tourismUsers.length,
      'averageNetworkContributions': tourismUsers.isEmpty 
          ? 0.0 
          : tourismUsers.map((u) => u['networkContributions']).reduce((a, b) => a + b) / tourismUsers.length,
      'localIntegrationRate': tourismUsers.where((u) => u['socialInteractions'] > 30).length / (tourismUsers.isEmpty ? 1 : tourismUsers.length),
    };
  }

  /// Get network effects performance indicators
  List<Map<String, dynamic>> getNetworkEffectsKPIs() {
    final summary = getNetworkEffectsSummary();
    final dualAnalysis = getDualProblemAnalysis();
    final tourismMetrics = getTourismToLocalMetrics();
    
    return [
      {
        'name': 'Dual Problem Engagement',
        'value': '${summary['dualEngagementRate']}%',
        'trend': 'increasing',
        'impact': 'high',
        'description': 'Users engaging with both business and social features (${dualAnalysis['businessToSocial']}% conversion)',
      },
      {
        'name': 'Cross-Problem Conversion',
        'value': '${(summary['crossProblemConversionRate'] * 100).toStringAsFixed(1)}%',
        'trend': 'increasing',
        'impact': 'high',
        'description': 'Community members who became business customers (${dualAnalysis['socialToBusiness']}% pathway)',
      },
      {
        'name': 'Network Growth Rate',
        'value': '${(summary['networkGrowthRate'] * 100).toStringAsFixed(1)}%',
        'trend': 'increasing',
        'impact': 'medium',
        'description': 'Monthly growth in active network participants',
      },
      {
        'name': 'Tourism Integration',
        'value': '${(tourismMetrics['localIntegrationRate'] * 100).toStringAsFixed(1)}%',
        'trend': 'stable',
        'impact': 'medium',
        'description': 'Tourists who became locally engaged community members',
      },
      {
        'name': 'Revenue Optimization',
        'value': '${(summary['revenueOptimized'] / 1000).toStringAsFixed(1)}k MAD',
        'trend': 'increasing',
        'impact': 'high',
        'description': 'Revenue generated through dead hour optimization',
      },
    ];
  }

  /// Get cross-problem user journey analysis
  List<Map<String, dynamic>> getCrossProblemJourneys() {
    return List.from(_crossProblemJourney);
  }

  /// Track venue discovery source (community vs direct)
  void trackVenueDiscoverySource(String userId, String venueId, String source) {
    if (source == 'community') {
      trackCrossProblemInteraction(userId, 'social', 'business', 'venue_discovery');
    }
  }

  /// Track deal booking from community recommendation
  void trackCommunityDealBooking(String userId, String dealId, String communitySource) {
    trackCrossProblemInteraction(userId, 'social', 'business', 'deal_booking');
    
    // Update network contribution for the recommender
    if (_userEngagementMetrics.containsKey(communitySource)) {
      _userEngagementMetrics[communitySource]!['networkContributions'] = 
          (_userEngagementMetrics[communitySource]!['networkContributions'] ?? 0) + 1;
    }
  }

  /// Get real-time network activity
  Map<String, dynamic> getRealtimeNetworkActivity() {
    final recentActivity = _userEngagementMetrics.values.where(
      (user) => DateTime.now().difference(user['lastActivity']).inHours < 24
    ).toList();
    
    return {
      'activeUsersLast24h': recentActivity.length,
      'averageEngagementScore': recentActivity.isEmpty 
          ? 0.0 
          : recentActivity.map((u) => u['engagementScore']).reduce((a, b) => a + b) / recentActivity.length,
      'crossProblemInteractionsToday': recentActivity.where(
        (u) => u['crossProblemConversions'] > 0
      ).length,
      'networkMomentum': _calculateNetworkMomentum(),
    };
  }

  Map<String, dynamic> _getDefaultUserMetrics() {
    return {
      'userType': 'new_user',
      'businessInteractions': 0,
      'socialInteractions': 0,
      'crossProblemConversions': 0,
      'networkContributions': 0,
      'lastActivity': DateTime.now(),
      'engagementScore': 0.0,
    };
  }

  void _updateEngagementScore(String userId) {
    final userMetrics = _userEngagementMetrics[userId]!;
    
    // Calculate engagement score based on various factors
    double score = 0.0;
    
    // Base interaction scores
    score += (userMetrics['businessInteractions'] ?? 0) * 1.2;
    score += (userMetrics['socialInteractions'] ?? 0) * 1.0;
    
    // Cross-problem conversion bonus
    score += (userMetrics['crossProblemConversions'] ?? 0) * 5.0;
    
    // Network contribution bonus
    score += (userMetrics['networkContributions'] ?? 0) * 3.0;
    
    // Recency bonus
    final daysSinceLastActivity = DateTime.now().difference(userMetrics['lastActivity']).inDays;
    if (daysSinceLastActivity < 7) {
      score *= 1.1; // 10% bonus for recent activity
    }
    
    userMetrics['engagementScore'] = score.clamp(0.0, 100.0);
  }

  void _updateNetworkMetrics(String fromProblem, String toProblem) {
    final overall = _networkMetrics['overall']!;
    
    if (fromProblem == 'social' && toProblem == 'business') {
      overall['communityToBusinessFlow'] = (overall['communityToBusinessFlow'] ?? 0) + 1;
    } else if (fromProblem == 'business' && toProblem == 'social') {
      overall['businessToCommunityFlow'] = (overall['businessToCommunityFlow'] ?? 0) + 1;
    }
  }

  double _calculateNetworkMomentum() {
    // Simple momentum calculation based on recent activity and growth
    final recentGrowth = _networkMetrics['overall']!['networkGrowthRate'];
    final averageEngagement = _networkMetrics['overall']!['averageEngagementScore'];
    final conversionRate = _networkMetrics['overall']!['crossProblemConversionRate'];
    
    return ((recentGrowth * 100) + (averageEngagement * 0.5) + (conversionRate * 100)) / 3;
  }
}