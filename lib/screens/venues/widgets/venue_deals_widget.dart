import 'package:flutter/material.dart';

import '../../../utils/mock_data.dart';
import '../../../utils/theme.dart';
import '../../deals/widgets/deal_card.dart';

/// Venue deals tab widget
class VenueDealsWidget extends StatelessWidget {
  final dynamic venue;
  final Function(dynamic) onDealTap;

  const VenueDealsWidget({
    super.key,
    required this.venue,
    required this.onDealTap,
  });

  @override
  Widget build(BuildContext context) {
    final venueDeals = MockData.deals
        .where((deal) => deal.venueId == venue.id)
        .toList();

    if (venueDeals.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_offer_outlined,
              size: 64,
              color: AppTheme.lightText,
            ),
            SizedBox(height: 16),
            Text(
              'No active deals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.secondaryText,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Check back later for great offers',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.lightText,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: venueDeals.length,
      itemBuilder: (context, index) {
        return DealCard(
          deal: venueDeals[index],
          onTap: () => onDealTap(venueDeals[index]),
        );
      },
    );
  }
}