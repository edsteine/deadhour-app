import '../../widgets/google_map_widget.dart';

import '../../deals/models/deal.dart';
import '../models/venue.dart';
import 'package:flutter/material.dart';
import '../../../utils/mock_data.dart';

/// Map view widget for venue discovery with deals visualization
class VenueDiscoveryMapWidget extends StatelessWidget {
  final List<Venue> venues;
  final String? selectedCategory;
  final Function(Venue) onVenueTap;
  final Function(Deal) onDealTap;

  const VenueDiscoveryMapWidget({
    super.key,
    required this.venues,
    this.selectedCategory,
    required this.onVenueTap,
    required this.onDealTap,
  });

  @override
  Widget build(BuildContext context) {
    final deals = MockData.deals.where((deal) => deal.isValid).toList();
    
    return GoogleMapDealsWidget(
      venues: venues,
      deals: deals.cast<Deal>(),
      selectedCategory: selectedCategory,
      showVenues: true,
      showDeals: true,
      showUserLocation: true,
      onVenueTap: onVenueTap,
      onDealTap: onDealTap,
    );
  }
}