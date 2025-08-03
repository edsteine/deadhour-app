import 'package:flutter/material.dart';
import '../../../utils/mock_data.dart';
import '../../../widgets/common/room_card.dart';
import 'empty_state_widget.dart';

class PremiumRoomsTab extends StatelessWidget {
  final Function(dynamic room) onJoinPremiumRoom;
  final VoidCallback onShowPremiumUpgrade;

  const PremiumRoomsTab({
    super.key,
    required this.onJoinPremiumRoom,
    required this.onShowPremiumUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    final premiumRooms =
        MockData.rooms.where((room) => room.isPremiumOnly).toList();

    if (premiumRooms.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.workspace_premium,
        title: 'Premium Rooms',
        subtitle:
            'Exclusive rooms with local experts and curated experiences - Free during beta!',
        actionText: 'Learn More',
        onAction: onShowPremiumUpgrade,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: premiumRooms.length,
      itemBuilder: (context, index) {
        return RoomCard(
          room: premiumRooms[index],
          onTap: () => onJoinPremiumRoom(premiumRooms[index]),
        );
      },
    );
  }
}
