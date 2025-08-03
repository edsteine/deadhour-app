import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../../../utils/mock_data.dart';
import '../../../models/venue.dart';
import '../../../routes/app_routes.dart';
import '../../../services/social_validation_service.dart';

class VenueCardWidget extends StatelessWidget {
  final Venue venue;
  final bool showCommunityActivity;
  final SocialValidationService socialValidation;
  final VoidCallback onViewDetails;
  final VoidCallback onBook;
  final VoidCallback onShowGroupBooking;

  const VenueCardWidget({
    super.key,
    required this.venue,
    required this.showCommunityActivity,
    required this.socialValidation,
    required this.onViewDetails,
    required this.onBook,
    required this.onShowGroupBooking,
  });

  @override
  Widget build(BuildContext context) {
    final hasActiveDeals = MockData.deals
        .where((deal) => deal.venueId == venue.id && deal.isValid)
        .isNotEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => AppNavigation.goToVenueDetail(context, venue.id),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    venue.imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 160,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 50),
                    ),
                  ),
                ),
                if (hasActiveDeals)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'DEAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: venue.isOpen ? Colors.green : Colors.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      venue.openingStatus,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(venue.categoryIcon,
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              venue.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              venue.categoryName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.moroccoGreen,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 16, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                '${venue.rating}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Text(
                            '${venue.reviewCount} reviews',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${venue.address}, ${venue.city}',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        venue.priceRange,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.moroccoGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    venue.description,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      if (venue.isHalal)
                        _buildAmenityChip('Halal', Icons.restaurant),
                      if (venue.hasWifi) _buildAmenityChip('WiFi', Icons.wifi),
                      if (venue.acceptsCards)
                        _buildAmenityChip('Cards', Icons.credit_card),
                      if (venue.isVerified)
                        _buildAmenityChip('Verified', Icons.verified),
                    ],
                  ),
                  // Community activity indicators
                  if (showCommunityActivity) ...[
                    const SizedBox(height: 8),
                    _buildCommunityActivity(),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onViewDetails,
                          icon: const Icon(Icons.info, size: 16),
                          label: const Text('Details'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildBookingButton(hasActiveDeals),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityActivity() {
    final socialProof = socialValidation.getSocialProofSummary(venue.id);
    final socialWidgets = socialValidation.getSocialProofWidgets(venue.id);
    final trustIndicators = socialValidation.getTrustIndicators(venue.id);
    final checkIns = socialValidation.getVenueCheckIns(venue.id);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.moroccoGreen.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with trust level
          Row(
            children: [
              const Icon(
                Icons.group,
                size: 16,
                color: AppTheme.moroccoGreen,
              ),
              const SizedBox(width: 4),
              const Text(
                'Community Validation',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.moroccoGreen,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getTrustLevelColor(trustIndicators['trustLevel']),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  trustIndicators['trustLevel'],
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Social proof widgets
          if (socialWidgets.isNotEmpty) ...[
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: socialWidgets.take(2).map((widget) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getWidgetColor(widget['color']).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getWidgetColor(widget['color']).withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  widget['title'],
                  style: TextStyle(
                    fontSize: 10,
                    color: _getWidgetColor(widget['color']),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 6),
          ],
          
          // Friend recommendations indicator
          if (socialProof['friendCheckIns'] > 0) ...[
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 12,
                  color: Colors.green.shade600,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${socialProof['friendNames'].take(2).join(', ')} visited recently',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
          
          // Recent activity or community tags
          if (checkIns.isNotEmpty) ...[
            Row(
              children: [
                const Icon(
                  Icons.chat_bubble_outline,
                  size: 12,
                  color: AppTheme.secondaryText,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '"${checkIns.first['comment']}"',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.secondaryText,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ] else if (socialProof['communityTags'].isNotEmpty) ...[
            Row(
              children: [
                const Icon(
                  Icons.tag,
                  size: 12,
                  color: AppTheme.secondaryText,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    socialProof['communityTags'].take(3).join(', '),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.secondaryText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Color _getTrustLevelColor(String? trustLevel) {
    switch (trustLevel) {
      case 'Highly Trusted':
        return Colors.green;
      case 'Community Trusted':
        return Colors.blue;
      case 'Moderately Trusted':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getWidgetColor(String color) {
    switch (color) {
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      case 'purple':
        return Colors.purple;
      default:
        return AppTheme.moroccoGreen;
    }
  }

  Widget _buildBookingButton(bool hasActiveDeals) {
    // Check if venue is good for groups (mock logic)
    final isGroupFriendly = venue.category == 'food' || venue.category == 'entertainment';
    final groupDiscount = isGroupFriendly ? '10% off for 6+ people' : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: onBook,
          icon: const Icon(Icons.book_online, size: 16),
          label: Text(hasActiveDeals ? 'Book Deal' : 'Book Now'),
          style: ElevatedButton.styleFrom(
            backgroundColor: hasActiveDeals ? Colors.red : AppTheme.moroccoGreen,
            foregroundColor: Colors.white,
          ),
        ),
        if (isGroupFriendly && groupDiscount != null) ...[
          const SizedBox(height: 4),
          GestureDetector(
            onTap: onShowGroupBooking,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.group, size: 12, color: Colors.orange.shade700),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      groupDiscount,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAmenityChip(String label, IconData icon) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 10)),
        ],
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}