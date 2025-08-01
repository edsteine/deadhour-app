
import 'package:deadhour/utils/advanced_search_service.dart';



import 'package:deadhour/utils/mock_data.dart';

/// Service for venue discovery and location-based filtering
class VenueDiscoveryService {
  final AdvancedSearchService _advancedSearch = AdvancedSearchService();

  /// Get filtered venues based on discovery criteria
  List<Venue> getFilteredVenues({
    String? category,
    String? city,
    double maxDistance = 10.0,
    List<String> features = const [],
    String? priceRange,
    bool? openNow,
    String sortBy = 'rating',
    int limit = 50,
  }) {
    return _advancedSearch.multiFilterSearch(
      category: category != 'all' ? category : null,
      city: city != 'all' ? city : null,
      maxDistance: maxDistance,
      features: features,
      priceRange: priceRange != 'all' ? priceRange : null,
      openNow: openNow,
      sortBy: sortBy,
      limit: limit,
    );
  }

  /// Get nearby venues within a specific radius
  List<Venue> getNearbyVenues({
    double maxDistance = 5.0,
    int limit = 10,
    String sortBy = 'distance',
  }) {
    return _advancedSearch.multiFilterSearch(
      maxDistance: maxDistance,
      sortBy: sortBy,
      limit: limit,
    );
  }

  /// Get venues with active deals
  List<Venue> getVenuesWithDeals({
    String? category,
    String? city,
    double maxDistance = 10.0,
  }) {
    final venuesWithDeals = MockData.deals
        .where((deal) => deal.isValid)
        .map((deal) => deal.venueId)
        .toSet();

    final allVenues = getFilteredVenues(
      category: category,
      city: city,
      maxDistance: maxDistance,
    );

    return allVenues
        .where((venue) => venuesWithDeals.contains(venue.id))
        .toList();
  }

  /// Check if venue has active deals
  bool hasActiveDeals(String venueId) {
    return MockData.deals
        .where((deal) => deal.venueId == venueId && deal.isValid)
        .isNotEmpty;
  }

  /// Get venue discovery statistics
  Map<String, dynamic> getDiscoveryStats() {
    final allVenues = MockData.venues;
    final activeDeals = MockData.deals.where((deal) => deal.isValid).length;
    
    return {
      'totalVenues': allVenues.length,
      'activeDeals': activeDeals,
      'openVenues': allVenues.where((venue) => venue.isOpen).length,
      'verifiedVenues': allVenues.where((venue) => venue.isVerified).length,
      'halalVenues': allVenues.where((venue) => venue.isHalal).length,
      'categories': _getCategoryStats(allVenues),
      'cities': _getCityStats(allVenues),
    };
  }

  /// Get venues by category with quick stats
  Map<String, List<Venue>> getVenuesByCategory() {
    final venues = MockData.venues;
    final Map<String, List<Venue>> categoryMap = {};

    for (final venue in venues) {
      if (!categoryMap.containsKey(venue.category)) {
        categoryMap[venue.category] = [];
      }
      categoryMap[venue.category]!.add(venue);
    }

    return categoryMap;
  }

  /// Get popular venues based on rating and review count
  List<Venue> getPopularVenues({int limit = 10}) {
    return MockData.venues
        .where((venue) => venue.rating >= 4.0 && venue.reviewCount >= 50)
        .toList()
      ..sort((a, b) => (b.rating * b.reviewCount).compareTo(a.rating * a.reviewCount))
      ..take(limit);
  }

  /// Get trending venues based on recent activity
  List<Venue> getTrendingVenues({int limit = 10}) {
    // Mock trending logic - in real app this would use analytics
    return MockData.venues
        .where((venue) => venue.isVerified && venue.rating >= 3.5)
        .toList()
      ..shuffle()
      ..take(limit);
  }

  // Private helper methods
  Map<String, int> _getCategoryStats(List<Venue> venues) {
    final Map<String, int> stats = {};
    for (final venue in venues) {
      stats[venue.category] = (stats[venue.category] ?? 0) + 1;
    }
    return stats;
  }

  Map<String, int> _getCityStats(List<Venue> venues) {
    final Map<String, int> stats = {};
    for (final venue in venues) {
      stats[venue.city] = (stats[venue.city] ?? 0) + 1;
    }
    return stats;
  }
}