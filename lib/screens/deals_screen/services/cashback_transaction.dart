



/// Cashback transaction record
class CashbackTransaction {
  final String id;
  final String? dealId;
  final String? venueId;
  final String venueName;
  final double bookingAmount;
  final double cashbackAmount;
  final double cashbackRate;
  final CashbackStatus status;
  final DateTime createdAt;
  final DateTime availableAt;
  final String category;
  final CashbackTier tierAtTime;
  final WithdrawalMethod? withdrawalMethod;

  CashbackTransaction({
    required this.id,
    this.dealId,
    this.venueId,
    required this.venueName,
    required this.bookingAmount,
    required this.cashbackAmount,
    required this.cashbackRate,
    required this.status,
    required this.createdAt,
    required this.availableAt,
    required this.category,
    required this.tierAtTime,
    this.withdrawalMethod,
  });

  CashbackTransaction copyWith({
    CashbackStatus? status,
    DateTime? availableAt,
  }) {
    return CashbackTransaction(
      id: id,
      dealId: dealId,
      venueId: venueId,
      venueName: venueName,
      bookingAmount: bookingAmount,
      cashbackAmount: cashbackAmount,
      cashbackRate: cashbackRate,
      status: status ?? this.status,
      createdAt: createdAt,
      availableAt: availableAt ?? this.availableAt,
      category: category,
      tierAtTime: tierAtTime,
      withdrawalMethod: withdrawalMethod,
    );
  }
}