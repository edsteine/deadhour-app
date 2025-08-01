import 'dart:async';

import '../../../utils/mock_data.dart';
import '../models/deal.dart';
import 'cashback_calculation.dart';
import 'cashback_status.dart';
import 'cashback_summary.dart';
import 'cashback_tier.dart';
import 'cashback_transaction.dart';
import 'tier_requirement.dart';
import 'withdrawal_method.dart';


/// Cashback service for user retention and financial incentives
/// Following RetailMeNot/Rakuten model but for Morocco's dead hours
class CashbackService {
  static final CashbackService _instance = CashbackService._internal();
  factory CashbackService() => _instance;
  CashbackService._internal();

  // User cashback balance and history
  double _totalCashback = 0.0;
  double _pendingCashback = 0.0;
  double _availableCashback = 0.0;
  final List<CashbackTransaction> _transactions = [];
  
  // Cashback rates by category (percentage of booking amount)
  final Map<String, double> _categoryRates = {
    'food': 0.08, // 8% cashback on food
    'entertainment': 0.06, // 6% cashback on entertainment
    'wellness': 0.10, // 10% cashback on wellness (highest incentive)
    'tourism': 0.12, // 12% cashback on tourism (attract tourists)
    'default': 0.05, // 5% default cashback
  };

  // Special cashback multipliers for dead hours
  final Map<String, double> _deadHourMultipliers = {
    'morning': 1.5, // 6am-11am: 1.5x multiplier
    'afternoon': 2.0, // 2pm-5pm: 2x multiplier (peak dead hours)
    'evening': 1.3, // 8pm-10pm: 1.3x multiplier
    'late_night': 1.8, // 10pm-12am: 1.8x multiplier
  };

  // Loyalty tier system
  CashbackTier _userTier = CashbackTier.bronze;
  int _bookingsThisMonth = 0;
  double _spentThisMonth = 0.0;

  /// Get user's total cashback earned
  double get totalCashback => _totalCashback;
  
  /// Get pending cashback (not yet available for withdrawal)
  double get pendingCashback => _pendingCashback;
  
  /// Get available cashback (ready for withdrawal/use)
  double get availableCashback => _availableCashback;
  
  /// Get user's current cashback tier
  CashbackTier get userTier => _userTier;
  
  /// Get all cashback transactions
  List<CashbackTransaction> get transactions => List.unmodifiable(_transactions);

  /// Calculate cashback for a deal booking
  CashbackCalculation calculateCashback(Deal deal, double bookingAmount) {
    final venue = MockData.venues.firstWhere(
      (v) => v.id == deal.venueId,
      orElse: () => MockData.venues.first,
    );

    // Base cashback rate by category
    double baseRate = _categoryRates[venue.category] ?? _categoryRates['default']!;
    
    // Dead hour multiplier
    double deadHourMultiplier = _getDeadHourMultiplier();
    
    // Tier bonus
    double tierBonus = _getTierBonus();
    
    // Special deal bonus (higher cashback for higher discounts)
    double dealBonus = _getDealBonus(deal);
    
    // Calculate final rate
    double finalRate = baseRate * deadHourMultiplier * (1 + tierBonus + dealBonus);
    
    // Cap at 25% to prevent abuse
    finalRate = finalRate.clamp(0.0, 0.25);
    
    double cashbackAmount = bookingAmount * finalRate;
    
    return CashbackCalculation(
      bookingAmount: bookingAmount,
      baseRate: baseRate,
      deadHourMultiplier: deadHourMultiplier,
      tierBonus: tierBonus,
      dealBonus: dealBonus,
      finalRate: finalRate,
      cashbackAmount: cashbackAmount,
      estimatedAvailableDate: DateTime.now().add(const Duration(days: 3)), // 3 days processing
    );
  }

  /// Process cashback after successful booking
  Future<CashbackTransaction> processCashback(Deal deal, double bookingAmount) async {
    final calculation = calculateCashback(deal, bookingAmount);
    final venue = MockData.venues.firstWhere(
      (v) => v.id == deal.venueId,
      orElse: () => MockData.venues.first,
    );

    final transaction = CashbackTransaction(
      id: 'cb_${DateTime.now().millisecondsSinceEpoch}',
      dealId: deal.id,
      venueId: deal.venueId,
      venueName: venue.name,
      bookingAmount: bookingAmount,
      cashbackAmount: calculation.cashbackAmount,
      cashbackRate: calculation.finalRate,
      status: CashbackStatus.pending,
      createdAt: DateTime.now(),
      availableAt: calculation.estimatedAvailableDate,
      category: venue.category,
      tierAtTime: _userTier,
    );

    _transactions.insert(0, transaction); // Add to beginning
    _pendingCashback += calculation.cashbackAmount;
    _totalCashback += calculation.cashbackAmount;
    
    // Update user stats
    _bookingsThisMonth++;
    _spentThisMonth += bookingAmount;
    _updateUserTier();

    // Schedule cashback to become available (in real app, this would be a background job)
    Timer(const Duration(seconds: 5), () {
      _makeCashbackAvailable(transaction.id);
    });

    return transaction;
  }

  /// Make pending cashback available for withdrawal
  void _makeCashbackAvailable(String transactionId) {
    final transactionIndex = _transactions.indexWhere((t) => t.id == transactionId);
    if (transactionIndex != -1) {
      final transaction = _transactions[transactionIndex];
      if (transaction.status == CashbackStatus.pending) {
        _transactions[transactionIndex] = transaction.copyWith(
          status: CashbackStatus.available,
          availableAt: DateTime.now(),
        );
        _pendingCashback -= transaction.cashbackAmount;
        _availableCashback += transaction.cashbackAmount;
      }
    }
  }

  /// Withdraw available cashback
  Future<bool> withdrawCashback(double amount, WithdrawalMethod method) async {
    if (amount > _availableCashback) return false;
    if (amount < 10.0) return false; // Minimum withdrawal of 10 MAD

    final withdrawal = CashbackTransaction(
      id: 'wd_${DateTime.now().millisecondsSinceEpoch}',
      dealId: null,
      venueId: null,
      venueName: 'Withdrawal',
      bookingAmount: 0.0,
      cashbackAmount: -amount,
      cashbackRate: 0.0,
      status: CashbackStatus.used,
      createdAt: DateTime.now(),
      availableAt: DateTime.now(),
      category: 'withdrawal',
      tierAtTime: _userTier,
      withdrawalMethod: method,
    );

    _transactions.insert(0, withdrawal);
    _availableCashback -= amount;

    return true;
  }

  /// Get dead hour multiplier based on current time
  double _getDeadHourMultiplier() {
    final hour = DateTime.now().hour;
    
    if (hour >= 6 && hour < 11) return _deadHourMultipliers['morning']!;
    if (hour >= 14 && hour < 17) return _deadHourMultipliers['afternoon']!;
    if (hour >= 20 && hour < 22) return _deadHourMultipliers['evening']!;
    if (hour >= 22 || hour < 2) return _deadHourMultipliers['late_night']!;
    
    return 1.0; // No multiplier for regular hours
  }

  /// Get tier bonus percentage
  double _getTierBonus() {
    switch (_userTier) {
      case CashbackTier.bronze:
        return 0.0; // No bonus
      case CashbackTier.silver:
        return 0.2; // 20% bonus
      case CashbackTier.gold:
        return 0.5; // 50% bonus
      case CashbackTier.platinum:
        return 1.0; // 100% bonus
    }
  }

  /// Get deal bonus based on discount percentage
  double _getDealBonus(Deal deal) {
    if (deal.discountValue >= 50) return 0.3; // 30% bonus for 50%+ discounts
    if (deal.discountValue >= 30) return 0.2; // 20% bonus for 30%+ discounts
    if (deal.discountValue >= 20) return 0.1; // 10% bonus for 20%+ discounts
    return 0.0; // No bonus
  }

  /// Update user tier based on monthly activity
  void _updateUserTier() {
    if (_bookingsThisMonth >= 20 && _spentThisMonth >= 2000) {
      _userTier = CashbackTier.platinum;
    } else if (_bookingsThisMonth >= 10 && _spentThisMonth >= 1000) {
      _userTier = CashbackTier.gold;
    } else if (_bookingsThisMonth >= 5 && _spentThisMonth >= 500) {
      _userTier = CashbackTier.silver;
    } else {
      _userTier = CashbackTier.bronze;
    }
  }

  /// Get cashback summary for display
  CashbackSummary getCashbackSummary() {
    final thisMonthTransactions = _transactions.where((t) => 
      t.createdAt.isAfter(DateTime.now().subtract(const Duration(days: 30))) &&
      t.cashbackAmount > 0
    );

    return CashbackSummary(
      totalEarned: _totalCashback,
      pendingAmount: _pendingCashback,
      availableAmount: _availableCashback,
      thisMonthEarned: thisMonthTransactions.fold(0.0, (sum, t) => sum + t.cashbackAmount),
      tier: _userTier,
      nextTierRequirement: _getNextTierRequirement(),
      bookingsThisMonth: _bookingsThisMonth,
      spentThisMonth: _spentThisMonth,
    );
  }

  /// Get requirements for next tier
  TierRequirement? _getNextTierRequirement() {
    switch (_userTier) {
      case CashbackTier.bronze:
        return TierRequirement(
          tier: CashbackTier.silver,
          bookingsNeeded: (5 - _bookingsThisMonth).clamp(0, 5),
          spendingNeeded: (500 - _spentThisMonth).clamp(0, 500),
        );
      case CashbackTier.silver:
        return TierRequirement(
          tier: CashbackTier.gold,
          bookingsNeeded: (10 - _bookingsThisMonth).clamp(0, 10),
          spendingNeeded: (1000 - _spentThisMonth).clamp(0, 1000),
        );
      case CashbackTier.gold:
        return TierRequirement(
          tier: CashbackTier.platinum,
          bookingsNeeded: (20 - _bookingsThisMonth).clamp(0, 20),
          spendingNeeded: (2000 - _spentThisMonth).clamp(0, 2000),
        );
      case CashbackTier.platinum:
        return null; // Already at highest tier
    }
  }

  /// Initialize with sample data
  void initializeSampleData() {
    _totalCashback = 142.50;
    _availableCashback = 87.30;
    _pendingCashback = 55.20;
    _bookingsThisMonth = 7;
    _spentThisMonth = 680.0;
    _userTier = CashbackTier.silver;

    // Add sample transactions
    _transactions.addAll([
      CashbackTransaction(
        id: 'cb_1',
        dealId: 'deal_1',
        venueId: 'venue_1',
        venueName: 'Café Atlas',
        bookingAmount: 120.0,
        cashbackAmount: 15.60,
        cashbackRate: 0.13,
        status: CashbackStatus.available,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        availableAt: DateTime.now().subtract(const Duration(hours: 2)),
        category: 'food',
        tierAtTime: CashbackTier.silver,
      ),
      CashbackTransaction(
        id: 'cb_2',
        dealId: 'deal_2',
        venueId: 'venue_2',
        venueName: 'Royal Spa',
        bookingAmount: 200.0,
        cashbackAmount: 32.0,
        cashbackRate: 0.16,
        status: CashbackStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        availableAt: DateTime.now().add(const Duration(days: 2)),
        category: 'wellness',
        tierAtTime: CashbackTier.silver,
      ),
    ]);
  }
}

