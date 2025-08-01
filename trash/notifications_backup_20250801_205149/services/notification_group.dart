/// Grouped notifications to reduce noise
class NotificationGroup {
  final String id;
  final String type;
  final String title;
  final List<Map<String, dynamic>> notifications;
  String priority;
  DateTime lastUpdated;
  final bool canDefer;

  NotificationGroup({
    required this.id,
    required this.type,
    required this.title,
    required this.notifications,
    required this.priority,
    required this.lastUpdated,
    required this.canDefer,
  });

  int get count => notifications.length;
  
  String get summary {
    if (notifications.length == 1) {
      return notifications.first['title'] as String;
    }
    return '$count notifications';
  }
}