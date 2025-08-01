import 'services/notification_service.dart';
import 'services/smart_notification_service.dart';
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import 'widgets/smart_header.dart';
import 'widgets/stats_header.dart';
import 'widgets/notifications_list.dart';
import 'widgets/grouped_notifications_list.dart';
import 'widgets/relevant_notifications_list.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _notificationService = NotificationService();
  final _smartNotificationService = SmartNotificationService();
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _smartNotificationService.initializeSmartNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final smartSummary = _smartNotificationService.getSmartSummary();
    final stats = _notificationService.getNotificationStats();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          SmartNotificationHeader(summary: smartSummary),
          NotificationStatsHeader(stats: stats),
          Expanded(
            child: _buildFilteredNotificationsList(),
          ),
        ],
      ),
    );
  }

  void updateFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void markAllAsRead() {
    setState(() {
      _notificationService.markAllAsRead();
    });
  }

  Widget _buildFilteredNotificationsList() {
    switch (_selectedFilter) {
      case 'grouped':
        return GroupedNotificationsList(
          smartNotificationService: _smartNotificationService,
          notificationService: _notificationService,
        );
      case 'relevant':
        return RelevantNotificationsList(
          smartNotificationService: _smartNotificationService,
          notificationService: _notificationService,
        );
      default:
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
        return NotificationsList(
          notifications: notifications,
          notificationService: _notificationService,
        );
    }
  }
}