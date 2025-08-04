import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class NotificationHelpers {
  static Color getNotificationColor(String type) {
    switch (type) {
      case 'deal_alert':
        return Colors.red;
      case 'community_activity':
        return Colors.blue;
      case 'prayer_reminder':
        return AppTheme.moroccoGreen;
      case 'friend_activity':
        return Colors.purple;
      case 'booking_update':
        return Colors.orange;
      case 'cultural_event':
        return Colors.teal;
      default:
        return AppTheme.moroccoGreen;
    }
  }

  static IconData getNotificationIcon(String type) {
    switch (type) {
      case 'deal_alert':
        return Icons.local_offer;
      case 'community_activity':
        return Icons.group;
      case 'prayer_reminder':
        return Icons.access_time;
      case 'friend_activity':
        return Icons.person;
      case 'booking_update':
        return Icons.calendar_today;
      case 'cultural_event':
        return Icons.celebration;
      default:
        return Icons.notifications;
    }
  }

  static Color getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return AppTheme.moroccoGreen;
    }
  }

  static String getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${(difference.inDays / 7).floor()}w ago';
    }
  }
}