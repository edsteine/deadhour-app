
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/utils/mock_data.dart';



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

    if (premiumRooms.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.workspace_premium,
        title: 'Premium Rooms',
        subtitle: 'Exclusive rooms with local experts and curated experiences - Free during beta!',
        actionText: 'Learn More',
        onAction: onShowPremiumUpgrade,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
