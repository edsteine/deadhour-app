import '../utils/mock_data.dart';

/// Enhanced group booking coordination service
/// Handles social booking features, group deal negotiations, and waitlist management
class GroupBookingService {
  static final GroupBookingService _instance = GroupBookingService._internal();
  factory GroupBookingService() => _instance;
  GroupBookingService._internal();

  // Mock group booking data
  final List<Map<String, dynamic>> _groupBookings = [
    {
      'id': 'group_1',
      'venueName': 'Café Central',
      'venueId': 'venue_1',
      'organizer': 'Ahmed_Casa',
      'organizerId': 'user_ahmed',
      'title': 'Study Group Session',
      'description': 'Working on project together, need quiet atmosphere',
      'dateTime': DateTime.now().add(const Duration(hours: 3)),
      'duration': 120, // minutes
      'maxParticipants': 6,
      'currentParticipants': ['user_ahmed', 'user_sarah'],
      'waitlist': ['user_youssef'],
      'status': 'open', // open, full, confirmed, cancelled
      'dealRequested': true,
      'groupDiscount': 15.0,
      'requirements': ['wifi', 'quiet', 'power_outlets'],
      'messages': [
        {
          'userId': 'user_ahmed',
          'username': 'Ahmed_Casa',
          'message': 'Let\'s meet for our project work!',
          'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        },
        {
          'userId': 'user_sarah',
          'username': 'Sarah_Guide',
          'message': 'Perfect! I\'ll bring my laptop.',
          'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
        },
      ],
      'venue_response': {
        'status': 'pending',
        'discount_offered': 10.0,
        'special_arrangements': 'Reserved quiet corner table',
        'contact_person': 'Manager Ahmed',
      },
    },
    {
      'id': 'group_2',
      'venueName': 'Moroccan Palace',
      'venueId': 'venue_2',
      'organizer': 'LocalFoodie',
      'organizerId': 'user_youssef',
      'title': 'Traditional Dinner Experience',
      'description': 'Authentic Moroccan cuisine with friends',
      'dateTime': DateTime.now().add(const Duration(days: 1, hours: -4)),
      'duration': 180,
      'maxParticipants': 8,
      'currentParticipants': ['user_youssef', 'user_ahmed', 'user_sarah'],
      'waitlist': [],
      'status': 'confirmed',
      'dealRequested': true,
      'groupDiscount': 20.0,
      'requirements': ['halal', 'family_friendly', 'traditional_music'],
      'messages': [],
      'venue_response': {
        'status': 'confirmed',
        'discount_offered': 20.0,
        'special_arrangements': 'Traditional music performance included',
        'contact_person': 'Chef Hassan',
      },
    },
  ];

  final List<Map<String, dynamic>> _groupDealRequests = [
    {
      'id': 'deal_request_1',
      'groupBookingId': 'group_1',
      'venueId': 'venue_1',
      'organizerId': 'user_ahmed',
      'participantCount': 6,
      'requestedDiscount': 15.0,
      'message': 'Regular customers looking for group discount for study sessions',
      'status': 'pending', // pending, approved, rejected, negotiating
      'venueResponse': null,
      'createdAt': DateTime.now().subtract(const Duration(hours: 6)),
    },
  ];

  /// Get all group bookings
  List<Map<String, dynamic>> getAllGroupBookings() {
    return List.from(_groupBookings)
      ..sort((a, b) => a['dateTime'].compareTo(b['dateTime']));
  }

  /// Get group bookings for a specific venue
  List<Map<String, dynamic>> getGroupBookingsForVenue(String venueId) {
    return _groupBookings
        .where((booking) => booking['venueId'] == venueId)
        .toList()
      ..sort((a, b) => a['dateTime'].compareTo(b['dateTime']));
  }

  /// Get user's group bookings (as organizer or participant)
  List<Map<String, dynamic>> getUserGroupBookings(String userId) {
    return _groupBookings.where((booking) {
      final participants = booking['currentParticipants'] as List<String>;
      return booking['organizerId'] == userId || participants.contains(userId);
    }).toList()
      ..sort((a, b) => a['dateTime'].compareTo(b['dateTime']));
  }

  /// Create a new group booking
  String createGroupBooking({
    required String venueId,
    required String venueName,
    required String organizerId,
    required String organizerName,
    required String title,
    required String description,
    required DateTime dateTime,
    required int duration,
    required int maxParticipants,
    required bool requestDeal,
    required double requestedDiscount,
    required List<String> requirements,
  }) {
    final bookingId = 'group_${DateTime.now().millisecondsSinceEpoch}';
    
    final groupBooking = {
      'id': bookingId,
      'venueName': venueName,
      'venueId': venueId,
      'organizer': organizerName,
      'organizerId': organizerId,
      'title': title,
      'description': description,
      'dateTime': dateTime,
      'duration': duration,
      'maxParticipants': maxParticipants,
      'currentParticipants': [organizerId],
      'waitlist': <String>[],
      'status': 'open',
      'dealRequested': requestDeal,
      'groupDiscount': requestedDiscount,
      'requirements': requirements,
      'messages': <Map<String, dynamic>>[],
      'venue_response': {
        'status': 'pending',
        'discount_offered': 0.0,
        'special_arrangements': '',
        'contact_person': '',
      },
    };

    _groupBookings.add(groupBooking);

    // Create deal request if requested
    if (requestDeal) {
      _createGroupDealRequest(bookingId, venueId, organizerId, maxParticipants, requestedDiscount);
    }

    return bookingId;
  }

  /// Join a group booking
  bool joinGroupBooking(String bookingId, String userId) {
    final booking = _groupBookings.firstWhere(
      (b) => b['id'] == bookingId,
      orElse: () => {},
    );

    if (booking.isEmpty || booking['status'] != 'open') return false;

    final participants = booking['currentParticipants'] as List<String>;
    final maxParticipants = booking['maxParticipants'] as int;

    if (participants.contains(userId)) return false; // Already joined

    if (participants.length < maxParticipants) {
      participants.add(userId);
      return true;
    } else {
      // Add to waitlist
      final waitlist = booking['waitlist'] as List<String>;
      if (!waitlist.contains(userId)) {
        waitlist.add(userId);
      }
      return false; // Added to waitlist
    }
  }

  /// Leave a group booking
  bool leaveGroupBooking(String bookingId, String userId) {
    final booking = _groupBookings.firstWhere(
      (b) => b['id'] == bookingId,
      orElse: () => {},
    );

    if (booking.isEmpty) return false;

    final participants = booking['currentParticipants'] as List<String>;
    final waitlist = booking['waitlist'] as List<String>;

    if (participants.contains(userId)) {
      participants.remove(userId);
      
      // Move someone from waitlist if available
      if (waitlist.isNotEmpty) {
        final nextUser = waitlist.removeAt(0);
        participants.add(nextUser);
      }
      return true;
    }

    if (waitlist.contains(userId)) {
      waitlist.remove(userId);
      return true;
    }

    return false;
  }

  /// Add message to group booking chat
  void addGroupMessage(String bookingId, String userId, String username, String message) {
    final booking = _groupBookings.firstWhere(
      (b) => b['id'] == bookingId,
      orElse: () => {},
    );

    if (booking.isNotEmpty) {
      final messages = booking['messages'] as List<Map<String, dynamic>>;
      messages.add({
        'userId': userId,
        'username': username,
        'message': message,
        'timestamp': DateTime.now(),
      });
    }
  }

  /// Get group booking details
  Map<String, dynamic>? getGroupBookingDetails(String bookingId) {
    try {
      return _groupBookings.firstWhere((b) => b['id'] == bookingId);
    } catch (e) {
      return null;
    }
  }

  /// Update group booking status
  void updateGroupBookingStatus(String bookingId, String status) {
    final booking = _groupBookings.firstWhere(
      (b) => b['id'] == bookingId,
      orElse: () => {},
    );

    if (booking.isNotEmpty) {
      booking['status'] = status;
    }
  }

  /// Get group deal negotiation opportunities
  List<Map<String, dynamic>> getGroupDealOpportunities() {
    return _groupBookings.where((booking) {
      final participants = booking['currentParticipants'] as List<String>;
      return participants.length >= 4 && // Minimum for group discount
             booking['status'] == 'open' &&
             booking['dealRequested'] == true;
    }).map((booking) => {
      'bookingId': booking['id'],
      'venueName': booking['venueName'],
      'participantCount': (booking['currentParticipants'] as List).length,
      'maxParticipants': booking['maxParticipants'],
      'requestedDiscount': booking['groupDiscount'],
      'dateTime': booking['dateTime'],
      'potential_savings': _calculatePotentialSavings(booking),
    }).toList();
  }

  /// Submit group deal request
  String submitGroupDealRequest({
    required String groupBookingId,
    required String venueId,
    required String organizerId,
    required int participantCount,
    required double requestedDiscount,
    required String message,
  }) {
    return _createGroupDealRequest(
      groupBookingId,
      venueId,
      organizerId,
      participantCount,
      requestedDiscount,
      message: message,
    );
  }

  /// Get group deal requests for venue
  List<Map<String, dynamic>> getGroupDealRequestsForVenue(String venueId) {
    return _groupDealRequests
        .where((request) => request['venueId'] == venueId)
        .toList()
      ..sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
  }

  /// Respond to group deal request (venue side)
  void respondToGroupDealRequest({
    required String requestId,
    required String status, // approved, rejected, counter_offer
    double? offeredDiscount,
    String? responseMessage,
    String? specialArrangements,
    String? contactPerson,
  }) {
    final request = _groupDealRequests.firstWhere(
      (r) => r['id'] == requestId,
      orElse: () => {},
    );

    if (request.isNotEmpty) {
      request['status'] = status;
      request['venueResponse'] = {
        'discount_offered': offeredDiscount ?? 0.0,
        'message': responseMessage ?? '',
        'special_arrangements': specialArrangements ?? '',
        'contact_person': contactPerson ?? '',
        'responded_at': DateTime.now(),
      };

      // Update the group booking with venue response
      final groupBooking = _groupBookings.firstWhere(
        (b) => b['id'] == request['groupBookingId'],
        orElse: () => {},
      );

      if (groupBooking.isNotEmpty) {
        groupBooking['venue_response'] = {
          'status': status,
          'discount_offered': offeredDiscount ?? 0.0,
          'special_arrangements': specialArrangements ?? '',
          'contact_person': contactPerson ?? '',
        };

        if (status == 'approved') {
          groupBooking['status'] = 'confirmed';
          groupBooking['groupDiscount'] = offeredDiscount ?? 0.0;
        }
      }
    }
  }

  /// Get smart group suggestions for user
  List<Map<String, dynamic>> getSmartGroupSuggestions(String userId) {
    final userBookings = getUserGroupBookings(userId);
    final userPreferences = _analyzeUserPreferences(userBookings);
    
    return _groupBookings.where((booking) {
      final participants = booking['currentParticipants'] as List<String>;
      return !participants.contains(userId) && // Not already joined
             booking['status'] == 'open' &&
             _matchesUserPreferences(booking, userPreferences);
    }).map((booking) => {
      ...booking,
      'match_score': _calculateMatchScore(booking, userPreferences),
      'mutual_friends': _getMutualFriends(userId, booking['currentParticipants']),
    }).toList()
      ..sort((a, b) => b['match_score'].compareTo(a['match_score']));
  }

  /// Get group booking statistics
  Map<String, dynamic> getGroupBookingStats() {
    final total = _groupBookings.length;
    final active = _groupBookings.where((b) => b['status'] == 'open').length;
    final confirmed = _groupBookings.where((b) => b['status'] == 'confirmed').length;
    
    final totalParticipants = _groupBookings.fold(0, (sum, booking) {
      final participants = booking['currentParticipants'] as List;
      return sum + participants.length;
    });

    final averageGroupSize = total > 0 ? totalParticipants / total : 0.0;
    
    final dealRequests = _groupDealRequests.length;
    final approvedDeals = _groupDealRequests.where((r) => r['status'] == 'approved').length;
    final dealSuccessRate = dealRequests > 0 ? approvedDeals / dealRequests : 0.0;

    return {
      'total_bookings': total,
      'active_bookings': active,
      'confirmed_bookings': confirmed,
      'average_group_size': averageGroupSize.toStringAsFixed(1),
      'total_participants': totalParticipants,
      'deal_requests': dealRequests,
      'deal_success_rate': (dealSuccessRate * 100).toStringAsFixed(1),
      'total_savings': _calculateTotalSavings(),
    };
  }

  /// Get waitlist management data
  Map<String, dynamic> getWaitlistData(String bookingId) {
    final booking = getGroupBookingDetails(bookingId);
    if (booking == null) return {};

    final waitlist = booking['waitlist'] as List<String>;
    final maxParticipants = booking['maxParticipants'] as int;
    final currentParticipants = booking['currentParticipants'] as List<String>;
    final availableSpots = maxParticipants - currentParticipants.length;

    return {
      'waitlist_count': waitlist.length,
      'available_spots': availableSpots,
      'can_accommodate_waitlist': availableSpots >= waitlist.length,
      'estimated_wait_time': _estimateWaitTime(waitlist.length, availableSpots),
    };
  }

  /// Process waitlist automatically
  void processWaitlist(String bookingId) {
    final booking = getGroupBookingDetails(bookingId);
    if (booking == null) return;

    final waitlist = booking['waitlist'] as List<String>;
    final maxParticipants = booking['maxParticipants'] as int;
    final participants = booking['currentParticipants'] as List<String>;

    while (waitlist.isNotEmpty && participants.length < maxParticipants) {
      final nextUser = waitlist.removeAt(0);
      participants.add(nextUser);
    }
  }

  // Private helper methods

  String _createGroupDealRequest(
    String groupBookingId,
    String venueId,
    String organizerId,
    int participantCount,
    double requestedDiscount, {
    String? message,
  }) {
    final requestId = 'deal_request_${DateTime.now().millisecondsSinceEpoch}';
    
    _groupDealRequests.add({
      'id': requestId,
      'groupBookingId': groupBookingId,
      'venueId': venueId,
      'organizerId': organizerId,
      'participantCount': participantCount,
      'requestedDiscount': requestedDiscount,
      'message': message ?? 'Group booking discount request',
      'status': 'pending',
      'venueResponse': null,
      'createdAt': DateTime.now(),
    });

    return requestId;
  }

  double _calculatePotentialSavings(Map<String, dynamic> booking) {
    final participants = booking['currentParticipants'] as List;
    final discount = booking['groupDiscount'] as double;
    const averageOrderValue = 120.0; // MAD
    
    return participants.length * averageOrderValue * (discount / 100);
  }

  Map<String, dynamic> _analyzeUserPreferences(List<Map<String, dynamic>> userBookings) {
    final preferences = <String, int>{};
    final timePreferences = <int>[];
    
    for (final booking in userBookings) {
      final requirements = booking['requirements'] as List<String>;
      for (final req in requirements) {
        preferences[req] = (preferences[req] ?? 0) + 1;
      }
      
      final dateTime = booking['dateTime'] as DateTime;
      timePreferences.add(dateTime.hour);
    }

    return {
      'preferred_features': preferences,
      'preferred_times': timePreferences,
    };
  }

  bool _matchesUserPreferences(Map<String, dynamic> booking, Map<String, dynamic> preferences) {
    final bookingRequirements = booking['requirements'] as List<String>;
    final userFeatures = preferences['preferred_features'] as Map<String, int>;
    
    // Check if booking has features user likes
    final commonFeatures = bookingRequirements.where((req) => userFeatures.containsKey(req)).length;
    
    return commonFeatures > 0;
  }

  double _calculateMatchScore(Map<String, dynamic> booking, Map<String, dynamic> preferences) {
    double score = 0.0;
    
    final bookingRequirements = booking['requirements'] as List<String>;
    final userFeatures = preferences['preferred_features'] as Map<String, int>;
    
    // Feature matching score
    for (final req in bookingRequirements) {
      if (userFeatures.containsKey(req)) {
        score += userFeatures[req]! * 10.0;
      }
    }
    
    // Time preference score
    final bookingTime = (booking['dateTime'] as DateTime).hour;
    final userTimes = preferences['preferred_times'] as List<int>;
    if (userTimes.contains(bookingTime)) {
      score += 20.0;
    }
    
    // Group size preference (moderate groups preferred)
    final participants = booking['currentParticipants'] as List;
    if (participants.length >= 3 && participants.length <= 6) {
      score += 15.0;
    }
    
    return score;
  }

  List<String> _getMutualFriends(String userId, List<String> participants) {
    // Mock implementation - would check actual friend connections in real app
    final mockFriends = ['user_ahmed', 'user_sarah'];
    return participants.where((p) => mockFriends.contains(p) && p != userId).toList();
  }

  double _calculateTotalSavings() {
    return _groupBookings.fold(0.0, (total, booking) {
      if (booking['status'] == 'confirmed') {
        return total + _calculatePotentialSavings(booking);
      }
      return total;
    });
  }

  String _estimateWaitTime(int waitlistPosition, int availableSpots) {
    if (availableSpots >= waitlistPosition) {
      return 'Available now';
    }
    
    final waitTime = (waitlistPosition - availableSpots) * 30; // 30 minutes per position
    if (waitTime < 60) {
      return '${waitTime}m wait';
    } else {
      return '${(waitTime / 60).ceil()}h wait';
    }
  }

  /// Get group booking recommendations for venues
  List<Map<String, dynamic>> getVenueGroupRecommendations(String venueId) {
    final venue = MockData.venues.firstWhere((v) => v.id == venueId);
    final existingBookings = getGroupBookingsForVenue(venueId);
    
    return [
      {
        'type': 'time_slot',
        'title': 'Popular Group Times',
        'description': 'Based on successful group bookings',
        'recommendations': ['14:00-16:00', '19:00-21:00'],
      },
      {
        'type': 'group_size',
        'title': 'Optimal Group Sizes',
        'description': 'Best group sizes for this venue',
        'recommendations': ['4-6 people', '6-8 people'],
      },
      {
        'type': 'features',
        'title': 'Popular Group Features',
        'description': 'Most requested features for groups',
        'recommendations': venue.hasWifi ? ['WiFi', 'Quiet area'] : ['Social area', 'Entertainment'],
      },
    ];
  }
}