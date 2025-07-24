import 'package:deadhour_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../../widgets/common/enhanced_app_bar.dart';

class RoomDetailScreen extends StatelessWidget {
  final String roomId;

  const RoomDetailScreen({
    super.key,
    required this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    final room = MockData.rooms.firstWhere(
      (r) => r.id == roomId,
      orElse: () => MockData.rooms.first,
    );

    return Scaffold(
      appBar: EnhancedAppBar(
        title: room.displayName,
        subtitle: '${room.categoryName} • ${room.city}',
        showBackButton: true,
        showGradient: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRoomHeader(context, room),
            _buildSectionTitle(context, 'About This Room'),
            _buildDescription(context, room),
            _buildSectionTitle(context, 'Room Statistics'),
            _buildStatsGrid(context, room),
            _buildSectionTitle(context, 'Rules & Guidelines'),
            _buildRulesList(context, room),
            _buildSectionTitle(context, 'Moderators'),
            _buildModeratorsList(context, room),
            _buildActionButtons(context, room),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomHeader(BuildContext context, dynamic room) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _getCategoryColor(room.category).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppBorderRadius.md),
            ),
            child: Center(
              child: Text(
                room.categoryIcon,
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.displayName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '${room.memberCount} members • ${room.onlineCount} online',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Chip(
                  label: Text(room.categoryName),
                  backgroundColor: _getCategoryColor(room.category).withValues(alpha: 0.1),
                  labelStyle: TextStyle(color: _getCategoryColor(room.category), fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppBorderRadius.sm)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget _buildDescription(BuildContext context, dynamic room) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Text(
        room.description,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, dynamic room) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        children: [
          _buildStatCard(context, Icons.people, 'Members', room.memberCount.toString()),
          _buildStatCard(context, Icons.circle, 'Online', room.onlineCount.toString(), color: AppColors.online),
          _buildStatCard(context, Icons.message, 'Messages', '1.2K'),
          _buildStatCard(context, Icons.local_fire_department, 'Deals Shared', '50+'),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, IconData icon, String title, String value, {Color? color}) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppBorderRadius.md)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color ?? AppTheme.moroccoGreen, size: 24),
            const SizedBox(height: AppSpacing.sm),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRulesList(BuildContext context, dynamic room) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: room.rules.map<Widget>((rule) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle_outline, size: 18, color: AppTheme.moroccoGreen),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  rule,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildModeratorsList(BuildContext context, dynamic room) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: room.moderators.length,
          itemBuilder: (context, index) {
            final moderator = room.moderators[index];
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(moderator.profilePicture),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    moderator.name,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, dynamic room) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => context.push('/community/rooms/${room.id}/chat'),
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('Join Chat'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // Implement share functionality
              },
              icon: const Icon(Icons.share),
              label: const Text('Share Room'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              ),
            ),
          ),
        ],
      ),
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
      case 'tourism':
        return AppColors.tourismCategory;
      case 'family':
        return AppColors.familyCategory;
      default:
        return AppTheme.moroccoGreen;
    }
  }
}


