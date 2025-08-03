import 'package:flutter/material.dart';
import '../../models/room.dart';
import '../../utils/theme.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback? onTap;
  final bool showLastMessage;
  final bool isCompact;

  const RoomCard({
    super.key,
    required this.room,
    this.onTap,
    this.showLastMessage = true,
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
        child: Padding(
          padding: EdgeInsets.all(isCompact ? 12 : 16),
          child: isCompact ? _buildCompactLayout() : _buildFullLayout(),
        ),
      ),
    );
  }

  Widget _buildFullLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            // Category icon and room type
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getCategoryColor().withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                room.categoryIcon,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 12),

            // Room info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          room.displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        room.privacyIcon,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${room.categoryName} • ${room.city}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Description
        Text(
          room.description,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.secondaryText,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),

        // Stats
        Row(
          children: [
            _buildStatItem(
              icon: Icons.people,
              value: room.memberCount.toString(),
              label: 'members',
            ),
            const SizedBox(width: 16),
            _buildStatItem(
              icon: Icons.circle,
              value: room.onlineCount.toString(),
              label: 'online',
              color: AppColors.success,
            ),
            const Spacer(),
            Text(
              room.lastActivityDisplay,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.lightText,
              ),
            ),
          ],
        ),

        // Features
        if (room.specialFeatures.isNotEmpty ||
            room.isPrayerTimeAware ||
            room.isHalalOnly) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: [
              ...room.specialFeatures.map((feature) {
                return _buildFeatureChip(feature);
              }),
              if (room.isPrayerTimeAware)
                _buildFeatureChip('Prayer Time Aware 🕌'),
              if (room.isHalalOnly) _buildFeatureChip('Halal Only ✅'),
            ],
          ),
        ],

        // Last message
        if (showLastMessage && room.hasRecentActivity) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildLastMessage(),
          ),
        ],
      ],
    );
  }

  Widget _buildCompactLayout() {
    return Row(
      children: [
        // Category icon
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getCategoryColor().withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              room.categoryIcon,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Room info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      room.displayName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(room.privacyIcon, style: const TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                room.city,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondaryText,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.people,
                    size: 12,
                    color: AppTheme.secondaryText,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    room.memberCount.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.secondaryText,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.circle,
                    size: 8,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    room.onlineCount.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.secondaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Activity indicator
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _getActivityColor(),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              room.lastActivityDisplay,
              style: const TextStyle(
                fontSize: 10,
                color: AppTheme.lightText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    Color? color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: color ?? AppTheme.secondaryText,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color ?? AppTheme.primaryText,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureChip(String feature) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        feature,
        style: const TextStyle(
          fontSize: 10,
          color: AppTheme.moroccoGreen,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLastMessage() {
    final lastMessage = room.lastMessage;
    if (lastMessage == null) return const SizedBox.shrink();

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lastMessage['userName'] ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                lastMessage['message'] ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondaryText,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (lastMessage['type'] == 'deal_alert')
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'DEAL',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Color _getCategoryColor() {
    switch (room.category) {
      case 'food':
        return AppColors.foodCategory;
      case 'entertainment':
        return AppColors.entertainmentCategory;
      case 'wellness':
        return AppColors.wellnessCategory;
      case 'sports':
        return AppColors.sportsCategory;
      case 'tourism':
        return AppColors.tourismCategory;
      case 'family':
        return AppColors.familyCategory;
      default:
        return AppTheme.moroccoGreen;
    }
  }

  Color _getActivityColor() {
    switch (room.activityStatus) {
      case 'Very Active':
        return AppColors.success;
      case 'Active':
        return AppColors.info;
      case 'Recently Active':
        return AppColors.warning;
      default:
        return AppColors.error;
    }
  }
}
