import 'package:deadhour/backup/widgets/google_map_widget.dart';


import 'package:deadhour/utils/mock_data.dart';
import 'package:flutter/material.dart';

/// Map view widget for displaying deals and venues on Google Maps
class DealsMapView extends StatelessWidget {
  final List<dynamic> deals;
  final String? selectedCategory;
  final Function(dynamic) onDealTap;

  const DealsMapView({
    super.key,
    required this.deals,
    this.selectedCategory,
    required this.onDealTap,
  });

  @override
  Widget build(BuildContext context) {
    final venues = MockData.venues;
    
    return GoogleMapDealsWidget(
      deals: deals.cast<Deal>(),
      venues: venues,
      selectedCategory: selectedCategory == 'all' ? null : selectedCategory,
      onDealTap: (deal) => onDealTap(deal),
      onVenueTap: (venue) {
        // Find deals for this venue and show them
        final venueDeals = deals.where((d) => d.venueId == venue.id).toList();
        if (venueDeals.isNotEmpty) {
          onDealTap(venueDeals.first);
        }
      },
    );
  }
}