

class ValidationSummary {
  final String dealId;
  final int totalValidations;
  final int confirmedCount;
  final int warningCount;
  final int verifiedCount;
  final double trustScore;
  final double averageRating;
  final int totalRatings;
  final CommunityStatus communityStatus;

  ValidationSummary({
    required this.dealId,
    required this.totalValidations,
    required this.confirmedCount,
    required this.warningCount,
    required this.verifiedCount,
    required this.trustScore,
    required this.averageRating,
    required this.totalRatings,
    required this.communityStatus,
  });
}