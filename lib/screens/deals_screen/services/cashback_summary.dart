


/// Cashback summary for UI display
class CashbackSummary {
  final double totalEarned;
  final double pendingAmount;
  final double availableAmount;
  final double thisMonthEarned;
  final CashbackTier tier;
  final TierRequirement? nextTierRequirement;
  final int bookingsThisMonth;
  final double spentThisMonth;

  CashbackSummary({
    required this.totalEarned,
    required this.pendingAmount,
    required this.availableAmount,
    required this.thisMonthEarned,
    required this.tier,
    this.nextTierRequirement,
    required this.bookingsThisMonth,
    required this.spentThisMonth,
  });
}