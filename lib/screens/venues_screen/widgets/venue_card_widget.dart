import 'package:deadhour/utils/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';
import 'package:deadhour/utils/app_colors.dart';

import 'package:deadhour/utils/mock_data.dart';




/// Individual venue card widget with comprehensive venue information
class VenueCardWidget extends StatelessWidget {
  final Venue venue;
  final SocialValidationService socialValidation;
  final VisualContentService visualContent;
  final bool showCommunityActivity;
  final VoidCallback? onTap;

  const VenueCardWidget({
    super.key,
    required this.venue,
    required this.socialValidation,
    required this.visualContent,
    this.showCommunityActivity = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasActiveDeals = MockData.deals
        .where((deal) => deal.venueId == venue.id && deal.isValid)
        .isNotEmpty;
    
    // Get visual content for this venue
    final venueActivity = visualContent.getVenueActivity(venue.id);
    final checkInStories = visualContent.getCheckInStories(venue.id);
    final venueEvents = visualContent.getVenueEvents(venue.id);
    final recentPhotos = visualContent.getVenuePhotos(venue.id).take(3).toList();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap ?? () => AppNavigation.goToVenueDetail(context, venue.id),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVenueImage(hasActiveDeals, recentPhotos, venueEvents, venueActivity),
            _buildVenueDetails(context, hasActiveDeals, venueEvents, checkInStories, recentPhotos, venueActivity),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueImage(bool hasActiveDeals, List<dynamic> recentPhotos, List<dynamic> venueEvents, dynamic venueActivity) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
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
        // Visual content indicators overlay
        if (recentPhotos.isNotEmpty)
          Positioned(
            bottom: 8,
            left: 8,
            child: _buildPhotoIndicator(recentPhotos.length),
          ),
        if (venueEvents.isNotEmpty)
          Positioned(
            bottom: 8,
            right: 8,
            child: _buildEventIndicator(venueEvents.first),
          ),
        if (hasActiveDeals)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
          child: _buildVenueStatusIndicator(venue, venueActivity),
        ),
        // Buzz level indicator
        Positioned(
          top: 36,
          right: 8,
          child: _buildBuzzIndicator(venueActivity.buzzLevel),
        ),
      ],
    );
  }

  Widget _buildVenueDetails(BuildContext context, bool hasActiveDeals, List<dynamic> venueEvents, List<dynamic> checkInStories, List<dynamic> recentPhotos, dynamic venueActivity) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVenueHeader(),
          const SizedBox(height: 8),
          _buildVenueLocation(),
          const SizedBox(height: 8),
          _buildVenueDescription(),
          // Live events section
          if (venueEvents.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildLiveEventsSection(venueEvents),
          ],
          const SizedBox(height: 12),
          _buildAmenities(),
          // Visual content section
          if (checkInStories.isNotEmpty || recentPhotos.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildVisualContentSection(venue, checkInStories, recentPhotos),
          ],
          // Community activity indicators
          if (showCommunityActivity) ...[
            const SizedBox(height: 8),
            _buildCommunityActivity(venue),
          ],
          const SizedBox(height: 12),
          _buildActionButtons(context, venue, hasActiveDeals),
        ],
      ),
    );
  }

  Widget _buildVenueHeader() {
    return Row(
      children: [
        Text(venue.categoryIcon, style: const TextStyle(fontSize: 20)),
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
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${venue.rating}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Text(
              '${venue.reviewCount} reviews',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVenueLocation() {
    return Row(
      children: [
        Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            '${venue.address}, ${venue.city}',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
    );
  }

  Widget _buildVenueDescription() {
    return Text(
      venue.description,
      style: const TextStyle(fontSize: 14),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildAmenities() {
    return Wrap(
      spacing: 8,
      children: [
        if (venue.isHalal) _buildAmenityChip('Halal', Icons.restaurant),
        if (venue.hasWifi) _buildAmenityChip('WiFi', Icons.wifi),
        if (venue.acceptsCards) _buildAmenityChip('Cards', Icons.credit_card),
        if (venue.isVerified) _buildAmenityChip('Verified', Icons.verified),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, Venue venue, bool hasActiveDeals) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _viewVenueDetails(context, venue),
            icon: const Icon(Icons.info, size: 16),
            label: const Text('Details'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildBookingButton(context, venue, hasActiveDeals),
        ),
      ],
    );
  }

  Widget _buildBookingButton(BuildContext context, Venue venue, bool hasActiveDeals) {
    // Check if venue is good for groups (mock logic)
    final isGroupFriendly = venue.category == 'food' || venue.category == 'entertainment';
    final groupDiscount = isGroupFriendly ? '10% off for 6+ people' : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () => _bookVenue(context, venue),
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
            onTap: () => _showGroupBookingInfo(context, venue),
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

  Widget _buildCommunityActivity(Venue venue) {
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

  // Helper methods for visual indicators
  Widget _buildPhotoIndicator(int photoCount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.photo_camera,
            color: Colors.white,
            size: 12,
          ),
          const SizedBox(width: 2),
          Text(
            '$photoCount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventIndicator(dynamic event) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event,
            color: Colors.white,
            size: 12,
          ),
          SizedBox(width: 2),
          Text(
            'LIVE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuzzIndicator(dynamic buzzLevel) {
    Color color;
    String text;
    
    switch (buzzLevel.toString().split('.').last) {
      case 'buzzing':
        color = Colors.red;
        text = '🔥';
        break;
      case 'active':
        color = Colors.orange;
        text = '⚡';
        break;
      case 'moderate':
        color = Colors.green;
        text = '👥';
        break;
      default:
        color = Colors.grey;
        text = '😴';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget _buildVenueStatusIndicator(dynamic venue, dynamic venueActivity) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    // Determine status based on opening hours and activity
    if (!venue.isOpen) {
      statusColor = Colors.red;
      statusText = 'Closed';
      statusIcon = Icons.access_time;
    } else if (venueActivity.currentVisitors > 5) {
      statusColor = Colors.orange;
      statusText = 'Busy';
      statusIcon = Icons.people;
    } else if (venueActivity.currentVisitors > 0) {
      statusColor = Colors.green;
      statusText = 'Open';
      statusIcon = Icons.check_circle;
    } else {
      statusColor = Colors.blue;
      statusText = 'Quiet';
      statusIcon = Icons.timer;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                statusIcon,
                color: Colors.white,
                size: 12,
              ),
              const SizedBox(width: 4),
              Text(
                statusText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (venueActivity.currentVisitors > 0) ...[
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${venueActivity.currentVisitors} here',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLiveEventsSection(List<dynamic> events) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.purple.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(
                Icons.live_tv,
                size: 14,
                color: Colors.purple,
              ),
              const SizedBox(width: 4),
              const Text(
                'Live Now',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          
          // Event list
          ...events.take(2).map((event) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Icon(
                  _getEventIcon(event.eventType.toString()),
                  size: 12,
                  color: AppTheme.secondaryText,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (event.attendeeCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${event.attendeeCount}',
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.purple,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildVisualContentSection(dynamic venue, List<dynamic> checkInStories, List<dynamic> recentPhotos) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(
                Icons.photo_library,
                size: 16,
                color: Colors.blue,
              ),
              const SizedBox(width: 4),
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              const Spacer(),
              if (checkInStories.isNotEmpty)
                Text(
                  '${checkInStories.length} recent',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.secondaryText,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Recent photos preview
          if (recentPhotos.isNotEmpty) ...[
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recentPhotos.length,
                itemBuilder: (context, index) {
                  final photo = recentPhotos[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        photo.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, size: 20),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
          
          // Latest check-in story
          if (checkInStories.isNotEmpty) ...[
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(checkInStories.first.userAvatar),
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${checkInStories.first.userName} was here',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        checkInStories.first.message,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppTheme.secondaryText,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (checkInStories.first.dealUsed)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '💰',
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // Helper methods
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

  IconData _getEventIcon(String eventType) {
    switch (eventType.split('.').last) {
      case 'quietHours':
        return Icons.volume_off;
      case 'liveMusic':
        return Icons.music_note;
      case 'specialDeal':
        return Icons.local_offer;
      case 'culturalEvent':
        return Icons.festival;
      case 'workshop':
        return Icons.school;
      case 'social':
        return Icons.people;
      default:
        return Icons.event;
    }
  }

  // Action methods
  void _viewVenueDetails(BuildContext context, Venue venue) {
    AppNavigation.goToVenueDetail(context, venue.id);
  }

  void _bookVenue(BuildContext context, Venue venue) {
    final deals = MockData.deals
        .where((deal) => deal.venueId == venue.id && deal.isValid)
        .toList();

    if (deals.isNotEmpty) {
      _showDealBookingDialog(context, venue, deals.first);
    } else {
      _showRegularBookingDialog(context, venue);
    }
  }

  void _showDealBookingDialog(BuildContext context, Venue venue, dynamic deal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book ${deal.title}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('At ${venue.name}'),
            const SizedBox(height: 8),
            Text('Original Price: ${deal.originalPrice.toInt()} MAD'),
            Text(
              'Deal Price: ${deal.discountedPrice.toInt()} MAD',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.moroccoGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text('${deal.availableSpots} spots left'),
            Text('Valid until: ${deal.timeLeftDisplay}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Deal booked successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Book Deal'),
          ),
        ],
      ),
    );
  }

  void _showRegularBookingDialog(BuildContext context, Venue venue) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book at ${venue.name}'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Number of people',
                hintText: 'How many people?',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Preferred date & time',
                hintText: 'When would you like to visit?',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Special requests',
                hintText: 'Any special requirements?',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking request sent! We\'ll contact you soon.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Send Request'),
          ),
        ],
      ),
    );
  }

  void _showGroupBookingInfo(BuildContext context, Venue venue) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.group, color: AppTheme.moroccoGreen),
            SizedBox(width: 8),
            Text('Group Booking'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${venue.name} offers special group rates!',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Icon(Icons.people, size: 16, color: AppTheme.moroccoGreen),
                SizedBox(width: 8),
                Text('6+ people: 10% discount'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.people_alt, size: 16, color: AppTheme.moroccoGreen),
                SizedBox(width: 8),
                Text('10+ people: 15% discount'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.schedule, size: 16, color: AppTheme.moroccoGreen),
                SizedBox(width: 8),
                Text('Best rates during dead hours'),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Tip: Invite friends from the community for better deals!',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.secondaryText,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _bookGroupVenue(context, venue);
            },
            child: const Text('Book for Group'),
          ),
        ],
      ),
    );
  }

  void _bookGroupVenue(BuildContext context, Venue venue) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Group Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('How many people in your group for ${venue.name}?'),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Number of people',
                hintText: 'Minimum 6 for group rates',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Group booking request sent! We\'ll contact you with details.'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Request Quote'),
          ),
        ],
      ),
    );
  }
}