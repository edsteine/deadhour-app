
import 'package:flutter/material.dart';
import 'package:deadhour/utils/mock_data.dart';

class PopularRoomsTab extends StatelessWidget {
  final Function(dynamic room) onJoinRoom;

  const PopularRoomsTab({
    super.key,
    required this.onJoinRoom,
  });

  @override
  Widget build(BuildContext context) {
    final popularRooms =
        MockData.rooms.where((room) => room.memberCount > 100).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: popularRooms.length,
      itemBuilder: (context, index) {
        return RoomCard(
          room: popularRooms[index],
          onTap: () => onJoinRoom(popularRooms[index]),
        );
      },
    );
  }
}
