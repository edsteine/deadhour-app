import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:deadhour/screens/rooms_screen/models/room.dart';
import 'package:deadhour/screens/rooms_screen/widgets/empty_state_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rich_media_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/room_filter_logic.dart';
import 'package:deadhour/screens/rooms_screen/widgets/voice_channel_widget.dart';
import 'package:deadhour/utils/constants.dart';
import 'package:deadhour/utils/app_theme.dart';
import 'package:deadhour/utils/app_spacing.dart';









class AllRoomsTabView extends ConsumerWidget {
  final String selectedCategory;
  final bool showPrayerTimeAware;
  final bool showHalalOnly;
  final VoidCallback onRefresh;
  final Function(Room) onJoinRoom;

  const AllRoomsTabView({
    super.key,
    required this.selectedCategory,
    required this.showPrayerTimeAware,
    required this.showHalalOnly,
    required this.onRefresh,
    required this.onJoinRoom,
  });

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'food':
        return Colors.orange;
      case 'entertainment':
        return Colors.purple;
      case 'wellness':
        return Colors.green;
      case 'tourism':
        return Colors.blue;
      case 'sports':
        return Colors.red;
      case 'family':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  String _getCategoryEmoji(String category) {
    switch (category) {
      case 'food':
        return '🍕';
      case 'entertainment':
        return '🎮';
      case 'wellness':
        return '💆';
      case 'tourism':
        return '🌍';
      case 'sports':
        return '⚽';
      case 'family':
        return '👨‍👩‍👧‍👦';
      default:
        return '💬';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use centralized filtering logic
    final List<Room> filteredRooms = RoomFilterLogic.getFilteredRooms(
      selectedCategory: selectedCategory,
      selectedCity: 'Casablanca', // TODO: Get from user preferences
      showPrayerTimeAware: showPrayerTimeAware,
      showHalalOnly: showHalalOnly,
    );
    
    // Group rooms by category for better organization
    final Map<String, List<Room>> roomsByCategory = _groupRoomsByCategory(filteredRooms);

    if (filteredRooms.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.forum_outlined,
        title: 'No rooms found',
        subtitle: 'Try adjusting your filters or create a new room',
        onAction: () {
          // Handle create room action
        },
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: selectedCategory == 'all' 
        ? _buildCategoryGroupedView(roomsByCategory)
        : _buildFilteredRoomsList(filteredRooms),
    );
  }
  
  Map<String, List<Room>> _groupRoomsByCategory(List<Room> rooms) {
    final Map<String, List<Room>> grouped = {};
    for (final room in rooms) {
      grouped.putIfAbsent(room.category, () => []).add(room);
    }
    return grouped;
  }
  
  Widget _buildCategoryGroupedView(Map<String, List<Room>> roomsByCategory) {
    if (roomsByCategory.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: roomsByCategory.length,
      itemBuilder: (context, index) {
        final category = roomsByCategory.keys.elementAt(index);
        final rooms = roomsByCategory[category]!;
        final categoryInfo = _getCategoryInfo(category);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryHeader(categoryInfo, rooms.length),
            const SizedBox(height: AppSpacing.sm),
            _buildCategoryRoomsList(rooms),
            const SizedBox(height: AppSpacing.lg),
          ],
        );
      },
    );
  }
  
  Widget _buildFilteredRoomsList(List<Room> rooms) {
    if (rooms.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return Column(
          children: [
              _buildRoomCard(room),
              
              const Divider(height: 1),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return EmptyStateWidget(
      icon: Icons.forum_outlined,
      title: 'No rooms found',
      subtitle: 'Try adjusting your filters or create a new room',
      onAction: () {
        // Handle create room action
      },
    );
  }
  
  Map<String, dynamic> _getCategoryInfo(String category) {
    final categoryData = AppConstants.businessCategories
        .firstWhere((cat) => cat['id'] == category, orElse: () => {
      'id': category,
      'name': category.toUpperCase(),
      'icon': '💬',
      'color': 0xFF757575,
      'arabic': category,
      'french': category,
    });
    return categoryData;
  }
  
  Widget _buildCategoryHeader(Map<String, dynamic> categoryInfo, int roomCount) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(categoryInfo['color']).withValues(alpha: 0.1),
            Color(categoryInfo['color']).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(categoryInfo['color']).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(categoryInfo['color']),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                categoryInfo['icon'],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryInfo['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$roomCount active rooms • Connect with community',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Color(categoryInfo['color']),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryRoomsList(List<Room> rooms) {
    return Column(
      children: rooms.take(3).map((room) => _buildCompactRoomCard(room)).toList(),
    );
  }
  
  Widget _buildCompactRoomCard(Room room) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getCategoryColor(room.category),
          child: Text(
            _getCategoryEmoji(room.category),
            style: const TextStyle(fontSize: 16),
          ),
        ),
        title: Text(
          room.displayName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              room.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildRoomBadge(
                  icon: Icons.people,
                  text: '${room.memberCount}',
                  color: Colors.blue,
                ),
                const SizedBox(width: AppSpacing.sm),
                _buildRoomBadge(
                  icon: Icons.circle,
                  text: '${room.onlineCount}',
                  color: Colors.green,
                ),
                if (room.isPrayerTimeAware) ...[
                  const SizedBox(width: AppSpacing.sm),
                  _buildRoomBadge(
                    icon: Icons.mosque,
                    text: 'Prayer',
                    color: AppTheme.moroccoGreen,
                  ),
                ],
                if (room.isHalalOnly) ...[
                  const SizedBox(width: AppSpacing.sm),
                  _buildRoomBadge(
                    icon: Icons.verified,
                    text: 'Halal',
                    color: AppTheme.moroccoGold,
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () => onJoinRoom(room),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.moroccoGreen,
            foregroundColor: Colors.white,
            minimumSize: const Size(60, 32),
          ),
          child: const Text('Join', style: TextStyle(fontSize: 12)),
        ),
      ),
    );
  }
  
  Widget _buildRoomCard(Room room) {
    return ExpansionTile(
      leading: CircleAvatar(
        backgroundColor: _getCategoryColor(room.category),
        child: Text(
          _getCategoryEmoji(room.category),
          style: const TextStyle(fontSize: 16),
        ),
      ),
      title: Text(
        room.displayName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(room.description),
          const SizedBox(height: 4),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              _buildRoomBadge(
                icon: Icons.people,
                text: '${room.memberCount} members',
                color: Colors.blue,
              ),
              _buildRoomBadge(
                icon: Icons.circle,
                text: '${room.onlineCount} online',
                color: Colors.green,
              ),
              if (room.isPrayerTimeAware)
                _buildRoomBadge(
                  icon: Icons.mosque,
                  text: 'Prayer Aware',
                  color: AppTheme.moroccoGreen,
                ),
              if (room.isHalalOnly)
                _buildRoomBadge(
                  icon: Icons.verified,
                  text: 'Halal Only',
                  color: AppTheme.moroccoGold,
                ),
            ],
          ),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () => onJoinRoom(room),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.moroccoGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(60, 32),
        ),
        child: const Text('Join', style: TextStyle(fontSize: 12)),
      ),
      children: [
        // Voice channels section
        VoiceChannelWidget(
          roomId: room.id,
          userId: 'current_user_id',
        ),
        
        // Rich media section
        RichMediaWidget(
          roomId: room.id,
          userId: 'current_user_id',
        ),
        
        const SizedBox(height: 16),
      ],
    );
  }
  
  Widget _buildRoomBadge({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
