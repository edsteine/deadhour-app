import 'package:flutter/material.dart';
import '../../../utils/mock_data.dart';
import '../../../widgets/common/room_card.dart';
import 'empty_state_widget.dart';
import '../../../widgets/common/engaging_empty_state.dart';

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
          return RoomCard(
            room: rooms[index],
            onTap: () => onJoinRoom(rooms[index]),
          );
        },
      ),
    );
  }
}
