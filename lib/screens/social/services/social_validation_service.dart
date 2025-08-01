/// Service for managing social validation features
/// Handles community check-ins, social proof, and friend recommendations
class SocialValidationService {
  static final SocialValidationService _instance = SocialValidationService._internal();
  factory SocialValidationService() => _instance;
  SocialValidationService._internal();

  // Mock data for social validation
  final Map<String, List<Map<String, dynamic>>> _venueCheckIns = {
    'venue_1': [
      {
        'userId': 'user_ahmed',
        'username': 'Ahmed_Casa',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'rating': 4.5,
        'comment': 'Great atmosphere for studying!',
        'isFriend': false,
      },
      {
        'userId': 'user_sarah',
        'username': 'Sarah_Guide',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
        'rating': 5.0,
        'comment': 'Perfect for coffee meetings',
        'isFriend': true,
      },
    ],
    'venue_2': [
      {
        'userId': 'user_youssef',
        'username': 'LocalFoodie',
        'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
        'rating': 4.0,
        'comment': 'Authentic Moroccan food',
        'isFriend': false,
      },
    ],
  };

  final Map<String, Map<String, dynamic>> _communityStats = {
    'venue_1': {
      'totalVisits': 145,
      'weeklyVisits': 23,
      'friendVisits': 8,
      'averageRating': 4.3,
      'popularTimes': ['14:00-16:00', '20:00-22:00'],
      'communityTags': ['Study Friendly', 'WiFi Strong', 'Quiet'],
    },
    'venue_2': {
      'totalVisits': 89,
      'weeklyVisits': 15,
      'friendVisits': 3,
      'averageRating': 4.1,
      'popularTimes': ['12:00-14:00', '19:00-21:00'],
      'communityTags': ['Authentic', 'Family Friendly', 'Halal'],
    },
  };

  final List<Map<String, dynamic>> _friendRecommendations = [
    {
      'friendId': 'user_sarah',
      'friendName': 'Sarah_Guide',
      'venueId': 'venue_1',
      'venueName': 'Café Central',
      'recommendation': 'Amazing coffee and perfect for work calls!',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'rating': 5.0,
    },
    {
      'friendId': 'user_ahmed',
      'friendName': 'Ahmed_Casa',
      'venueId': 'venue_3',
      'venueName': 'Riad Restaurant',
      'recommendation': 'Best tagine in the medina, authentic experience',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      'rating': 4.5,
    },
  ];

  /// Get recent check-ins for a venue
  List<Map<String, dynamic>> getVenueCheckIns(String venueId) {
    return _venueCheckIns[venueId] ?? [];
  }

  /// Get community stats for a venue
  Map<String, dynamic> getCommunityStats(String venueId) {
    return _communityStats[venueId] ?? {};
  }

  /// Get friend recommendations
  List<Map<String, dynamic>> getFriendRecommendations() {
    return List.from(_friendRecommendations);
  }

  /// Get social proof summary for deal discovery
  Map<String, dynamic> getSocialProofSummary(String venueId) {
    final checkIns = getVenueCheckIns(venueId);
    final stats = getCommunityStats(venueId);
    
    final friendCheckIns = checkIns.where((checkIn) => checkIn['isFriend'] == true).toList();
    final recentCheckIns = checkIns.where(
      (checkIn) => DateTime.now().difference(checkIn['timestamp']).inHours < 24
    ).toList();

    return {
      'totalCheckIns': checkIns.length,
      'friendCheckIns': friendCheckIns.length,
      'recentCheckIns': recentCheckIns.length,
      'averageRating': stats['averageRating'] ?? 0.0,
      'communityTags': stats['communityTags'] ?? [],
      'popularTimes': stats['popularTimes'] ?? [],
      'friendNames': friendCheckIns.map((checkIn) => checkIn['username']).toList(),
      'lastFriendVisit': friendCheckIns.isNotEmpty 
          ? friendCheckIns.first['timestamp'] 
          : null,
    };
  }

  /// Check if venue is recommended by friends
  bool isVenueRecommendedByFriends(String venueId) {
    return _friendRecommendations.any((rec) => rec['venueId'] == venueId);
  }

  /// Get friend recommendation for venue
  Map<String, dynamic>? getFriendRecommendation(String venueId) {
    try {
      return _friendRecommendations.firstWhere((rec) => rec['venueId'] == venueId);
    } catch (e) {
      return null;
    }
  }

  /// Add a check-in (mock implementation)
  void addCheckIn(String venueId, String userId, String username, double rating, String comment) {
    if (!_venueCheckIns.containsKey(venueId)) {
      _venueCheckIns[venueId] = [];
    }
    
    _venueCheckIns[venueId]!.insert(0, {
      'userId': userId,
      'username': username,
      'timestamp': DateTime.now(),
      'rating': rating,
      'comment': comment,
      'isFriend': _isUserFriend(userId),
    });
    
    // Update stats
    _updateCommunityStats(venueId, rating);
  }

  /// Check if user is a friend
  bool _isUserFriend(String userId) {
    // Mock implementation - in real app would check friendship status
    return userId == 'user_sarah' || userId == 'user_ahmed';
  }

  /// Update community stats after check-in
  void _updateCommunityStats(String venueId, double rating) {
    if (!_communityStats.containsKey(venueId)) {
      _communityStats[venueId] = {
        'totalVisits': 0,
        'weeklyVisits': 0,
        'friendVisits': 0,
        'averageRating': 0.0,
        'popularTimes': [],
        'communityTags': [],
      };
    }
    
    final stats = _communityStats[venueId]!;
    stats['totalVisits'] = (stats['totalVisits'] ?? 0) + 1;
    stats['weeklyVisits'] = (stats['weeklyVisits'] ?? 0) + 1;
    
    // Update average rating
    final currentRating = stats['averageRating'] ?? 0.0;
    final totalVisits = stats['totalVisits'];
    stats['averageRating'] = ((currentRating * (totalVisits - 1)) + rating) / totalVisits;
  }

  /// Get community validation for booking
  Map<String, dynamic> getBookingValidation(String venueId, String selectedTime) {
    final stats = getCommunityStats(venueId);
    final popularTimes = stats['popularTimes'] ?? [];
    final communityTags = stats['communityTags'] ?? [];
    
    bool isPopularTime = popularTimes.any((timeSlot) {
      // Simple check if selected time falls within popular time slot
      return timeSlot.contains(selectedTime.split(':')[0]);
    });
    
    return {
      'isPopularTime': isPopularTime,
      'communityTags': communityTags,
      'averageRating': stats['averageRating'] ?? 0.0,
      'weeklyVisits': stats['weeklyVisits'] ?? 0,
      'validationMessage': isPopularTime 
          ? 'Popular time - community approved!'
          : 'Off-peak time - perfect for quiet experience',
    };
  }

  /// Get social proof widgets data
  List<Map<String, dynamic>> getSocialProofWidgets(String venueId) {
    final socialProof = getSocialProofSummary(venueId);
    final widgets = <Map<String, dynamic>>[];
    
    // Friend check-ins widget
    if (socialProof['friendCheckIns'] > 0) {
      widgets.add({
        'type': 'friend_checkins',
        'title': '👥 ${socialProof['friendCheckIns']} friends visited',
        'subtitle': 'Including ${socialProof['friendNames'].take(2).join(', ')}',
        'color': 'green',
        'priority': 1,
      });
    }
    
    // Recent activity widget
    if (socialProof['recentCheckIns'] > 0) {
      widgets.add({
        'type': 'recent_activity',
        'title': '🔥 ${socialProof['recentCheckIns']} recent check-ins',
        'subtitle': 'Active community venue',
        'color': 'orange',
        'priority': 2,
      });
    }
    
    // Community rating widget
    if (socialProof['averageRating'] > 4.0) {
      widgets.add({
        'type': 'high_rating',
        'title': '⭐ ${socialProof['averageRating'].toStringAsFixed(1)} community rating',
        'subtitle': 'Highly recommended by community',
        'color': 'blue',
        'priority': 3,
      });
    }
    
    // Community tags widget
    if (socialProof['communityTags'].isNotEmpty) {
      widgets.add({
        'type': 'community_tags',
        'title': '🏷️ Community says',
        'subtitle': socialProof['communityTags'].take(3).join(', '),
        'color': 'purple',
        'priority': 4,
      });
    }
    
    // Sort by priority
    widgets.sort((a, b) => a['priority'].compareTo(b['priority']));
    
    return widgets;
  }

  /// Get trust indicators for venue
  Map<String, dynamic> getTrustIndicators(String venueId) {
    final stats = getCommunityStats(venueId);
    final checkIns = getVenueCheckIns(venueId);
    
    final trustScore = _calculateTrustScore(stats, checkIns);
    
    return {
      'trustScore': trustScore,
      'trustLevel': _getTrustLevel(trustScore),
      'indicators': [
        if (stats['totalVisits'] != null && stats['totalVisits'] > 100) 'High Community Activity',
        if (stats['averageRating'] != null && stats['averageRating'] > 4.0) 'Excellent Reviews',
        if (checkIns.where((c) => c['isFriend']).isNotEmpty) 'Friend Recommended',
        if (stats['communityTags'] != null && stats['communityTags'].contains('Halal')) 'Halal Certified',
      ],
    };
  }

  double _calculateTrustScore(Map<String, dynamic> stats, List<Map<String, dynamic>> checkIns) {
    double score = 0.0;
    
    // Base score from rating
    score += (stats['averageRating'] ?? 0.0) * 20;
    
    // Activity bonus
    final totalVisits = stats['totalVisits'] ?? 0;
    score += (totalVisits / 10).clamp(0, 20);
    
    // Friend bonus
    final friendCheckIns = checkIns.where((c) => c['isFriend']).length;
    score += friendCheckIns * 10;
    
    // Recent activity bonus
    final recentCheckIns = checkIns.where(
      (c) => DateTime.now().difference(c['timestamp']).inDays < 7
    ).length;
    score += recentCheckIns * 5;
    
    return score.clamp(0, 100);
  }

  String _getTrustLevel(double score) {
    if (score >= 80) return 'Highly Trusted';
    if (score >= 60) return 'Community Trusted';
    if (score >= 40) return 'Moderately Trusted';
    return 'New to Community';
  }
}