import 'package:deadhour/services/validation/validation_types.dart';

class DealValidation {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String dealId;
  final ValidationType validationType;
  final String comment;
  final DateTime timestamp;
  int helpfulCount;
  final List<String> photos;
  final List<String> tags;

  DealValidation({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.dealId,
    required this.validationType,
    required this.comment,
    required this.timestamp,
    required this.helpfulCount,
    required this.photos,
    required this.tags,
  });
}