/// Smart notification summary
class NotificationSummary {
  final int totalNotifications;
  final int groupedCount;
  final int reductionPercentage;
  final int highPriorityCount;
  final int canDefer;
  final DateTime nextDigestTime;

  NotificationSummary({
    required this.totalNotifications,
    required this.groupedCount,
    required this.reductionPercentage,
    required this.highPriorityCount,
    required this.canDefer,
    required this.nextDigestTime,
  });
}