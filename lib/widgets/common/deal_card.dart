import 'package:flutter/material.dart';
import '../../models/deal.dart';
import '../../models/venue.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';

class DealCard extends StatelessWidget {
  final Deal deal;
  final VoidCallback? onTap;
  final bool showVenueInfo;
  final bool isCompact;

  const DealCard({
    super.key,
    required this.deal,
    this.onTap,
    this.showVenueInfo = true,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final venue = _getVenueById(deal.venueId);

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: isCompact ? 8 : 16,
        vertical: isCompact ? 4 : 8,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(isCompact ? 12 : 16),
          child:
              isCompact ? _buildCompactLayout(venue) : _buildFullLayout(venue),
        ),
      ),
    );
  }

  Widget _buildFullLayout(Venue? venue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with status and urgency
        Row(
          children: [
            Text(
              deal.statusIcon,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                deal.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDiscountBadge(),
          ],
        ),
        const SizedBox(height: 6),

        // Venue info
        if (showVenueInfo && venue != null) ...[
          Row(
            children: [
              Text(venue.categoryIcon, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  venue.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (venue.isVerified)
                const Icon(
                  Icons.verified,
                  size: 16,
                  color: AppColors.success,
                ),
            ],
          ),
          const SizedBox(height: 6),
        ],

        // Description
        Text(
          deal.description,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.secondaryText,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),

        // Price and availability
        Row(
          children: [
            _buildPriceInfo(),
            const Spacer(),
            _buildAvailabilityInfo(),
          ],
        ),
        const SizedBox(height: 6),

        // Time left and action
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 16,
              color: _getUrgencyColor(),
            ),
            const SizedBox(width: 4),
            Text(
              deal.timeLeftDisplay,
              style: TextStyle(
                fontSize: 12,
                color: _getUrgencyColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            _buildActionButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildCompactLayout(Venue? venue) {
    return Row(
      children: [
        // Deal icon and discount
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                deal.statusIcon,
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                deal.discountDisplay,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.moroccoGreen,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),

        // Deal info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deal.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (venue != null) ...[
                const SizedBox(height: 2),
                Text(
                  venue.name,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '${deal.discountedPrice.toInt()} MAD',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.moroccoGreen,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${deal.originalPrice.toInt()} MAD',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.lightText,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Time and availability
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              deal.timeLeftDisplay,
              style: TextStyle(
                fontSize: 10,
                color: _getUrgencyColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${deal.availableSpots} left',
              style: const TextStyle(
                fontSize: 10,
                color: AppTheme.secondaryText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDiscountBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        deal.discountDisplay,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPriceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${deal.discountedPrice.toInt()} MAD',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.moroccoGreen,
          ),
        ),
        Text(
          '${deal.originalPrice.toInt()} MAD',
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.lightText,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilityInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${deal.availableSpots} spots left',
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.secondaryText,
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: 80,
          child: LinearProgressIndicator(
            value: deal.occupancyRate / 100,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(
              deal.availableSpots <= 3
                  ? AppColors.error
                  : AppTheme.moroccoGreen,
            ),
            minHeight: 4,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton(
      onPressed: deal.isValid ? onTap : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.moroccoGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: const Size(80, 32),
      ),
      child: Text(
        deal.isValid ? 'Book Now' : 'Expired',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Color _getUrgencyColor() {
    switch (deal.urgencyLevel) {
      case 'urgent':
        return AppColors.error;
      case 'moderate':
        return AppColors.warning;
      default:
        return AppTheme.secondaryText;
    }
  }

  Venue? _getVenueById(String venueId) {
    try {
      return MockData.venues.firstWhere((venue) => venue.id == venueId);
    } catch (e) {
      return null;
    }
  }
}
