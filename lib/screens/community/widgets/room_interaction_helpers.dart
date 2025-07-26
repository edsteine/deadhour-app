import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/community/widgets/create_room_sheet.dart';


class RoomInteractionHelpers {
  static Future<void> handleRefresh(Function setStateCallback) async {
    await Future.delayed(const Duration(seconds: 1));
    setStateCallback();
  }

  static void showCitySelector(BuildContext context, String selectedCity, Function(String) onCitySelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select City',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...['Casablanca', 'Rabat', 'Marrakech', 'Fez'].map((city) {
              return ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(city),
                trailing: selectedCity == city ? const Icon(Icons.check) : null,
                onTap: () {
                  onCitySelected(city);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  static void showRoomSearch(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Rooms'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Search for rooms, topics, or categories...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  static void showCreateRoomDialog(BuildContext context, String selectedCity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => CreateRoomSheet(
          scrollController: scrollController,
          selectedCity: selectedCity,
        ),
      ),
    );
  }

  static void joinRoom(BuildContext context, dynamic room, Function(dynamic) openRoomCallback) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Join ${room.displayName}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(room.description),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.people, size: 16, color: AppTheme.secondaryText),
                const SizedBox(width: 4),
                Text('${room.memberCount} members'),
                const SizedBox(width: 16),
                const Icon(Icons.circle, size: 8, color: AppColors.success),
                const SizedBox(width: 4),
                Text('${room.onlineCount} online'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openRoomCallback(room);
            },
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }

  static void openRoom(BuildContext context, dynamic room) {
    context.go('/community/room/${room.id}');
  }

  static void joinPremiumRoom(BuildContext context, dynamic room, VoidCallback showPremiumUpgradeCallback) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Premium Room'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.workspace_premium,
              size: 48,
              color: AppTheme.moroccoGold,
            ),
            const SizedBox(height: 16),
            Text(
              room.displayName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is a premium room with exclusive features and local expert access.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              showPremiumUpgradeCallback();
            },
            child: const Text('Upgrade to Premium'),
          ),
        ],
      ),
    );
  }
}

