


/// Map location model for representing places on the map
class MapLocation {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final MapLocationType type;
  final String icon;
  final String? category;
  final bool? hasDeals;
  final int? dealCount;

  MapLocation({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.type,
    required this.icon,
    this.category,
    this.hasDeals,
    this.dealCount,
  });
}

