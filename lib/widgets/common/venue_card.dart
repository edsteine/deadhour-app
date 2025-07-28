import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/venue.dart';
import '../../utils/theme.dart';

class VenueCard extends StatelessWidget {
  final Venue venue;
  final VoidCallback? onTap;
  final bool showDistance;
  final double? distance;
  final bool isCompact;

  const VenueCard({
    super.key,
    required this.venue,
    this.onTap,
    this.showDistance = false,
    this.distance,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: isCompact ? 8 : 16,
        vertical: isCompact ? 4 : 8,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: isCompact ? _buildCompactLayout() : _buildFullLayout(),
      ),
    );
  }

  Widget _buildFullLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: CachedNetworkImage(
            imageUrl: venue.imageUrl,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              height: 160,
              color: Colors.grey.shade300,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              height: 160,
              color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported,
                    size: 48,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Image not available',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with category and verification
              Row(
                children: [
                  Text(
                    venue.categoryIcon,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      venue.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (venue.isVerified)
                    const Icon(
                      Icons.verified,
                      color: AppColors.success,
                      size: 20,
                    ),
                ],
              ),
              const SizedBox(height: 4),

              // Type and price range
              Row(
                children: [
                  Text(
                    venue.type,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.secondaryText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '•',
                    style: TextStyle(color: AppTheme.lightText),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    venue.priceRange,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.secondaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Rating and reviews
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.warning,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    venue.rating.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${venue.reviewCount} reviews)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.secondaryText,
                    ),
                  ),
                  if (showDistance && distance != null) ...[
                    const Spacer(),
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppTheme.secondaryText,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${distance!.toStringAsFixed(1)} km',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),

              // Features
              Wrap(
                spacing: 8,
                children: [
                  if (venue.isHalal)
                    _buildFeatureChip('Halal', Icons.restaurant),
                  if (venue.hasWifi) _buildFeatureChip('WiFi', Icons.wifi),
                  if (venue.acceptsCards)
                    _buildFeatureChip('Cards', Icons.credit_card),
                  _buildFeatureChip(
                    venue.openingStatus,
                    venue.isOpen ? Icons.access_time : Icons.schedule,
                    color: venue.isOpen ? AppColors.success : AppColors.error,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactLayout() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: venue.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image),
              ),
              errorWidget: (context, url, error) => Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(venue.categoryIcon,
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        venue.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (venue.isVerified)
                      const Icon(
                        Icons.verified,
                        color: AppColors.success,
                        size: 16,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  venue.type,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.warning,
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      venue.rating.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      venue.priceRange,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    if (showDistance && distance != null) ...[
                      const Spacer(),
                      Text(
                        '${distance!.toStringAsFixed(1)} km',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (venue.isHalal) ...[
                      const Icon(Icons.restaurant,
                          size: 12, color: AppColors.success),
                      const SizedBox(width: 4),
                    ],
                    if (venue.hasWifi) ...[
                      const Icon(Icons.wifi, size: 12, color: AppColors.info),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      venue.openingStatus,
                      style: TextStyle(
                        fontSize: 10,
                        color:
                            venue.isOpen ? AppColors.success : AppColors.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String label, IconData icon, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (color ?? AppTheme.moroccoGreen).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color ?? AppTheme.moroccoGreen,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color ?? AppTheme.moroccoGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
