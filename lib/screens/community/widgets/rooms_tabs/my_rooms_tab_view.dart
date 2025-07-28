import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/models/room.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/widgets/common/room_card.dart';

class MyRoomsTabView extends ConsumerWidget {
  final Function(Room) onOpenRoom;
  const MyRoomsTabView({
    super.key,
    required this.onOpenRoom,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myRooms = MockData.rooms.where((room) => room.isJoined).toList();
    return myRooms.isEmpty
        ? const Center(child: Text('You haven\'t joined any rooms yet.'))
        : ListView.builder(
            itemCount: myRooms.length,
            itemBuilder: (context, index) {
              final room = myRooms[index];
              return RoomCard(
                room: room,
                onTap: () => onOpenRoom(room),
              );
            },
          );
  }
}
