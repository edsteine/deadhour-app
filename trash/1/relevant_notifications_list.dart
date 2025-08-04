import '../services/notification_service.dart';
import '../services/smart_notification_service.dart';
import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import 'notification_card.dart';
import 'empty_state.dart';

class RelevantNotificationsList extends StatelessWidget {
  final SmartNotificationService smartNotificationService;
  final NotificationService notificationService;

  const RelevantNotificationsList({
    super.key,
    required this.smartNotificationService,
    required this.notificationService,
  });

  @override
  Widget build(BuildContext context) {
    final relevantNotifications = smartNotificationService.getRelevantNotifications(limit: 20);
    
    if (relevantNotifications.isEmpty) {
      return const NotificationEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: relevantNotifications.length,
      itemBuilder: (context, index) {
        final smartNotification = relevantNotifications[index];
        return _buildSmartNotificationCard(smartNotification);
      },
    );
  }

  Widget _buildSmartNotificationCard(SmartNotification smartNotification) {
    final notification = smartNotification.notification;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: InkWell(
          onTap: () {
            _handleNotificationTap(notification);
            smartNotificationService.recordInteraction(
              notification['id'] as String,
              NotificationInteraction.tapped,
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Relevance indicator
                    Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getRelevanceColor(smartNotification.relevanceScore),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Notification content
                    Expanded(
                      child: NotificationCard(
                        notification: notification,
                        onTap: () => _handleNotificationTap(notification),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Smart indicators
                    Column(
                      children: [
                        Text(
                          '${(smartNotification.relevanceScore * 100).round()}%',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getRelevanceColor(smartNotification.relevanceScore),
                          ),
                        ),
                        const Text(
                          'relevant',
                          style: TextStyle(
                            fontSize: 8,
                            color: AppTheme.lightText,
                          ),
                        ),
                        if (smartNotification.canDefer) ...[
                          const SizedBox(height: 4),
                          const Icon(
                            Icons.schedule,
                            size: 12,
                            color: AppTheme.secondaryText,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    notificationService.markAsRead(notification['id']);
  }

  Color _getRelevanceColor(double relevanceScore) {
    if (relevanceScore >= 0.8) return Colors.green;
    if (relevanceScore >= 0.6) return Colors.orange;
    if (relevanceScore >= 0.4) return Colors.blue;
    return Colors.grey;
  }
}