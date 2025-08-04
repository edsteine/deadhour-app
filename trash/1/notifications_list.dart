import 'package:flutter/material.dart';

import '../../../utils/app_routes.dart';
import '../services/notification_service.dart';
import 'empty_state.dart';
import 'notification_card.dart';

class NotificationsList extends StatelessWidget {
  final List<Map<String, dynamic>> notifications;
  final NotificationService notificationService;

  const NotificationsList({
    super.key,
    required this.notifications,
    required this.notificationService,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const NotificationEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationCard(
          notification: notification,
          onTap: () => _handleNotificationTap(context, notification),
        );
      },
    );
  }

  void _handleNotificationTap(BuildContext context, Map<String, dynamic> notification) {
    // Mark as read
    notificationService.markAsRead(notification['id']);

    // Navigate if action URL exists
    if (notification['actionUrl'] != null) {
      _navigateToAction(context, notification['actionUrl']);
    }
  }

  void _navigateToAction(BuildContext context, String actionUrl) {
    // Parse action URL and navigate accordingly
    if (actionUrl.startsWith('/venue/')) {
      final venueId = actionUrl.split('/')[2];
      AppNavigation.goToVenueDetail(context, venueId);
    }
    // Add more navigation cases as needed
  }
}