import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/mock_data.dart';
import '../../../../widgets/common/room_card.dart';

class BusinessRoomsTabView extends ConsumerWidget {
  const BusinessRoomsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessRooms =
        MockData.rooms.where((room) => room.category == 'business').toList();

    return businessRooms.isEmpty
        ? const Center(child: Text('No business rooms available.'))
        : ListView.builder(
            itemCount: businessRooms.length,
            itemBuilder: (context, index) {
              final room = businessRooms[index];
              return RoomCard(
                room: room,
                onTap: () {
                  // Handle business room tap
                },
              );
            },
          );
  }
}
