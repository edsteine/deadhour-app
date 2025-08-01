


/// Smart notification with relevance scoring
class SmartNotification {
  final Map<String, dynamic> notification;
  final double relevanceScore;
  final bool shouldGroup;
  final bool canDefer;
  final NotificationSuggestedAction suggestedAction;

  SmartNotification({
    required this.notification,
    required this.relevanceScore,
    required this.shouldGroup,
    required this.canDefer,
    required this.suggestedAction,
  });
}