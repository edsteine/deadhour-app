import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class RoomChatDialogHelpers {
  static void showMessageOptions(BuildContext context, {
    required VoidCallback onDealShare,
    required VoidCallback onGroupForm,
    required VoidCallback onLocationShare,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('Share Deal'),
              onTap: () {
                Navigator.pop(context);
                onDealShare();
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Form Group'),
              onTap: () {
                Navigator.pop(context);
                onGroupForm();
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Share Location'),
              onTap: () {
                Navigator.pop(context);
                onLocationShare();
              },
            ),
          ],
        ),
      ),
    );
  }

  static void showShareDeal(BuildContext context) => showShareDealDialog(context);
  static void showFormGroup(BuildContext context) => showFormGroupDialog(context);
  static void showShareLocation(BuildContext context) => showShareLocationDialog(context);

  static void showShareDealDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Deal'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Venue Name',
                hintText: 'e.g., Café Atlas',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Discount',
                hintText: 'e.g., 40% off',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Valid Until',
                hintText: 'e.g., 6 PM today',
              ),
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Deal shared with the room!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }

  static void showFormGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Form Group'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Group Size Needed',
                hintText: 'e.g., 4 people',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Meeting Time',
                hintText: 'e.g., 3 PM today',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Additional Info',
                hintText: 'Any special requirements?',
              ),
              maxLines: 2,
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Group formation request sent!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  static void showShareLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Location'),
        content: const Text('Location sharing not implemented in mockup'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
