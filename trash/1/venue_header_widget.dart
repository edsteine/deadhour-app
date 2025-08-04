import 'package:flutter/material.dart';
import '../../../utils/theme.dart';


/// Hero header section with venue image, name, rating, and action buttons
class VenueHeaderWidget extends StatelessWidget {
  final dynamic venue;
  final bool isBookmarked;
  final VoidCallback onBookmarkToggle;
  final VoidCallback onShare;
  final VoidCallback onCall;
  final VoidCallback onDirections;
  final VoidCallback onBook;

  const VenueHeaderWidget({
    super.key,
    required this.venue,
    required this.isBookmarked,
    required this.onBookmarkToggle,
    required this.onShare,
    required this.onCall,
    required this.onDirections,
    required this.onBook,
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
            Container(
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
          onPressed: onBookmarkToggle,
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: onShare,
          icon: const Icon(Icons.share, color: Colors.white),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'food':
        return AppColors.foodCategory;
      case 'entertainment':
        return AppColors.entertainmentCategory;
      case 'wellness':
        return AppColors.wellnessCategory;
      case 'sports':
        return AppColors.sportsCategory;
      default:
        return AppTheme.moroccoGreen;
    }
  }

  String _getCategoryIcon(String category) {
    switch (category) {
      case 'food':
        return '🍕';
      case 'entertainment':
        return '🎮';
      case 'wellness':
        return '💆';
      case 'sports':
        return '⚽';
      default:
        return '🏪';
    }
  }
}

