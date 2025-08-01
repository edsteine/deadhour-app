import '../models/map_location.dart';

/// Service for managing map data and filtering locations
class MapDataService {
  // Mock nearby locations
  final List<MapLocation> _locations = [
    MapLocation(
      id: 'user',
      name: 'Your Location',
      lat: 33.5731,
      lng: -7.5898,
      type: MapLocationType.user,
      icon: '📍',
    ),
    MapLocation(
      id: 'cafe1',
      name: 'Café Atlas',
      lat: 33.5741,
      lng: -7.5888,
      type: MapLocationType.venue,
      icon: '☕',
      category: 'food',
      hasDeals: true,
      dealCount: 2,
    ),
    MapLocation(
      id: 'restaurant1',
      name: 'Restaurant Al-Fassia',
      lat: 33.5721,
      lng: -7.5908,
      type: MapLocationType.venue,
      icon: '🍽️',
      category: 'food',
      hasDeals: true,
      dealCount: 1,
    ),
    MapLocation(
      id: 'mosque1',
      name: 'Hassan II Mosque',
      lat: 33.6084,
      lng: -7.6325,
      type: MapLocationType.cultural,
      icon: '🕌',
      category: 'cultural',
    ),
    MapLocation(
      id: 'spa1',
      name: 'Royal Spa Casablanca',
      lat: 33.5751,
      lng: -7.5878,
      type: MapLocationType.venue,
      icon: '💆',
      category: 'wellness',
      hasDeals: true,
      dealCount: 3,
    ),
    MapLocation(
      id: 'entertainment1',
      name: 'Morocco Mall Cinema',
      lat: 33.5211,
      lng: -7.6901,
      type: MapLocationType.venue,
      icon: '🎬',
      category: 'entertainment',
      hasDeals: false,
    ),
  ];

  /// Get all locations
  List<MapLocation> getAllLocations() {
    return _locations;
  }

  /// Get filtered locations based on filter type
  List<MapLocation> getFilteredLocations(String filter) {
    if (filter == 'all') return _locations;
    if (filter == 'deals') {
      return _locations.where((loc) => loc.hasDeals == true).toList();
    }
    return _locations.where((loc) => loc.category == filter).toList();
  }

  /// Get available filter options
  List<Map<String, String>> getFilterOptions() {
    return [
      {'id': 'all', 'name': 'All', 'icon': '🗺️'},
      {'id': 'deals', 'name': 'Deals', 'icon': '🏷️'},
      {'id': 'food', 'name': 'Food', 'icon': '🍕'},
      {'id': 'entertainment', 'name': 'Fun', 'icon': '🎮'},
      {'id': 'wellness', 'name': 'Spa', 'icon': '💆'},
      {'id': 'cultural', 'name': 'Culture', 'icon': '🕌'},
    ];
  }
}