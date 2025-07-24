class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String userType; // 'local', 'tourist', 'business'
  final String city;
  final String? profileImageUrl;
  final DateTime joinDate;
  final String preferredLanguage;
  final bool isVerified;
  final int dealsUsed;
  final double communityScore;
  final double totalSavings;
  final List<String> favoriteCategories;
  final bool isPremium;
  final bool isLocalExpert;
  final String? expertiseAreas;
  final List<String> languages;
  final Map<String, dynamic>? businessInfo;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    required this.city,
    this.profileImageUrl,
    required this.joinDate,
    this.preferredLanguage = 'en',
    this.isVerified = false,
    this.dealsUsed = 0,
    this.communityScore = 0.0,
    this.totalSavings = 0.0,
    this.favoriteCategories = const [],
    this.isPremium = false,
    this.isLocalExpert = false,
    this.expertiseAreas,
    this.languages = const ['en'],
    this.businessInfo,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      userType: json['userType'],
      city: json['city'],
      profileImageUrl: json['profileImageUrl'],
      joinDate: DateTime.parse(json['joinDate']),
      preferredLanguage: json['preferredLanguage'] ?? 'en',
      isVerified: json['isVerified'] ?? false,
      dealsUsed: json['dealsUsed'] ?? 0,
      communityScore: (json['communityScore'] ?? 0.0).toDouble(),
      totalSavings: (json['totalSavings'] ?? 0.0).toDouble(),
      favoriteCategories: List<String>.from(json['favoriteCategories'] ?? []),
      isPremium: json['isPremium'] ?? false,
      isLocalExpert: json['isLocalExpert'] ?? false,
      expertiseAreas: json['expertiseAreas'],
      languages: List<String>.from(json['languages'] ?? ['en']),
      businessInfo: json['businessInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'userType': userType,
      'city': city,
      'profileImageUrl': profileImageUrl,
      'joinDate': joinDate.toIso8601String(),
      'preferredLanguage': preferredLanguage,
      'isVerified': isVerified,
      'dealsUsed': dealsUsed,
      'communityScore': communityScore,
      'totalSavings': totalSavings,
      'favoriteCategories': favoriteCategories,
      'isPremium': isPremium,
      'isLocalExpert': isLocalExpert,
      'expertiseAreas': expertiseAreas,
      'languages': languages,
      'businessInfo': businessInfo,
    };
  }

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? userType,
    String? city,
    String? profileImageUrl,
    DateTime? joinDate,
    String? preferredLanguage,
    bool? isVerified,
    int? dealsUsed,
    double? communityScore,
    double? totalSavings,
    List<String>? favoriteCategories,
    bool? isPremium,
    bool? isLocalExpert,
    String? expertiseAreas,
    List<String>? languages,
    Map<String, dynamic>? businessInfo,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      userType: userType ?? this.userType,
      city: city ?? this.city,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      joinDate: joinDate ?? this.joinDate,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      isVerified: isVerified ?? this.isVerified,
      dealsUsed: dealsUsed ?? this.dealsUsed,
      communityScore: communityScore ?? this.communityScore,
      totalSavings: totalSavings ?? this.totalSavings,
      favoriteCategories: favoriteCategories ?? this.favoriteCategories,
      isPremium: isPremium ?? this.isPremium,
      isLocalExpert: isLocalExpert ?? this.isLocalExpert,
      expertiseAreas: expertiseAreas ?? this.expertiseAreas,
      languages: languages ?? this.languages,
      businessInfo: businessInfo ?? this.businessInfo,
    );
  }

  bool get isLocal => userType == 'local';
  bool get isTourist => userType == 'tourist';
  bool get isBusiness => userType == 'business';
  
  String get displayUserType {
    switch (userType) {
      case 'local':
        return 'Local Resident';
      case 'tourist':
        return 'Tourist/Visitor';
      case 'business':
        return 'Business Owner';
      default:
        return 'User';
    }
  }

  String get userTypeIcon {
    switch (userType) {
      case 'local':
        return '🏠';
      case 'tourist':
        return '✈️';
      case 'business':
        return '🏢';
      default:
        return '👤';
    }
  }
  
  // Additional getters for compatibility with existing code
  String get profilePicture => profileImageUrl ?? 'https://i.pravatar.cc/150?img=1';
  String get userTypeDisplay => displayUserType;
  String get memberSince => '${joinDate.day}/${joinDate.month}/${joinDate.year}';
  double get rating => communityScore;
  
  Map<String, dynamic> get stats => {
    'dealsUsed': dealsUsed,
    'totalSaved': totalSavings.toInt(),
    'roomsJoined': favoriteCategories.length * 2, // Mock calculation
    'connectionsCount': (communityScore * 10).toInt(), // Mock calculation
  };
}

