class Room {
  final String id;
  final String name;
  final String displayName;
  final String category;
  final String city;
  final String description;
  final int memberCount;
  final int onlineCount;
  final bool isPublic;
  final bool allowDeals;
  final bool isPrayerTimeAware;
  final bool isHalalOnly;
  final DateTime createdAt;
  final DateTime lastActivity;
  final List<String> moderators;
  final List<Map<String, dynamic>> recentMessages;
  final bool isPremiumOnly;
  final String? imageUrl;
  final Map<String, dynamic>? settings;
  final List<String> tags;
  final bool isJoined; // Added for My Rooms
  final bool isPopular; // Added for Popular Rooms

  Room({
    required this.id,
    required this.name,
    required this.displayName,
    required this.category,
    required this.city,
    required this.description,
    required this.memberCount,
    required this.onlineCount,
    this.isPublic = true,
    this.allowDeals = true,
    this.isPrayerTimeAware = false,
    this.isHalalOnly = false,
    required this.createdAt,
    required this.lastActivity,
    this.moderators = const [],
    this.recentMessages = const [],
    this.isPremiumOnly = false,
    this.imageUrl,
    this.settings,
    this.tags = const [],
    this.isJoined = false, // Default to false
    this.isPopular = false, // Default to false
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      displayName: json['displayName'],
      category: json['category'],
      city: json['city'],
      description: json['description'],
      memberCount: json['memberCount'] ?? 0,
      onlineCount: json['onlineCount'] ?? 0,
      isPublic: json['isPublic'] ?? true,
      allowDeals: json['allowDeals'] ?? true,
      isPrayerTimeAware: json['isPrayerTimeAware'] ?? false,
      isHalalOnly: json['isHalalOnly'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      lastActivity: DateTime.parse(json['lastActivity']),
      moderators: List<String>.from(json['moderators'] ?? []),
      recentMessages:
          List<Map<String, dynamic>>.from(json['recentMessages'] ?? []),
      isPremiumOnly: json['isPremiumOnly'] ?? false,
      imageUrl: json['imageUrl'],
      settings: json['settings'],
      tags: List<String>.from(json['tags'] ?? []),
      isJoined: json['isJoined'] ?? false, // Parse from JSON
      isPopular: json['isPopular'] ?? false, // Parse from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'displayName': displayName,
      'category': category,
      'city': city,
      'description': description,
      'memberCount': memberCount,
      'onlineCount': onlineCount,
      'isPublic': isPublic,
      'allowDeals': allowDeals,
      'isPrayerTimeAware': isPrayerTimeAware,
      'isHalalOnly': isHalalOnly,
      'createdAt': createdAt.toIso8601String(),
      'lastActivity': lastActivity.toIso8601String(),
      'moderators': moderators,
      'recentMessages': recentMessages,
      'isPremiumOnly': isPremiumOnly,
      'imageUrl': imageUrl,
      'settings': settings,
      'tags': tags,
      'isJoined': isJoined,
      'isPopular': isPopular,
    };
  }

  Room copyWith({
    String? id,
    String? name,
    String? displayName,
    String? category,
    String? city,
    String? description,
    int? memberCount,
    int? onlineCount,
    bool? isPublic,
    bool? allowDeals,
    bool? isPrayerTimeAware,
    bool? isHalalOnly,
    DateTime? createdAt,
    DateTime? lastActivity,
    List<String>? moderators,
    List<Map<String, dynamic>>? recentMessages,
    bool? isPremiumOnly,
    String? imageUrl,
    Map<String, dynamic>? settings,
    List<String>? tags,
    bool? isJoined,
    bool? isPopular,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      category: category ?? this.category,
      city: city ?? this.city,
      description: description ?? this.description,
      memberCount: memberCount ?? this.memberCount,
      onlineCount: onlineCount ?? this.onlineCount,
      isPublic: isPublic ?? this.isPublic,
      allowDeals: allowDeals ?? this.allowDeals,
      isPrayerTimeAware: isPrayerTimeAware ?? this.isPrayerTimeAware,
      isHalalOnly: isHalalOnly ?? this.isHalalOnly,
      createdAt: createdAt ?? this.createdAt,
      lastActivity: lastActivity ?? this.lastActivity,
      moderators: moderators ?? this.moderators,
      recentMessages: recentMessages ?? this.recentMessages,
      isPremiumOnly: isPremiumOnly ?? this.isPremiumOnly,
      imageUrl: imageUrl ?? this.imageUrl,
      settings: settings ?? this.settings,
      tags: tags ?? this.tags,
      isJoined: isJoined ?? this.isJoined,
      isPopular: isPopular ?? this.isPopular,
    );
  }

  String get categoryIcon {
    switch (category) {
      case 'food':
        return '🍕';
      case 'entertainment':
        return '🎮';
      case 'wellness':
        return '💆';
      case 'sports':
        return '⚽';
      case 'guide':
        return '🌍';
      case 'family':
        return '👨‍👩‍👧‍👦';
      default:
        return '💬';
    }
  }

  String get categoryName {
    switch (category) {
      case 'food':
        return 'Food & Dining';
      case 'entertainment':
        return 'Entertainment';
      case 'wellness':
        return 'Wellness & Spa';
      case 'sports':
        return 'Sports & Fitness';
      case 'guide':
        return 'Local Guide';
      case 'family':
        return 'Family';
      default:
        return 'General';
    }
  }

  bool get isActive {
    final now = DateTime.now();
    final timeSinceLastActivity = now.difference(lastActivity);
    return timeSinceLastActivity.inHours < 24;
  }

  String get activityStatus {
    final now = DateTime.now();
    final timeSinceLastActivity = now.difference(lastActivity);

    if (timeSinceLastActivity.inMinutes < 5) {
      return 'Very Active';
    } else if (timeSinceLastActivity.inMinutes < 30) {
      return 'Active';
    } else if (timeSinceLastActivity.inHours < 2) {
      return 'Recently Active';
    } else if (timeSinceLastActivity.inHours < 24) {
      return 'Quiet';
    } else {
      return 'Inactive';
    }
  }

  String get lastActivityDisplay {
    final now = DateTime.now();
    final difference = now.difference(lastActivity);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${(difference.inDays / 7).floor()}w ago';
    }
  }

  double get engagementRate {
    return memberCount > 0 ? (onlineCount / memberCount) * 100 : 0;
  }

  String get privacyIcon {
    if (isPremiumOnly) return '👑';
    return isPublic ? '🌐' : '🔒';
  }

  String get privacyStatus {
    if (isPremiumOnly) return 'Premium Only';
    return isPublic ? 'Public' : 'Private';
  }

  bool get hasRecentActivity {
    return recentMessages.isNotEmpty;
  }

  Map<String, dynamic>? get lastMessage {
    return recentMessages.isNotEmpty ? recentMessages.last : null;
  }

  String get roomType {
    if (isPremiumOnly) return 'Premium';
    if (!isPublic) return 'Private';
    if (allowDeals) return 'Deal Room';
    return 'Community';
  }

  List<String> get specialFeatures {
    final List<String> features = [];
    if (allowDeals) features.add('Deals');
    if (isPrayerTimeAware) features.add('Prayer Times');
    if (isHalalOnly) features.add('Halal Only');
    if (isPremiumOnly) features.add('Premium');
    return features;
  }
}
