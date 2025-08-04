/// Individual digest item
class DigestItem {
  final String type;
  final int count;
  final String summary;
  final List<Map<String, dynamic>> notifications;
  final String priority;

  DigestItem({
    required this.type,
    required this.count,
    required this.summary,
    required this.notifications,
    required this.priority,
  });
}