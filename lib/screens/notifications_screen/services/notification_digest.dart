

/// Notification digest to batch updates
class NotificationDigest {
  final Duration period;
  final int totalNotifications;
  final List<DigestItem> items;
  final DateTime generatedAt;

  NotificationDigest({
    required this.period,
    required this.totalNotifications,
    required this.items,
    required this.generatedAt,
  });
}