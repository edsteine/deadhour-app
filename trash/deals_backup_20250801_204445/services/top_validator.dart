class TopValidator {
  final String userId;
  final String userName;
  final String avatar;
  final double trustScore;
  final int totalValidations;
  final String badge;
  final List<String> specialties;

  TopValidator({
    required this.userId,
    required this.userName,
    required this.avatar,
    required this.trustScore,
    required this.totalValidations,
    required this.badge,
    required this.specialties,
  });
}