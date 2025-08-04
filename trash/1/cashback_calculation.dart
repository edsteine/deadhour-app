/// Cashback calculation details
class CashbackCalculation {
  final double bookingAmount;
  final double baseRate;
  final double deadHourMultiplier;
  final double tierBonus;
  final double dealBonus;
  final double finalRate;
  final double cashbackAmount;
  final DateTime estimatedAvailableDate;

  CashbackCalculation({
    required this.bookingAmount,
    required this.baseRate,
    required this.deadHourMultiplier,
    required this.tierBonus,
    required this.dealBonus,
    required this.finalRate,
    required this.cashbackAmount,
    required this.estimatedAvailableDate,
  });
}