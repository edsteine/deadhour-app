
import 'package:flutter/material.dart';




/// Venue list view widget showing venues as cards
class VenueListViewWidget extends StatelessWidget {
  final List<Venue> venues;
  final bool showCommunityActivity;
  final SocialValidationService socialValidation;
  final VisualContentService visualContent;

  const VenueListViewWidget({
    super.key,
    required this.venues,
    required this.showCommunityActivity,
    required this.socialValidation,
    required this.visualContent,
  });

  @override
  Widget build(BuildContext context) {
    if (venues.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: venues.length,
      itemBuilder: (context, index) {
        return VenueCardWidget(
          venue: venues[index],
          socialValidation: socialValidation,
          visualContent: visualContent,
          showCommunityActivity: showCommunityActivity,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No venues found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your filters or search criteria',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}