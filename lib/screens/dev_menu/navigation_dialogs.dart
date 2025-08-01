import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../utils/performance_utils.dart';

/// Navigation-related dialogs and modals
class NavigationDialogs {
  static void showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit DeadHour?'),
        content: const Text('Are you sure you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  static void showRoomCreation(BuildContext context) {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Community Room'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Room Name',
                hintText: 'e.g., Coffee Lovers Casablanca',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'What is this room about?',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Room creation feature coming soon!'),
                  backgroundColor: AppColors.info,
                ),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  static void markAllAsRead(BuildContext context) {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.selection);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  static void showNotificationSettings(BuildContext context) {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Notification Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Configure your notification preferences here.'),
            // TODO: Add actual settings UI
          ],
        ),
      ),
    );
  }
}