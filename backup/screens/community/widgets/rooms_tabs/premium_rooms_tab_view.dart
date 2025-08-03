import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/mock_data.dart';
import '../../../../models/room.dart';
import '../../../../widgets/common/room_card.dart';

class PremiumRoomsTabView extends ConsumerWidget {
  final Function(Room) onJoinPremiumRoom;
  final VoidCallback onShowPremiumUpgrade;

  const PremiumRoomsTabView({
    super.key,
    required this.onJoinPremiumRoom,
    required this.onShowPremiumUpgrade,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premiumRooms =
        MockData.rooms.where((room) => room.isPremiumOnly).toList();

    return premiumRooms.isEmpty
        ? const Center(child: Text('No premium rooms available.'))
        : ListView.builder(
            itemCount: premiumRooms.length,
            itemBuilder: (context, index) {
              final room = premiumRooms[index];
              return RoomCard(
                room: room,
                onTap: () => onJoinPremiumRoom(room),
              );
            },
          );
  }
}
