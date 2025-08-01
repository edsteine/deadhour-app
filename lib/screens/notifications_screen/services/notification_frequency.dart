/// Notification frequency limits
class NotificationFrequency {
  final int maxPerHour;
  final int maxPerDay;
  final int cooldownMinutes;

  NotificationFrequency({
    required this.maxPerHour,
    required this.maxPerDay,
    required this.cooldownMinutes,
  });
}