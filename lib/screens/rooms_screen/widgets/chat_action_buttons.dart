import 'package:flutter/material.dart';

import 'package:deadhour/utils/app_theme.dart';

/// Action buttons for chat interactions like leaving room and sharing content
class ChatActionButtons {
  /// Show leave room confirmation dialog
  static void showLeaveRoomDialog(BuildContext context, dynamic room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Room'),
        content: Text('Are you sure you want to leave ${room.displayName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Left ${room.displayName}'),
                  backgroundColor: AppTheme.moroccoGreen,
                ),
              );
            },
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  /// Show message options bottom sheet
  static void showMessageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Share Content',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.local_fire_department,
                  color: Colors.red),
              title: const Text('Share Deal'),
              subtitle: const Text('Alert the room about a great deal'),
              onTap: () {
                Navigator.pop(context);
                RoomChatDialogHelpers.showShareDealDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Colors.blue),
              title: const Text('Form Group'),
              subtitle: const Text('Create a group for better discounts'),
              onTap: () {
                Navigator.pop(context);
                RoomChatDialogHelpers.showFormGroupDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.green),
              title: const Text('Share Location'),
              subtitle: const Text('Share a venue or meeting point'),
              onTap: () {
                Navigator.pop(context);
                RoomChatDialogHelpers.showShareLocationDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}