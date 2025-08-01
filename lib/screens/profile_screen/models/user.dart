


class DeadHourUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final Set<UserRole> activeRoles; // Revolutionary Role stacking system
  final String city;
  final String? profileImageUrl;
  final DateTime joinDate;
  final String preferredLanguage;
  final bool isVerified;
  final Map<UserRole, Map<String, dynamic>> roleCapabilities;
  final Map<String, dynamic> crossRoleMetrics;
  final double networkEffectMultiplier;
  final List<String> favoriteCategories;
  final List<String> languages;

  DeadHourUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.activeRoles = const {UserRole.consumer}, // All users start as Consumer by default
    required this.city,
    this.profileImageUrl,
    required this.joinDate,
    this.preferredLanguage = 'en',
    this.isVerified = false,
    this.roleCapabilities = const {},
    this.crossRoleMetrics = const {},
    this.networkEffectMultiplier = 1.0,
    this.favoriteCategories = const [],
    this.languages = const ['en'],
  });

  factory DeadHourUser.fromJson(Map<String, dynamic> json) {
    Set<UserRole> roles = {};
    if (json['activeRoles'] != null) {
      final List<String> roleStrings = List<String>.from(json['activeRoles']);
      roles = roleStrings
          .map((role) => UserRole.values.firstWhere(
                (e) =>
                    e.name.toLowerCase() ==
                    role.toLowerCase(), // Use toLowerCase for comparison
                orElse: () =>
                    UserRole.consumer, // Default to consumer if role not found
              ))
          .toSet();
    }

    return DeadHourUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      activeRoles: roles,
      city: json['city'],
      profileImageUrl: json['profileImageUrl'],
      joinDate: DateTime.parse(json['joinDate']),
      preferredLanguage: json['preferredLanguage'] ?? 'en',
      isVerified: json['isVerified'] ?? false,
      roleCapabilities: Map<UserRole, Map<String, dynamic>>.from(
          json['roleCapabilities'] ?? {}),
      crossRoleMetrics:
          Map<String, dynamic>.from(json['crossRoleMetrics'] ?? {}),
      networkEffectMultiplier:
          (json['networkEffectMultiplier'] ?? 1.0).toDouble(),
      favoriteCategories: List<String>.from(json['favoriteCategories'] ?? []),
      languages: List<String>.from(json['languages'] ?? ['en']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'activeRoles': activeRoles.map((role) => role.name).toList(),
      'city': city,
      'profileImageUrl': profileImageUrl,
      'joinDate': joinDate.toIso8601String(),
      'preferredLanguage': preferredLanguage,
      'isVerified': isVerified,
      'roleCapabilities': roleCapabilities,
      'crossRoleMetrics': crossRoleMetrics,
      'networkEffectMultiplier': networkEffectMultiplier,
      'favoriteCategories': favoriteCategories,
      'languages': languages,
    };
  }

  DeadHourUser copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    Set<UserRole>? activeRoles,
    String? city,
    String? profileImageUrl,
    DateTime? joinDate,
    String? preferredLanguage,
    bool? isVerified,
    Map<UserRole, Map<String, dynamic>>? roleCapabilities,
    Map<String, dynamic>? crossRoleMetrics,
    double? networkEffectMultiplier,
    List<String>? favoriteCategories,
    List<String>? languages,
  }) {
    return DeadHourUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      activeRoles: activeRoles ?? this.activeRoles,
      city: city ?? this.city,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      joinDate: joinDate ?? this.joinDate,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      isVerified: isVerified ?? this.isVerified,
      roleCapabilities: roleCapabilities ?? this.roleCapabilities,
      crossRoleMetrics: crossRoleMetrics ?? this.crossRoleMetrics,
      networkEffectMultiplier:
          networkEffectMultiplier ?? this.networkEffectMultiplier,
      favoriteCategories: favoriteCategories ?? this.favoriteCategories,
      languages: languages ?? this.languages,
    );
  }

  // Role System Getters
  bool get hasBusinessRole => activeRoles.contains(UserRole.business);
  bool get hasGuideRole => activeRoles.contains(UserRole.guide);
  bool get hasPremiumRole => activeRoles.contains(UserRole.premium);
  bool get hasDriverRole => activeRoles.contains(UserRole.driver);
  bool get hasHostRole => activeRoles.contains(UserRole.host);
  bool get hasChefRole => activeRoles.contains(UserRole.chef);
  bool get hasPhotographerRole => activeRoles.contains(UserRole.photographer);

  // Generic hasRole method for backward compatibility
  bool hasRole(String roleName) {
    final role = UserRole.values.firstWhere(
      (e) => e.name.toLowerCase() == roleName.toLowerCase(),
      orElse: () => UserRole.premium,
    );
    return activeRoles.contains(role);
  }

  double get monthlyRevenuePotential {
    double revenue = 0;
    if (hasBusinessRole) revenue += 30; // €30/month
    if (hasGuideRole) revenue += 20; // €20/month
    if (hasPremiumRole) revenue += 15; // €15/month
    return revenue * networkEffectMultiplier;
  }

  String get displayRoles {
    if (activeRoles.isEmpty) return 'Consumer';
    return activeRoles.map((role) => role.name).join(' + ');
  }

  String get userTypeIcon {
    if (activeRoles.isEmpty) return '👤'; // Consumer
    if (hasBusinessRole && hasGuideRole && hasPremiumRole) {
      return '💎'; // Triple Role
    }
    if (hasBusinessRole && hasGuideRole) return '🏢✈️'; // Business + Guide
    if (hasBusinessRole && hasPremiumRole) return '🏢💎'; // Business + Premium
    if (hasGuideRole && hasPremiumRole) return '✈️💎'; // Guide + Premium
    if (hasBusinessRole) return '🏢'; // Business Role
    if (hasGuideRole) return '✈️'; // Guide Role
    if (hasPremiumRole) return '💎'; // Premium Role
    return '👤'; // Default Consumer
  }

  // Additional getters for compatibility with existing code
  String get profilePicture =>
      profileImageUrl ?? 'https://i.pravatar.cc/150?img=1';
  String get userTypeDisplay => displayRoles;
  String get memberSince =>
      '${joinDate.day}/${joinDate.month}/${joinDate.year}';
  double get rating => networkEffectMultiplier;

  Map<String, dynamic> get stats => {
        'activeRoles': activeRoles.length,
        'monthlyRevenue': monthlyRevenuePotential.toInt(),
        'roomsJoined': favoriteCategories.length *
            (activeRoles.length + 1), // Role multiplier
        'networkEffect':
            (networkEffectMultiplier * 100).toInt(), // Network effect score
      };

  // Role management methods
  DeadHourUser addRole(UserRole role) {
    final newRoles = Set<UserRole>.from(activeRoles)..add(role);
    return copyWith(activeRoles: newRoles);
  }

  DeadHourUser removeRole(UserRole role) {
    final newRoles = Set<UserRole>.from(activeRoles)..remove(role);
    return copyWith(activeRoles: newRoles);
  }

  bool canAccessRoleFeature(UserRole requiredRole) {
    return activeRoles.contains(requiredRole);
  }
}
