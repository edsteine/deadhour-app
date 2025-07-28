class Deal {
  final String id;
  final String venueId;
  final String title;
  final String description;
  final String discountType; // 'percentage', 'fixed_price', 'bogo', 'combo'
  final double discountValue;
  final double originalPrice;
  final double discountedPrice;
  final DateTime validFrom;
  final DateTime validUntil;
  final int maxCapacity;
  final int currentBookings;
  final bool isActive;
  final List<String> categories;
  final List<String> daysOfWeek;
  final List<String> timeSlots;
  final String? imageUrl;
  final Map<String, dynamic>? restrictions;
  final bool isPrayerTimeAware;
  final bool isHalalOnly;

  Deal({
    required this.id,
    required this.venueId,
    required this.title,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.originalPrice,
    required this.discountedPrice,
    required this.validFrom,
    required this.validUntil,
    required this.maxCapacity,
    required this.currentBookings,
    this.isActive = true,
    this.categories = const [],
    this.daysOfWeek = const [],
    this.timeSlots = const [],
    this.imageUrl,
    this.restrictions,
    this.isPrayerTimeAware = false,
    this.isHalalOnly = false,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'],
      venueId: json['venueId'],
      title: json['title'],
      description: json['description'],
      discountType: json['discountType'],
      discountValue: (json['discountValue'] ?? 0.0).toDouble(),
      originalPrice: (json['originalPrice'] ?? 0.0).toDouble(),
      discountedPrice: (json['discountedPrice'] ?? 0.0).toDouble(),
      validFrom: DateTime.parse(json['validFrom']),
      validUntil: DateTime.parse(json['validUntil']),
      maxCapacity: json['maxCapacity'] ?? 0,
      currentBookings: json['currentBookings'] ?? 0,
      isActive: json['isActive'] ?? true,
      categories: List<String>.from(json['categories'] ?? []),
      daysOfWeek: List<String>.from(json['daysOfWeek'] ?? []),
      timeSlots: List<String>.from(json['timeSlots'] ?? []),
      imageUrl: json['imageUrl'],
      restrictions: json['restrictions'],
      isPrayerTimeAware: json['isPrayerTimeAware'] ?? false,
      isHalalOnly: json['isHalalOnly'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
      'title': title,
      'description': description,
      'discountType': discountType,
      'discountValue': discountValue,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'validFrom': validFrom.toIso8601String(),
      'validUntil': validUntil.toIso8601String(),
      'maxCapacity': maxCapacity,
      'currentBookings': currentBookings,
      'isActive': isActive,
      'categories': categories,
      'daysOfWeek': daysOfWeek,
      'timeSlots': timeSlots,
      'imageUrl': imageUrl,
      'restrictions': restrictions,
      'isPrayerTimeAware': isPrayerTimeAware,
      'isHalalOnly': isHalalOnly,
    };
  }

  Deal copyWith({
    String? id,
    String? venueId,
    String? title,
    String? description,
    String? discountType,
    double? discountValue,
    double? originalPrice,
    double? discountedPrice,
    DateTime? validFrom,
    DateTime? validUntil,
    int? maxCapacity,
    int? currentBookings,
    bool? isActive,
    List<String>? categories,
    List<String>? daysOfWeek,
    List<String>? timeSlots,
    String? imageUrl,
    Map<String, dynamic>? restrictions,
    bool? isPrayerTimeAware,
    bool? isHalalOnly,
  }) {
    return Deal(
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      title: title ?? this.title,
      description: description ?? this.description,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      originalPrice: originalPrice ?? this.originalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      validFrom: validFrom ?? this.validFrom,
      validUntil: validUntil ?? this.validUntil,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      currentBookings: currentBookings ?? this.currentBookings,
      isActive: isActive ?? this.isActive,
      categories: categories ?? this.categories,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      timeSlots: timeSlots ?? this.timeSlots,
      imageUrl: imageUrl ?? this.imageUrl,
      restrictions: restrictions ?? this.restrictions,
      isPrayerTimeAware: isPrayerTimeAware ?? this.isPrayerTimeAware,
      isHalalOnly: isHalalOnly ?? this.isHalalOnly,
    );
  }

  bool get isValid {
    final now = DateTime.now();
    return isActive &&
        now.isAfter(validFrom) &&
        now.isBefore(validUntil) &&
        currentBookings < maxCapacity;
  }

  bool get isExpired {
    return DateTime.now().isAfter(validUntil);
  }

  bool get isUpcoming {
    return DateTime.now().isBefore(validFrom);
  }

  int get availableSpots {
    return maxCapacity - currentBookings;
  }

  double get occupancyRate {
    return maxCapacity > 0 ? (currentBookings / maxCapacity) * 100 : 0;
  }

  String get discountDisplay {
    switch (discountType) {
      case 'percentage':
        return '${discountValue.toInt()}% OFF';
      case 'fixed_price':
        return '${discountedPrice.toInt()} MAD';
      case 'bogo':
        return 'Buy 1 Get 1 Free';
      case 'combo':
        return 'Special Combo';
      default:
        return '${discountValue.toInt()}% OFF';
    }
  }

  String get urgencyLevel {
    final now = DateTime.now();
    final timeLeft = validUntil.difference(now).inMinutes;

    if (timeLeft <= 30) {
      return 'urgent';
    } else if (timeLeft <= 120) {
      return 'moderate';
    } else {
      return 'low';
    }
  }

  String get timeLeftDisplay {
    final now = DateTime.now();
    final difference = validUntil.difference(now);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ${difference.inHours % 24}h left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ${difference.inMinutes % 60}m left';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m left';
    } else {
      return 'Expired';
    }
  }

  double get savingsAmount {
    return originalPrice - discountedPrice;
  }

  String get statusIcon {
    if (isExpired) return '⏰';
    if (isUpcoming) return '🔜';
    if (urgencyLevel == 'urgent') return '🚨';
    if (availableSpots <= 3) return '🔥';
    return '✨';
  }

  String get availabilityStatus {
    if (availableSpots == 0) {
      return 'Fully Booked';
    } else if (availableSpots <= 3) {
      return 'Almost Full';
    } else if (availableSpots <= maxCapacity * 0.3) {
      return 'Limited Spots';
    } else {
      return 'Available';
    }
  }
}
