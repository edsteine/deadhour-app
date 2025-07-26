import 'package:flutter/material.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/widgets/common/room_card.dart';
import 'package:deadhour/screens/community/widgets/empty_state_widget.dart';

class MyRoomsTab extends StatelessWidget {
  final TabController tabController;
  final Function(dynamic room) onOpenRoom;

  const MyRoomsTab({
    super.key,
    required this.tabController,
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
        subtitle: 'Join rooms to start discovering and connecting with the community',
        actionText: 'Browse Rooms',
        onAction: () => tabController.animateTo(0),
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
