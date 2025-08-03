import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../../../models/venue.dart';

class VenueHeaderWidget extends StatelessWidget {
  final Venue venue;

  const VenueHeaderWidget({
    super.key,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppTheme.moroccoGreen,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          venue.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Venue image placeholder
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _getCategoryColor(venue.category),
                    _getCategoryColor(venue.category).withValues(alpha: 0.8),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  _getCategoryIcon(venue.category),
                  style: const TextStyle(fontSize: 80),
                ),
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Toggle bookmark
          },
          icon: const Icon(Icons.bookmark_border),
          tooltip: 'Bookmark',
        ),
        IconButton(
          onPressed: () {
            // Share venue
          },
          icon: const Icon(Icons.share),
          tooltip: 'Share',
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'restaurant':
        return Colors.orange;
      case 'cafe':
        return Colors.brown;
      case 'hotel':
        return Colors.blue;
      case 'entertainment':
        return Colors.purple;
      case 'shopping':
        return Colors.pink;
      case 'culture':
        return Colors.teal;
      default:
        return AppTheme.moroccoGreen;
    }
  }

  String _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'restaurant':
        return '🍽️';
      case 'cafe':
        return '☕';
      case 'hotel':
        return '🏨';
      case 'entertainment':
        return '🎭';
      case 'shopping':
        return '🛍️';
      case 'culture':
        return '🕌';
      default:
        return '📍';
    }
  }
}