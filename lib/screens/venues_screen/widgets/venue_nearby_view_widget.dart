
import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Nearby venues view widget with location-based display
class VenueNearbyViewWidget extends StatelessWidget {
  final List<Venue> venues;
  final Function(Venue) onVenueTap;

  const VenueNearbyViewWidget({
    super.key,
    required this.venues,
    required this.onVenueTap,
  });

  @override
  Widget build(BuildContext context) {
    final nearbyVenues = venues.take(5).toList();

    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: _buildVenuesList(nearbyVenues),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
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
    );
  }

  Widget _buildVenuesList(List<Venue> nearbyVenues) {
    if (nearbyVenues.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No nearby venues found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Try expanding your search radius',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: nearbyVenues.length,
      itemBuilder: (context, index) {
        final venue = nearbyVenues[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(venue.imageUrl),
              backgroundColor: Colors.grey[300],
              onBackgroundImageError: (exception, stackTrace) {
                // Handle image loading error
              },
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
            onTap: () => onVenueTap(venue),
          ),
        );
      },
    );
  }
}