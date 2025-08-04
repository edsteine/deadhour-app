import 'package:flutter/material.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/screens/community/widgets/empty_state_widget.dart';
import 'package:deadhour/widgets/common/engaging_empty_state.dart';
import 'package:deadhour/screens/community/widgets/voice_channel_widget.dart';
import 'package:deadhour/screens/community/widgets/rich_media_widget.dart';

class AllRoomsTab extends StatelessWidget {
  final String selectedCategory;
  final bool showPrayerTimeAware;
  final bool showHalalOnly;
  final Future<void> Function() onRefresh;
  final Function(dynamic room) onJoinRoom;

  const AllRoomsTab({
    super.key,
    required this.selectedCategory,
    required this.showPrayerTimeAware,
    required this.showHalalOnly,
    required this.onRefresh,
    required this.onJoinRoom,
  });

  List<dynamic> _getFilteredRooms() {
    var rooms = MockData.rooms;

    if (selectedCategory != 'all') {
      rooms = rooms.where((room) => room.category == selectedCategory).toList();
    }

    // Apply cultural filters
    if (showPrayerTimeAware) {
      rooms = rooms.where((room) => room.isPrayerTimeAware).toList();
    }
    if (showHalalOnly) {
      rooms = rooms.where((room) => room.isHalalOnly).toList();
    }

    return rooms;
  }

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
  Widget build(BuildContext context) {
    final rooms = _getFilteredRooms();

    if (rooms.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.forum_outlined,
        title: 'No rooms found',
        subtitle: 'Try adjusting your filters or create a new room',
        type: EmptyStateType.noRooms,
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
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
