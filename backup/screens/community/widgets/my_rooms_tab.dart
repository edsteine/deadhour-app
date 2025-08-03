import 'package:flutter/material.dart';
import '../../../utils/mock_data.dart';
import '../../../widgets/common/room_card.dart';
import 'empty_state_widget.dart';

class MyRoomsTab extends StatelessWidget {
  final Function(dynamic room) onOpenRoom;

  const MyRoomsTab({
    super.key,
    required this.onOpenRoom,
  });

  @override
  Widget build(BuildContext context) {
    // Mock user's joined rooms
    final myRooms = MockData.rooms.take(2).toList();

    if (myRooms.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.person_outline,
        title: 'No joined rooms',
        subtitle:
            'Join rooms to start discovering and connecting with the community',
        actionText: 'Browse Rooms',
        onAction: () {
          // Navigate back to All Rooms through the unified filter
          // This will be handled by the parent navigation system
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: myRooms.length,
      itemBuilder: (context, index) {
        return RoomCard(
          room: myRooms[index],
          onTap: () => onOpenRoom(myRooms[index]),
        );
      },
    );
  }
}
