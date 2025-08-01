import '../shared/room_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/room.dart';
import '../../../../utils/mock_data.dart';
import '../empty_state_widget.dart';

class MyRoomsTabView extends ConsumerWidget {
  final Function(Room) onOpenRoom;
  const MyRoomsTabView({
    super.key,
    required this.onOpenRoom,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myRooms = MockData.rooms.where((room) => room.isJoined).toList();
    
    if (myRooms.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.person_outline,
        title: 'No joined rooms',
        subtitle: 'Join rooms to start discovering and connecting with the community',
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
        final room = myRooms[index];
        return RoomCard(
          room: room,
          onTap: () => onOpenRoom(room),
        );
      },
    );
  }
}
