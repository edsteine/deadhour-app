import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';






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
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: filteredRooms.length,
        itemBuilder: (context, index) {
          final room = filteredRooms[index];
          return Column(
            children: [
              // Enhanced room card with expanded features
              ExpansionTile(
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
                    Row(
                      children: [
                        const Icon(Icons.people, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${room.memberCount} members',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${room.onlineCount} online',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () => onJoinRoom(room),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
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
              ),
              
              const Divider(height: 1),
            ],
          );
        },
      ),
    );
  }
}
