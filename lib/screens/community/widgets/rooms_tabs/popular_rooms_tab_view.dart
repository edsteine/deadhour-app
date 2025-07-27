import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/models/room.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/widgets/common/room_card.dart';

class PopularRoomsTabView extends ConsumerWidget {
  final Function(Room) onJoinRoom;

  const PopularRoomsTabView({
    super.key,
    required this.onJoinRoom,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularRooms = MockData.rooms.where((room) => room.isPopular).toList();

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
