import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/models/room.dart';
import 'package:deadhour/widgets/common/room_card.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Room> filteredRooms = MockData.rooms.where((room) {
      final matchesCategory = selectedCategory == 'all' || room.category == selectedCategory;
      final matchesPrayerTime = !showPrayerTimeAware || room.isPrayerTimeAware;
      final matchesHalal = !showHalalOnly || room.isHalalOnly;
      return matchesCategory && matchesPrayerTime && matchesHalal;
    }).toList();

    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: filteredRooms.isEmpty
          ? const Center(child: Text('No rooms found.'))
          : ListView.builder(
              itemCount: filteredRooms.length,
              itemBuilder: (context, index) {
                final room = filteredRooms[index];
                return RoomCard(
                  room: room,
                  onTap: () => onJoinRoom(room),
                );
              },
            ),
    );
  }
}
