enum UserAddon {
  business,
  guide, 
  premium,
  driver,
  host,
  chef,
  photographer
}

class DeadHourUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final Set<UserAddon> activeAddons; // Revolutionary ADDON stacking system
  final String city;
  final String? profileImageUrl;
  final DateTime joinDate;
  final String preferredLanguage;
  final bool isVerified;
  final Map<UserAddon, Map<String, dynamic>> addonCapabilities;
  final Map<String, dynamic> crossAddonMetrics;
  final double networkEffectMultiplier;
  final List<String> favoriteCategories;
  final List<String> languages;

  DeadHourUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.activeAddons = const {}, // Start as Consumer, add ADDONs progressively
    required this.city,
    this.profileImageUrl,
    required this.joinDate,
    this.preferredLanguage = 'en',
    this.isVerified = false,
    this.addonCapabilities = const {},
    this.crossAddonMetrics = const {},
    this.networkEffectMultiplier = 1.0,
    this.favoriteCategories = const [],
    this.languages = const ['en'],
  });

  factory DeadHourUser.fromJson(Map<String, dynamic> json) {
    Set<UserAddon> addons = {};
    if (json['activeAddons'] != null) {
      List<String> addonStrings = List<String>.from(json['activeAddons']);
      addons = addonStrings.map((addon) => UserAddon.values.firstWhere(
        (e) => e.name == addon.toUpperCase(),
        orElse: () => UserAddon.premium,
      )).toSet();
    }
    
    return DeadHourUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      activeAddons: addons,
      city: json['city'],
      profileImageUrl: json['profileImageUrl'],
      joinDate: DateTime.parse(json['joinDate']),
      preferredLanguage: json['preferredLanguage'] ?? 'en',
      isVerified: json['isVerified'] ?? false,
      addonCapabilities: Map<UserAddon, Map<String, dynamic>>.from(json['addonCapabilities'] ?? {}),
      crossAddonMetrics: Map<String, dynamic>.from(json['crossAddonMetrics'] ?? {}),
      networkEffectMultiplier: (json['networkEffectMultiplier'] ?? 1.0).toDouble(),
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
      'activeAddons': activeAddons.map((addon) => addon.name).toList(),
      'city': city,
      'profileImageUrl': profileImageUrl,
      'joinDate': joinDate.toIso8601String(),
      'preferredLanguage': preferredLanguage,
      'isVerified': isVerified,
      'addonCapabilities': addonCapabilities,
      'crossAddonMetrics': crossAddonMetrics,
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
    Set<UserAddon>? activeAddons,
    String? city,
    String? profileImageUrl,
    DateTime? joinDate,
    String? preferredLanguage,
    bool? isVerified,
    Map<UserAddon, Map<String, dynamic>>? addonCapabilities,
    Map<String, dynamic>? crossAddonMetrics,
    double? networkEffectMultiplier,
    List<String>? favoriteCategories,
    List<String>? languages,
  }) {
    return DeadHourUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      activeAddons: activeAddons ?? this.activeAddons,
      city: city ?? this.city,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      joinDate: joinDate ?? this.joinDate,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      isVerified: isVerified ?? this.isVerified,
      addonCapabilities: addonCapabilities ?? this.addonCapabilities,
      crossAddonMetrics: crossAddonMetrics ?? this.crossAddonMetrics,
      networkEffectMultiplier: networkEffectMultiplier ?? this.networkEffectMultiplier,
      favoriteCategories: favoriteCategories ?? this.favoriteCategories,
      languages: languages ?? this.languages,
    );
  }

  // ADDON System Getters
  bool get hasBusinessAddon => activeAddons.contains(UserAddon.business);
  bool get hasGuideAddon => activeAddons.contains(UserAddon.guide);
  bool get hasPremiumAddon => activeAddons.contains(UserAddon.premium);
  bool get hasDriverAddon => activeAddons.contains(UserAddon.driver);
  bool get hasHostAddon => activeAddons.contains(UserAddon.host);
  bool get hasChefAddon => activeAddons.contains(UserAddon.chef);
  bool get hasPhotographerAddon => activeAddons.contains(UserAddon.photographer);
  
  // Generic hasAddon method for backward compatibility
  bool hasAddon(String addonName) {
    final addon = UserAddon.values.firstWhere(
      (e) => e.name.toLowerCase() == addonName.toLowerCase(),
      orElse: () => throw ArgumentError('Unknown addon: $addonName'),
    );
    return activeAddons.contains(addon);
  }
  
  double get monthlyRevenuePotential {
    double revenue = 0;
    if (hasBusinessAddon) revenue += 30; // €30/month
    if (hasGuideAddon) revenue += 20;    // €20/month  
    if (hasPremiumAddon) revenue += 15;  // €15/month
    return revenue * networkEffectMultiplier;
  }
  
  String get displayAddons {
    if (activeAddons.isEmpty) return 'Consumer';
    return activeAddons.map((addon) => addon.name).join(' + ');
  }

  String get userTypeIcon {
    if (activeAddons.isEmpty) return '👤'; // Consumer
    if (hasBusinessAddon && hasGuideAddon && hasPremiumAddon) return '💎'; // Triple ADDON
    if (hasBusinessAddon && hasGuideAddon) return '🏢✈️'; // Business + Guide
    if (hasBusinessAddon && hasPremiumAddon) return '🏢💎'; // Business + Premium
    if (hasGuideAddon && hasPremiumAddon) return '✈️💎'; // Guide + Premium
    if (hasBusinessAddon) return '🏢'; // Business ADDON
    if (hasGuideAddon) return '✈️'; // Guide ADDON
    if (hasPremiumAddon) return '💎'; // Premium ADDON
    return '👤'; // Default Consumer
  }
  
  // Additional getters for compatibility with existing code
  String get profilePicture => profileImageUrl ?? 'https://i.pravatar.cc/150?img=1';
  String get userTypeDisplay => displayAddons;
  String get memberSince => '${joinDate.day}/${joinDate.month}/${joinDate.year}';
  double get rating => networkEffectMultiplier;
  
  Map<String, dynamic> get stats => {
    'activeAddons': activeAddons.length,
    'monthlyRevenue': monthlyRevenuePotential.toInt(),
    'roomsJoined': favoriteCategories.length * (activeAddons.length + 1), // ADDON multiplier
    'networkEffect': (networkEffectMultiplier * 100).toInt(), // Network effect score
  };
  
  // ADDON management methods
  DeadHourUser addAddon(UserAddon addon) {
    final newAddons = Set<UserAddon>.from(activeAddons)..add(addon);
    return copyWith(activeAddons: newAddons);
  }
  
  DeadHourUser removeAddon(UserAddon addon) {
    final newAddons = Set<UserAddon>.from(activeAddons)..remove(addon);
    return copyWith(activeAddons: newAddons);
  }
  
  bool canAccessAddonFeature(UserAddon requiredAddon) {
    return activeAddons.contains(requiredAddon);
  }
}

