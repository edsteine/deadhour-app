import 'package:flutter/material.dart';
import '../../services/notification_service.dart';
import '../../utils/theme.dart';
import '../../routes/app_routes.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _notificationService = NotificationService();
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final allNotifications = _notificationService.getAllNotifications();
    final unreadCount = _notificationService.getUnreadCount();
    final stats = _notificationService.getNotificationStats();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          _buildStatsHeader(stats),
          Expanded(
            child: _buildFilteredNotificationsList(),
          ),
        ],
      ),
    );
  }

  // Method to update filter from external source (MainNavigationScreen)
  void updateFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  // Method to mark all as read from external source
  void markAllAsRead() {
    setState(() {
      _notificationService.markAllAsRead();
    });
  }

  Widget _buildFilteredNotificationsList() {
    List<Map<String, dynamic>> notifications;
    
    switch (_selectedFilter) {
      case 'deals':
        notifications = _notificationService.getNotificationsByCategory('deals');
        break;
      case 'community':
        notifications = _notificationService.getNotificationsByCategory('community');
        break;
      case 'social':
        notifications = _notificationService.getNotificationsByCategory('social');
        break;
      case 'cultural':
        notifications = _notificationService.getNotificationsByCategory('cultural');
        break;
      default:
        notifications = _notificationService.getAllNotifications();
        break;
    }

    return _buildNotificationsList(notifications);
  }

  Widget _buildStatsHeader(Map<String, dynamic> stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              'Total',
              '${stats['total']}',
              Icons.notifications,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatItem(
              'Unread',
              '${stats['unread']}',
              Icons.mark_email_unread,
              Colors.orange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatItem(
              'Read Rate',
              '${stats['readRate']}%',
              Icons.check_circle,
              Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
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

  Widget _buildNotificationsList(List<Map<String, dynamic>> notifications) {
    if (notifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isUnread = !notification['isRead'];
    final timestamp = notification['timestamp'] as DateTime;
    final timeAgo = _getTimeAgo(timestamp);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: InkWell(
          onTap: () {
            _handleNotificationTap(notification);
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: isUnread 
                  ? Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3), width: 2)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getNotificationColor(notification['type']).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getNotificationIcon(notification['type']),
                        color: _getNotificationColor(notification['type']),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  notification['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                                    color: isUnread ? AppTheme.primaryText : AppTheme.secondaryText,
                                  ),
                                ),
                              ),
                              if (isUnread)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppTheme.moroccoGreen,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notification['body'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.secondaryText,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(notification['priority']).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  notification['priority'].toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getPriorityColor(notification['priority']),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                timeAgo,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.lightText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (notification['actionUrl'] != null) ...[
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () => _navigateToAction(notification['actionUrl']),
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text('View Details'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: AppTheme.lightText,
          ),
          SizedBox(height: 16),
          Text(
            'No notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.secondaryText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Stay tuned for updates and alerts',
            style: TextStyle(color: AppTheme.lightText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    // Mark as read
    setState(() {
      _notificationService.markAsRead(notification['id']);
    });

    // Navigate if action URL exists
    if (notification['actionUrl'] != null) {
      _navigateToAction(notification['actionUrl']);
    }
  }

  void _navigateToAction(String actionUrl) {
    // Parse action URL and navigate accordingly
    if (actionUrl.startsWith('/venue/')) {
      final venueId = actionUrl.split('/')[2];
      AppNavigation.goToVenueDetail(context, venueId);
    }
    // Add more navigation cases as needed
  }


  Color _getNotificationColor(String type) {
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

  IconData _getNotificationIcon(String type) {
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

  Color _getPriorityColor(String priority) {
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

  String _getTimeAgo(DateTime timestamp) {
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