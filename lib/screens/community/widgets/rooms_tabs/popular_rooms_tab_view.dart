import '../shared/room_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/room.dart';
import '../room_filter_logic.dart';

class PopularRoomsTabView extends ConsumerWidget {
  final Function(Room) onJoinRoom;

  const PopularRoomsTabView({
    super.key,
    required this.onJoinRoom,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use better logic: memberCount > 100 (from popular_rooms_tab.dart)
    final popularRooms = RoomFilterLogic.getFilteredRooms(
      selectedCategory: 'all',
      selectedCity: 'Casablanca',
      showPrayerTimeAware: false,
      showHalalOnly: false,
    ).where((room) => room.memberCount > 100).toList();

    return popularRooms.isEmpty
        ? const Center(child: Text('No popular rooms available.'))
        : ListView.builder(
            itemCount: popularRooms.length,
            itemBuilder: (context, index) {
              final room = popularRooms[index];
              return RoomCard(
                room: room,
                onTap: () => onJoinRoom(room),
              );
            },
          );
  }
}
