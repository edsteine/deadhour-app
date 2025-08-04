import '../services/notification_service.dart';
import '../services/smart_notification_service.dart';
import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../utils/notification_helpers.dart';
import 'notification_card.dart';
import 'empty_state.dart';

class GroupedNotificationsList extends StatelessWidget {
  final SmartNotificationService smartNotificationService;
  final NotificationService notificationService;

  const GroupedNotificationsList({
    super.key,
    required this.smartNotificationService,
    required this.notificationService,
  });

  @override
  Widget build(BuildContext context) {
    final groups = smartNotificationService.getGroupedNotifications();
    
    if (groups.isEmpty) {
      return const NotificationEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return _buildNotificationGroupCard(group);
      },
    );
  }

  Widget _buildNotificationGroupCard(NotificationGroup group) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: ExpansionTile(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: NotificationHelpers.getNotificationColor(group.type).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  NotificationHelpers.getNotificationIcon(group.type),
                  color: NotificationHelpers.getNotificationColor(group.type),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${group.count} notifications',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: NotificationHelpers.getPriorityColor(group.priority).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  group.priority.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: NotificationHelpers.getPriorityColor(group.priority),
                  ),
                ),
              ),
            ],
          ),
          children: group.notifications.map((notification) => 
            Container(
              padding: const EdgeInsets.all(16),
              child: NotificationCard(
                notification: notification,
                onTap: () => _handleNotificationTap(notification),
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    notificationService.markAsRead(notification['id']);
  }
}