import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class RoomChatHelpers {
  static Color getCategoryColor(String category) {
    switch (category) {
      case 'food':
        return AppColors.foodCategory;
      case 'entertainment':
        return AppColors.entertainmentCategory;
      case 'wellness':
        return AppColors.wellnessCategory;
      case 'sports':
        return AppColors.sportsCategory;
      case 'tourism':
        return AppColors.tourismCategory;
      case 'family':
        return AppColors.familyCategory;
      default:
        return AppTheme.moroccoGreen;
    }
  }

  static String formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }

  static Widget buildInfoStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppTheme.secondaryText),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.secondaryText,
          ),
        ),
      ],
    );
  }

  static void bookDeal(BuildContext context, Map<String, dynamic> dealInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book Deal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Venue: ${dealInfo['venueName']}'),
            Text('Discount: ${dealInfo['discount']}'),
            Text('Valid until: ${dealInfo['validUntil']}'),
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
                  content: Text('Deal booked successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }

  static void joinGroup(BuildContext context, Map<String, dynamic> groupInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Join Group'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Group size: ${groupInfo['currentSize']}/${groupInfo['minSize']}'),
            Text('Additional discount: ${groupInfo['additionalDiscount']}'),
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
                  content: Text('Joined group successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Join Group'),
          ),
        ],
      ),
    );
  }

  static void leaveRoom(BuildContext context, dynamic room) {
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
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }
}