import 'dart:math';

import '../screens/venues/models/venue.dart';
import 'mock_data.dart';

/// Advanced search and filtering service for venues
/// Provides enhanced search capabilities, location-based discovery, and AI-powered recommendations
class AdvancedSearchService {
  static final AdvancedSearchService _instance = AdvancedSearchService._internal();
  factory AdvancedSearchService() => _instance;
  AdvancedSearchService._internal();

  // Search history for personalized recommendations
  final List<Map<String, dynamic>> _searchHistory = [
    {
      'query': 'halal restaurants',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'category': 'food',
      'location': 'Casablanca',
    },
    {
      'query': 'study cafe wifi',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      'category': 'entertainment',
      'filters': ['wifi', 'quiet'],
    },
  ];

  // User preferences for AI recommendations
  final Map<String, dynamic> _userPreferences = {
    'preferredCategories': ['food', 'entertainment'],
    'preferredFeatures': ['wifi', 'halal', 'parking'],
    'priceRange': 'mid',
    'preferredTimes': ['14:00-16:00', '20:00-22:00'],
    'preferredCities': ['Casablanca', 'Rabat'],
    'socialPreference': 'community_validated', // prefers venues with community validation
  };

  // Location data for distance calculations
  final Map<String, Map<String, double>> _venueLocations = {
    'venue_1': {'lat': 33.5731, 'lng': -7.5898}, // Casablanca
    'venue_2': {'lat': 34.0209, 'lng': -6.8416}, // Rabat
    'venue_3': {'lat': 33.5731, 'lng': -7.5898}, // Casablanca
  };

  final Map<String, double> _currentUserLocation = {'lat': 33.5731, 'lng': -7.5898}; // Mock user location

  /// Advanced text search with fuzzy matching and relevance scoring
  List<Venue> advancedTextSearch(String query, {int limit = 20}) {
    if (query.isEmpty) return MockData.venues.take(limit).toList();

    final venues = MockData.venues.toList();
    final searchResults = <Map<String, dynamic>>[];

    for (final venue in venues) {
      double relevanceScore = 0.0;

      // Name matching (highest weight)
      relevanceScore += _calculateTextRelevance(venue.name, query) * 3.0;
      
      // Category matching
      relevanceScore += _calculateTextRelevance(venue.categoryName, query) * 2.0;
      
      // Description matching
      relevanceScore += _calculateTextRelevance(venue.description, query) * 1.5;
      
      // Location matching
      relevanceScore += _calculateTextRelevance(venue.address, query) * 1.0;
      relevanceScore += _calculateTextRelevance(venue.city, query) * 1.0;

      // Feature matching (e.g., "wifi", "halal", "parking")
      if (venue.hasWifi && query.toLowerCase().contains('wifi')) relevanceScore += 2.0;
      if (venue.isHalal && query.toLowerCase().contains('halal')) relevanceScore += 2.0;
      if (venue.acceptsCards && query.toLowerCase().contains('card')) relevanceScore += 1.0;

      // Deal matching
      if (query.toLowerCase().contains('deal') || query.toLowerCase().contains('discount')) {
        final hasDeals = MockData.deals.any((deal) => deal.venueId == venue.id && deal.isValid);
        if (hasDeals) relevanceScore += 2.5;
      }

      if (relevanceScore > 0) {
        searchResults.add({
          'venue': venue,
          'score': relevanceScore,
        });
      }
    }

    // Sort by relevance score
    searchResults.sort((a, b) => b['score'].compareTo(a['score']));
    
    // Track search for personalization
    _trackSearch(query);

    return searchResults
        .take(limit)
        .map((result) => result['venue'] as Venue)
        .toList();
  }

  /// Location-based venue discovery with distance calculation
  List<Venue> locationBasedSearch({
    double? lat,
    double? lng,
    double radiusKm = 10.0,
    String? category,
    int limit = 20,
  }) {
    final userLat = lat ?? _currentUserLocation['lat']!;
    final userLng = lng ?? _currentUserLocation['lng']!;
    
    final venues = MockData.venues.toList();
    final locationResults = <Map<String, dynamic>>[];

    for (final venue in venues) {
      // Filter by category if specified
      if (category != null && venue.category != category) continue;

      final venueLoc = _venueLocations[venue.id];
      if (venueLoc == null) continue;

      final distance = _calculateDistance(
        userLat, userLng, 
        venueLoc['lat']!, venueLoc['lng']!
      );

      if (distance <= radiusKm) {
        // Calculate location relevance score
        double locationScore = (radiusKm - distance) / radiusKm * 100;
        
        // Boost score for popular venues
        locationScore += venue.rating * 10;
        
        // Boost score for venues with active deals
        final hasDeals = MockData.deals.any((deal) => deal.venueId == venue.id && deal.isValid);
        if (hasDeals) locationScore += 20;

        locationResults.add({
          'venue': venue,
          'distance': distance,
          'score': locationScore,
        });
      }
    }

    // Sort by location score
    locationResults.sort((a, b) => b['score'].compareTo(a['score']));

    return locationResults
        .take(limit)
        .map((result) => result['venue'] as Venue)
        .toList();
  }

  /// AI-powered venue recommendations based on user preferences and behavior
  List<Venue> getAIRecommendations({int limit = 10}) {
    final venues = MockData.venues.toList();
    final recommendations = <Map<String, dynamic>>[];

    for (final venue in venues) {
      double aiScore = 0.0;

      // Category preference matching
      if (_userPreferences['preferredCategories'].contains(venue.category)) {
        aiScore += 30.0;
      }

      // Feature preference matching
      for (final feature in _userPreferences['preferredFeatures']) {
        switch (feature) {
          case 'wifi':
            if (venue.hasWifi) aiScore += 15.0;
            break;
          case 'halal':
            if (venue.isHalal) aiScore += 15.0;
            break;
          case 'parking':
            aiScore += 10.0; // Assume all venues have parking info
            break;
          case 'cards':
            if (venue.acceptsCards) aiScore += 10.0;
            break;
        }
      }

      // Price range matching
      final pricePreference = _userPreferences['priceRange'];
      if (pricePreference == 'low' && venue.priceRange == '€') aiScore += 20.0;
      if (pricePreference == 'mid' && venue.priceRange == '€€') aiScore += 20.0;
      if (pricePreference == 'high' && venue.priceRange == '€€€') aiScore += 20.0;

      // Location preference
      if (_userPreferences['preferredCities'].contains(venue.city)) {
        aiScore += 25.0;
      }

      // Rating bonus
      aiScore += venue.rating * 8;

      // Social validation bonus (if user prefers community validated venues)
      if (_userPreferences['socialPreference'] == 'community_validated') {
        if (venue.reviewCount > 50) aiScore += 15.0;
        if (venue.rating > 4.0) aiScore += 10.0;
      }

      // Search history relevance
      aiScore += _calculateHistoryRelevance(venue) * 20.0;

      // Time-based relevance (boost venues that are good for current time)
      aiScore += _calculateTimeRelevance(venue) * 10.0;

      // Diversity factor to avoid showing too similar venues
      aiScore += _calculateDiversityBonus(venue, recommendations) * 5.0;

      recommendations.add({
        'venue': venue,
        'aiScore': aiScore,
        'reasons': _generateRecommendationReasons(venue, aiScore),
      });
    }

    // Sort by AI score
    recommendations.sort((a, b) => b['aiScore'].compareTo(a['aiScore']));

    return recommendations
        .take(limit)
        .map((result) => result['venue'] as Venue)
        .toList();
  }

  /// Multi-filter venue search with advanced filtering options
  List<Venue> multiFilterSearch({
    String? query,
    String? category,
    String? city,
    double? minRating,
    double? maxDistance,
    List<String>? features,
    String? priceRange,
    bool? hasDeals,
    bool? openNow,
    String? sortBy = 'relevance',
    int limit = 20,
  }) {
    var venues = MockData.venues.toList();
    final searchResults = <Map<String, dynamic>>[];

    for (final venue in venues) {
      bool matches = true;
      double filterScore = 0.0;

      // Text search filter
      if (query != null && query.isNotEmpty) {
        final textRelevance = _calculateTextRelevance('${venue.name} ${venue.description}', query);
        if (textRelevance == 0) matches = false;
        filterScore += textRelevance * 30.0;
      }

      // Category filter
      if (category != null && category != 'all' && venue.category != category) {
        matches = false;
      }

      // City filter
      if (city != null && city != 'all' && venue.city != city) {
        matches = false;
      }

      // Rating filter
      if (minRating != null && venue.rating < minRating) {
        matches = false;
      }

      // Distance filter
      if (maxDistance != null) {
        final venueLoc = _venueLocations[venue.id];
        if (venueLoc != null) {
          final distance = _calculateDistance(
            _currentUserLocation['lat']!, _currentUserLocation['lng']!,
            venueLoc['lat']!, venueLoc['lng']!
          );
          if (distance > maxDistance) matches = false;
          filterScore += (maxDistance - distance) / maxDistance * 20.0;
        }
      }

      // Features filter
      if (features != null && features.isNotEmpty) {
        for (final feature in features) {
          switch (feature) {
            case 'wifi':
              if (!venue.hasWifi) matches = false;
              break;
            case 'halal':
              if (!venue.isHalal) matches = false;
              break;
            case 'cards':
              if (!venue.acceptsCards) matches = false;
              break;
            case 'verified':
              if (!venue.isVerified) matches = false;
              break;
          }
        }
        if (matches) filterScore += features.length * 10.0;
      }

      // Price range filter
      if (priceRange != null && priceRange != 'all' && venue.priceRange != priceRange) {
        matches = false;
      }

      // Deals filter
      if (hasDeals == true) {
        final venueHasDeals = MockData.deals.any((deal) => deal.venueId == venue.id && deal.isValid);
        if (!venueHasDeals) matches = false;
        if (venueHasDeals) filterScore += 25.0;
      }

      // Open now filter
      if (openNow == true && !venue.isOpen) {
        matches = false;
      }

      if (matches) {
        // Base score from venue quality
        filterScore += venue.rating * 15.0;
        filterScore += venue.reviewCount * 0.1;

        searchResults.add({
          'venue': venue,
          'score': filterScore,
        });
      }
    }

    // Sort based on sortBy parameter
    switch (sortBy) {
      case 'rating':
        searchResults.sort((a, b) => (b['venue'] as Venue).rating.compareTo((a['venue'] as Venue).rating));
        break;
      case 'distance':
        // Would sort by distance if location data available
        searchResults.sort((a, b) => b['score'].compareTo(a['score']));
        break;
      case 'newest':
        // Would sort by creation date if available
        searchResults.sort((a, b) => b['score'].compareTo(a['score']));
        break;
      case 'relevance':
      default:
        searchResults.sort((a, b) => b['score'].compareTo(a['score']));
        break;
    }

    return searchResults
        .take(limit)
        .map((result) => result['venue'] as Venue)
        .toList();
  }

  /// Get search suggestions based on partial query
  List<String> getSearchSuggestions(String partialQuery) {
    if (partialQuery.length < 2) return [];

    final suggestions = <String>[];
    final query = partialQuery.toLowerCase();

    // Venue name suggestions
    for (final venue in MockData.venues) {
      if (venue.name.toLowerCase().contains(query)) {
        suggestions.add(venue.name);
      }
    }

    // Category suggestions
    final categories = ['Restaurant', 'Café', 'Spa', 'Entertainment', 'Sports'];
    for (final category in categories) {
      if (category.toLowerCase().contains(query)) {
        suggestions.add(category);
      }
    }

    // Feature suggestions
    final features = ['Halal', 'WiFi', 'Parking', 'Family Friendly', 'Study Friendly'];
    for (final feature in features) {
      if (feature.toLowerCase().contains(query)) {
        suggestions.add(feature);
      }
    }

    // Location suggestions
    final locations = ['Casablanca', 'Rabat', 'Marrakech', 'Fes', 'Agadir'];
    for (final location in locations) {
      if (location.toLowerCase().contains(query)) {
        suggestions.add('Near $location');
      }
    }

    // Popular searches from history
    for (final search in _searchHistory) {
      if (search['query'].toLowerCase().contains(query)) {
        suggestions.add(search['query']);
      }
    }

    // Remove duplicates and limit
    return suggestions.toSet().take(8).toList();
  }

  /// Get trending searches and popular filters
  Map<String, dynamic> getTrendingSearchData() {
    return {
      'trendingQueries': [
        'halal restaurants casablanca',
        'study cafe wifi',
        'family friendly entertainment',
        'traditional moroccan food',
        'rooftop restaurants',
      ],
      'popularFilters': [
        {'name': 'Halal', 'count': 234},
        {'name': 'WiFi', 'count': 189},
        {'name': 'Parking', 'count': 156},
        {'name': 'Family Friendly', 'count': 134},
        {'name': 'Active Deals', 'count': 98},
      ],
      'popularCategories': [
        {'name': 'Food & Dining', 'count': 456},
        {'name': 'Entertainment', 'count': 234},
        {'name': 'Wellness', 'count': 123},
        {'name': 'Sports', 'count': 89},
      ],
    };
  }

  // Helper methods

  double _calculateTextRelevance(String text, String query) {
    if (text.isEmpty || query.isEmpty) return 0.0;
    
    final textLower = text.toLowerCase();
    final queryLower = query.toLowerCase();
    
    // Exact match bonus
    if (textLower.contains(queryLower)) return 1.0;
    
    // Word matching
    final queryWords = queryLower.split(' ');
    final textWords = textLower.split(' ');
    
    int matches = 0;
    for (final queryWord in queryWords) {
      for (final textWord in textWords) {
        if (textWord.contains(queryWord) || queryWord.contains(textWord)) {
          matches++;
          break;
        }
      }
    }
    
    return matches / queryWords.length;
  }

  double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    // Haversine formula for distance calculation
    const double earthRadius = 6371; // km
    
    final dLat = _degreesToRadians(lat2 - lat1);
    final dLng = _degreesToRadians(lng2 - lng1);
    
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
        sin(dLng / 2) * sin(dLng / 2);
    
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  void _trackSearch(String query) {
    _searchHistory.insert(0, {
      'query': query,
      'timestamp': DateTime.now(),
    });
    
    // Keep only recent searches
    if (_searchHistory.length > 50) {
      _searchHistory.removeRange(50, _searchHistory.length);
    }
  }

  double _calculateHistoryRelevance(Venue venue) {
    double relevance = 0.0;
    
    for (final search in _searchHistory.take(10)) {
      final query = search['query'] as String;
      relevance += _calculateTextRelevance('${venue.name} ${venue.description}', query);
    }
    
    return relevance / min(_searchHistory.length, 10);
  }

  double _calculateTimeRelevance(Venue venue) {
    final now = DateTime.now();
    final hour = now.hour;
    
    // Boost food venues during meal times
    if (venue.category == 'food') {
      if ((hour >= 12 && hour <= 14) || (hour >= 19 && hour <= 21)) {
        return 1.0;
      }
    }
    
    // Boost entertainment venues during evening
    if (venue.category == 'entertainment') {
      if (hour >= 18 && hour <= 23) {
        return 1.0;
      }
    }
    
    return 0.5; // Default moderate relevance
  }

  double _calculateDiversityBonus(Venue venue, List<Map<String, dynamic>> existingRecommendations) {
    if (existingRecommendations.isEmpty) return 1.0;
    
    // Count how many recommendations are from the same category
    final sameCategory = existingRecommendations
        .where((rec) => (rec['venue'] as Venue).category == venue.category)
        .length;
    
    // Reduce bonus if too many from same category
    return max(0.0, 1.0 - (sameCategory * 0.2));
  }

  List<String> _generateRecommendationReasons(Venue venue, double score) {
    final reasons = <String>[];
    
    if (_userPreferences['preferredCategories'].contains(venue.category)) {
      reasons.add('Matches your preferred category');
    }
    
    if (venue.rating > 4.0) {
      reasons.add('Highly rated by community');
    }
    
    if (venue.isHalal && _userPreferences['preferredFeatures'].contains('halal')) {
      reasons.add('Halal certified');
    }
    
    if (venue.hasWifi && _userPreferences['preferredFeatures'].contains('wifi')) {
      reasons.add('Has WiFi');
    }
    
    final hasDeals = MockData.deals.any((deal) => deal.venueId == venue.id && deal.isValid);
    if (hasDeals) {
      reasons.add('Current deals available');
    }
    
    return reasons.take(3).toList();
  }
}