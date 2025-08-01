

/// Tier requirement for next level
class TierRequirement {
  final CashbackTier tier;
  final int bookingsNeeded;
  final double spendingNeeded;

  TierRequirement({
    required this.tier,
    required this.bookingsNeeded,
    required this.spendingNeeded,
  });
}