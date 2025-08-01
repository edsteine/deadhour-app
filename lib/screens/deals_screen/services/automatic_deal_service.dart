import 'dart:async';
import 'package:deadhour/utils/mock_data.dart';

/// Service for automatic deal application and price tracking
/// Similar to Honey's auto-coupon system but for dead hours deals
class AutomaticDealService {
  static final AutomaticDealService _instance = AutomaticDealService._internal();
  factory AutomaticDealService() => _instance;
  AutomaticDealService._internal();

  // Track active price monitoring
  final Map<String, StreamController<Map<String, dynamic>>> _priceStreams = {};
  final Map<String, double> _trackedPrices = {};
  final Set<String> _autoApplyEnabled = {};

  /// Enable automatic deal application for a venue
  void enableAutoApply(String venueId) {
    _autoApplyEnabled.add(venueId);
  }

  /// Disable automatic deal application for a venue
  void disableAutoApply(String venueId) {
    _autoApplyEnabled.remove(venueId);
  }

  /// Check if auto-apply is enabled for a venue
  bool isAutoApplyEnabled(String venueId) {
    return _autoApplyEnabled.contains(venueId);
  }

  /// Automatically find and apply best available deal
  Map<String, dynamic>? findBestDeal(String venueId) {
    final venues = MockData.venues;
    final venue = venues.where((v) => v.id == venueId).firstOrNull;

    if (venue == null) return null;

    // Get all active deals for this venue
    final deals = MockData.deals.where((deal) => 
      deal.venueId == venueId && 
      deal.isValid == true
    ).toList();

    if (deals.isEmpty) return null;

    // Find best deal (highest discount percentage)
    deals.sort((a, b) {
      final discountA = _extractDiscountPercentage(a.title);
      final discountB = _extractDiscountPercentage(b.title);
      return discountB.compareTo(discountA);
    });

    final bestDeal = deals.first;
    return {
      'id': bestDeal.id,
      'title': bestDeal.title,
      'description': bestDeal.description,
      'venueId': bestDeal.venueId,
      'originalPrice': bestDeal.originalPrice,
      'discountedPrice': bestDeal.discountedPrice,
      'discountValue': bestDeal.discountValue,
      'isValid': bestDeal.isValid,
    };
  }

  /// Extract discount percentage from deal title
  int _extractDiscountPercentage(String title) {
    final regex = RegExp(r'(\d+)%');
    final match = regex.firstMatch(title);
    if (match != null) {
      return int.tryParse(match.group(1) ?? '0') ?? 0;
    }
    return 0;
  }

  /// Start price tracking for a deal
  Stream<Map<String, dynamic>> trackPriceDrops(String dealId) {
    if (_priceStreams.containsKey(dealId)) {
      return _priceStreams[dealId]!.stream;
    }

    final controller = StreamController<Map<String, dynamic>>.broadcast();
    _priceStreams[dealId] = controller;

    // Simulate price tracking with periodic updates
    Timer.periodic(const Duration(minutes: 30), (timer) {
      if (!_priceStreams.containsKey(dealId)) {
        timer.cancel();
        return;
      }

      final deal = MockData.deals.where((d) => d.id == dealId).firstOrNull;

      if (deal == null) {
        timer.cancel();
        controller.close();
        _priceStreams.remove(dealId);
        return;
      }

      // Simulate price changes (in real app, this would call API)
      final currentPrice = deal.originalPrice;
      final currentDiscount = _extractDiscountPercentage(deal.title);
      
      // Check if there's a better deal available
      final betterDeal = _findBetterDeal(dealId, currentDiscount);
      
      if (betterDeal != null) {
        controller.add({
          'type': 'price_drop',
          'dealId': dealId,
          'oldDiscount': currentDiscount,
          'newDiscount': _extractDiscountPercentage(betterDeal['title'] ?? ''),
          'savings': _calculateSavings(currentPrice, currentDiscount, betterDeal),
          'deal': betterDeal,
        });
      }
    });

    return controller.stream;
  }

  /// Find a better deal for the same venue
  Map<String, dynamic>? _findBetterDeal(String currentDealId, int currentDiscount) {
    final currentDeal = MockData.deals.where((d) => d.id == currentDealId).firstOrNull;

    if (currentDeal == null) return null;

    final venueId = currentDeal.venueId;
    
    // Find all deals for the same venue
    final venuDeals = MockData.deals.where((deal) => 
      deal.venueId == venueId && 
      deal.id != currentDealId &&
      deal.isValid == true
    ).toList();

    // Find deals with better discount
    for (final deal in venuDeals) {
      final discount = _extractDiscountPercentage(deal.title);
      if (discount > currentDiscount) {
        return {
          'id': deal.id,
          'title': deal.title,
          'description': deal.description,
          'venueId': deal.venueId,
          'originalPrice': deal.originalPrice,
          'discountedPrice': deal.discountedPrice,
          'discountValue': deal.discountValue,
          'isValid': deal.isValid,
        };
      }
    }

    return null;
  }

  /// Calculate savings between deals
  double _calculateSavings(double originalPrice, int oldDiscount, Map<String, dynamic> newDeal) {
    final newDiscount = _extractDiscountPercentage(newDeal['title'] ?? '');
    final oldSavings = originalPrice * (oldDiscount / 100);
    final newSavings = originalPrice * (newDiscount / 100);
    return newSavings - oldSavings;
  }

  /// Stop price tracking for a deal
  void stopPriceTracking(String dealId) {
    if (_priceStreams.containsKey(dealId)) {
      _priceStreams[dealId]!.close();
      _priceStreams.remove(dealId);
    }
    _trackedPrices.remove(dealId);
  }

  /// Get all venues with auto-apply enabled
  Set<String> getAutoApplyVenues() {
    return Set.from(_autoApplyEnabled);
  }

  /// Get all tracked deals
  Set<String> getTrackedDeals() {
    return _priceStreams.keys.toSet();
  }

  /// Apply deal automatically if auto-apply is enabled
  Map<String, dynamic>? autoApplyBestDeal(String venueId) {
    if (!isAutoApplyEnabled(venueId)) return null;
    
    final bestDeal = findBestDeal(venueId);
    if (bestDeal == null) return null;

    // In real app, this would automatically apply the deal
    return {
      'applied': true,
      'deal': bestDeal,
      'savings': _calculateDealSavings(bestDeal),
      'appliedAt': DateTime.now().toIso8601String(),
    };
  }

  /// Calculate savings from a deal
  double _calculateDealSavings(Map<String, dynamic> deal) {
    final originalPrice = deal['originalPrice'] as double;
    final discount = _extractDiscountPercentage(deal['title'] ?? '');
    return originalPrice * (discount / 100);
  }

  /// Dispose all resources
  void dispose() {
    for (final controller in _priceStreams.values) {
      controller.close();
    }
    _priceStreams.clear();
    _trackedPrices.clear();
  }
}