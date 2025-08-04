class DealRating {
  final String dealId;
  final double averageRating;
  final int totalRatings;
  final Map<int, int> ratingBreakdown;
  final double valueForMoney;
  final double quality;
  final double service;
  final double authenticity;

  DealRating({
    required this.dealId,
    required this.averageRating,
    required this.totalRatings,
    required this.ratingBreakdown,
    required this.valueForMoney,
    required this.quality,
    required this.service,
    required this.authenticity,
  });
}