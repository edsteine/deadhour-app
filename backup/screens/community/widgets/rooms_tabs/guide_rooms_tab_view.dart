import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/mock_data.dart';
import '../../../../widgets/common/room_card.dart';

class GuideRoomsTabView extends ConsumerWidget {
  const GuideRoomsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guideRooms =
        MockData.rooms.where((room) => room.category == 'guide').toList();

    return guideRooms.isEmpty
        ? const Center(child: Text('No guide network rooms available.'))
        : ListView.builder(
            itemCount: guideRooms.length,
            itemBuilder: (context, index) {
              final room = guideRooms[index];
              return RoomCard(
                room: room,
                onTap: () {
                  // Handle guide room tap
                },
              );
            },
          );
  }
}
