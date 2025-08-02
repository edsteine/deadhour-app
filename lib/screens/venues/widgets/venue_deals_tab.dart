import 'package:flutter/material.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/widgets/common/deal_card.dart';

class VenueDealsTab extends StatelessWidget {
  final dynamic venue;

  const VenueDealsTab({
    super.key,
    required this.venue,
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
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No deals available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Check back later for special offers',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: venueDeals.length,
      itemBuilder: (context, index) {
        final deal = venueDeals[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DealCard(deal: deal),
        );
      },
    );
  }
}