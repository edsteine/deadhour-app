class UserRating {
  final int overall;
  final double valueForMoney;
  final double quality;
  final double service;
  final double authenticity;
  final String? comment;

  UserRating({
    required this.overall,
    required this.valueForMoney,
    required this.quality,
    required this.service,
    required this.authenticity,
    this.comment,
  });
}