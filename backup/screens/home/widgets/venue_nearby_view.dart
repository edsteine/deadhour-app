import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../../../models/venue.dart';
import '../../../routes/app_routes.dart';

class VenueNearbyView extends StatelessWidget {
  final List<Venue> venues;

  const VenueNearbyView({
    super.key,
    required this.venues,
  });

  @override
  Widget build(BuildContext context) {
    final nearbyVenues = venues.take(5).toList();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.moroccoGreen, AppTheme.moroccoGold],
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Venues Near You',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Based on your current location',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: nearbyVenues.length,
            itemBuilder: (context, index) {
              final venue = nearbyVenues[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(venue.imageUrl),
                  ),
                  title: Text(venue.name),
                  subtitle: Text('${venue.categoryName} • ${venue.city}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          Text('${venue.rating}'),
                        ],
                      ),
                      const Text('2.3 km', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  onTap: () => AppNavigation.goToVenueDetail(context, venue.id),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}