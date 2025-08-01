class Venue {
  final String id;
  final String name;
  final String category;
  final String type;
  final String address;
  final String city;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String description;
  final String phone;
  final Map<String, String> operatingHours;
  final bool isHalal;
  final bool hasWifi;
  final bool acceptsCards;
  final String priceRange;
  final double latitude;
  final double longitude;
  final List<String> amenities;
  final List<String> images;
  final bool isVerified;
  final DateTime? joinedDate;
  final Map<String, dynamic>? businessMetrics;

  Venue({
    required this.id,
    required this.name,
    required this.category,
    required this.type,
    required this.address,
    required this.city,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.description,
    required this.phone,
    required this.operatingHours,
    this.isHalal = false,
    this.hasWifi = false,
    this.acceptsCards = false,
    this.priceRange = '€€',
    required this.latitude,
    required this.longitude,
    this.amenities = const [],
    this.images = const [],
    this.isVerified = false,
    this.joinedDate,
    this.businessMetrics,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      type: json['type'],
      address: json['address'],
      city: json['city'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      phone: json['phone'] ?? '',
      operatingHours: Map<String, String>.from(json['operatingHours'] ?? {}),
      isHalal: json['isHalal'] ?? false,
      hasWifi: json['hasWifi'] ?? false,
      acceptsCards: json['acceptsCards'] ?? false,
      priceRange: json['priceRange'] ?? '€€',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      amenities: List<String>.from(json['amenities'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      isVerified: json['isVerified'] ?? false,
      joinedDate: json['joinedDate'] != null
          ? DateTime.parse(json['joinedDate'])
          : null,
      businessMetrics: json['businessMetrics'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'type': type,
      'address': address,
      'city': city,
      'rating': rating,
      'reviewCount': reviewCount,
      'imageUrl': imageUrl,
      'description': description,
      'phone': phone,
      'operatingHours': operatingHours,
      'isHalal': isHalal,
      'hasWifi': hasWifi,
      'acceptsCards': acceptsCards,
      'priceRange': priceRange,
      'latitude': latitude,
      'longitude': longitude,
      'amenities': amenities,
      'images': images,
      'isVerified': isVerified,
      'joinedDate': joinedDate?.toIso8601String(),
      'businessMetrics': businessMetrics,
    };
  }

  Venue copyWith({
    String? id,
    String? name,
    String? category,
    String? type,
    String? address,
    String? city,
    double? rating,
    int? reviewCount,
    String? imageUrl,
    String? description,
    String? phone,
    Map<String, String>? operatingHours,
    bool? isHalal,
    bool? hasWifi,
    bool? acceptsCards,
    String? priceRange,
    double? latitude,
    double? longitude,
    List<String>? amenities,
    List<String>? images,
    bool? isVerified,
    DateTime? joinedDate,
    Map<String, dynamic>? businessMetrics,
  }) {
    return Venue(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      type: type ?? this.type,
      address: address ?? this.address,
      city: city ?? this.city,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      operatingHours: operatingHours ?? this.operatingHours,
      isHalal: isHalal ?? this.isHalal,
      hasWifi: hasWifi ?? this.hasWifi,
      acceptsCards: acceptsCards ?? this.acceptsCards,
      priceRange: priceRange ?? this.priceRange,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      amenities: amenities ?? this.amenities,
      images: images ?? this.images,
      isVerified: isVerified ?? this.isVerified,
      joinedDate: joinedDate ?? this.joinedDate,
      businessMetrics: businessMetrics ?? this.businessMetrics,
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
        return '🏢';
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
        return 'Other';
    }
  }

  bool get isOpen {
    final now = DateTime.now();
    final dayName = _getDayName(now.weekday);
    final hours = operatingHours[dayName];

    if (hours == null) return false;

    final parts = hours.split('-');
    if (parts.length != 2) return false;

    try {
      final openTime = _parseTime(parts[0]);
      final closeTime = _parseTime(parts[1]);
      final currentTime = now.hour * 60 + now.minute;

      return currentTime >= openTime && currentTime <= closeTime;
    } catch (e) {
      return false;
    }
  }

  String get openingStatus {
    if (isOpen) {
      return 'Open now';
    } else {
      return 'Closed';
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'monday';
      case 2:
        return 'tuesday';
      case 3:
        return 'wednesday';
      case 4:
        return 'thursday';
      case 5:
        return 'friday';
      case 6:
        return 'saturday';
      case 7:
        return 'sunday';
      default:
        return 'monday';
    }
  }

  int _parseTime(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  double distanceFrom(double lat, double lng) {
    // Simple distance calculation (for demo purposes)
    const double earthRadius = 6371; // km
    final double dLat = _toRadians(lat - latitude);
    final double dLng = _toRadians(lng - longitude);

    final double a = (dLat / 2) * (dLat / 2) +
        (dLng / 2) * (dLng / 2) * (latitude * latitude) * (lat * lat);

    final double c = 2 * (a * (1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degrees) {
    return degrees * (3.14159265359 / 180);
  }
}
