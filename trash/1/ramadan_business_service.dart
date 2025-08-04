/// Ramadan Business Optimization Service for DeadHour
/// Focused on seasonal dead hours optimization during Ramadan
/// Business logic only - no UI components
class RamadanBusinessService {
  static final RamadanBusinessService _instance = RamadanBusinessService._internal();
  factory RamadanBusinessService() => _instance;
  RamadanBusinessService._internal();

  // Ramadan dates (would be calculated from Islamic calendar in production)
  final DateTime _ramadanStart = DateTime(2024, 3, 11);
  final DateTime _ramadanEnd = DateTime(2024, 4, 9);

  /// Check if current date is during Ramadan
  bool isRamadanSeason() {
    final now = DateTime.now();
    return now.isAfter(_ramadanStart) && now.isBefore(_ramadanEnd);
  }

  /// Get Ramadan-optimized business hours recommendations
  /// Key business optimization: venues can capitalize on extended evening hours
  Map<String, dynamic> getRamadanBusinessOptimization() {
    if (!isRamadanSeason()) return {};
    
    return {
      'season': 'Ramadan',
      'optimizedHours': {
        'morning': '10:00-15:00', // Reduced morning hours
        'evening': '20:00-01:00', // Extended post-Iftar hours
        'lateNight': '01:00-03:00', // Suhoor preparation period
      },
      'deadHourOpportunities': {
        'preIftar': {
          'timeSlot': '16:00-19:30',
          'strategy': 'Deep discounts for early bookings',
          'targetAudience': 'Non-fasting tourists and locals',
          'discountRecommendation': '40-60%',
        },
        'postIftar': {
          'timeSlot': '20:30-23:00',
          'strategy': 'Premium social dining experiences',
          'targetAudience': 'Families and social groups',
          'premiumPricing': true,
        },
        'suhoor': {
          'timeSlot': '02:00-05:00',
          'strategy': 'Late night dining and entertainment',
          'targetAudience': 'Young adults and night owls',
          'specialOffers': 'Suhoor meal packages',
        },
      },
      'revenueMultiplier': 1.3, // 30% potential revenue increase
    };
  }

  /// Get Ramadan seasonal deal recommendations
  List<Map<String, dynamic>> getRamadanDealStrategies() {
    if (!isRamadanSeason()) return [];

    return [
      {
        'dealType': 'Pre-Iftar Deep Discount',
        'timeSlot': '16:00-19:30',
        'discountRange': '40-60%',
        'businessBenefit': 'Fill dead hours before Iftar rush',
        'targetRevenue': 'Fill 70% of pre-Iftar capacity',
      },
      {
        'dealType': 'Post-Iftar Social Packages',
        'timeSlot': '20:30-23:00',
        'discountRange': '10-25%',
        'businessBenefit': 'Capitalize on social dining surge',
        'targetRevenue': 'Premium pricing with volume',
      },
      {
        'dealType': 'Suhoor Late Night Specials',
        'timeSlot': '02:00-05:00',
        'discountRange': '20-35%',
        'businessBenefit': 'Extend operating hours profitably',
        'targetRevenue': 'New revenue stream',
      },
      {
        'dealType': 'Tourist Opportunity Deals',
        'timeSlot': 'All day',
        'discountRange': '15-30%',
        'businessBenefit': 'Capture non-fasting tourist market',
        'targetRevenue': 'Maintain daytime revenue',
      },
    ];
  }

  /// Calculate Ramadan revenue optimization metrics
  Map<String, dynamic> calculateRamadanMetrics(Map<String, dynamic> venueData) {
    if (!isRamadanSeason()) return {'ramadanOptimization': false};

    final baseRevenue = venueData['averageDailyRevenue'] ?? 1000.0;
    final currentCapacity = venueData['averageCapacity'] ?? 0.6;
    
    return {
      'ramadanOptimization': true,
      'seasonalStrategy': {
        'preIftarFill': {
          'currentCapacity': '${(currentCapacity * 0.3 * 100).round()}%',
          'targetCapacity': '70%',
          'revenueOpportunity': (baseRevenue * 0.4 * 0.5).round(), // 40% discount, 50% price
        },
        'postIftarPremium': {
          'currentCapacity': '${(currentCapacity * 0.9 * 100).round()}%',
          'targetCapacity': '95%',
          'revenueOpportunity': (baseRevenue * 1.2).round(), // 20% premium
        },
        'suhoorExtension': {
          'currentCapacity': '0%', // New hours
          'targetCapacity': '40%',
          'revenueOpportunity': (baseRevenue * 0.3).round(), // Additional 30%
        },
      },
      'totalPotentialIncrease': '30-50%',
      'estimatedExtraRevenue': (baseRevenue * 0.4).round(),
    };
  }

  /// Get Ramadan business timeline (key dates for marketing)
  List<Map<String, dynamic>> getRamadanBusinessTimeline() {
    if (!isRamadanSeason()) return [];

    final today = DateTime.now();
    final daysIntoRamadan = today.difference(_ramadanStart).inDays;
    final daysRemaining = _ramadanEnd.difference(today).inDays;

    return [
      {
        'phase': 'Early Ramadan',
        'days': '1-10',
        'strategy': 'Establish new customer habits',
        'focus': 'Build awareness of extended hours',
        'current': daysIntoRamadan <= 10,
      },
      {
        'phase': 'Mid Ramadan',
        'days': '11-20',
        'strategy': 'Optimize pricing and capacity',
        'focus': 'Fine-tune dead hour strategies',
        'current': daysIntoRamadan > 10 && daysIntoRamadan <= 20,
      },
      {
        'phase': 'Late Ramadan',
        'days': '21-30',
        'strategy': 'Maximize revenue before Eid',
        'focus': 'Premium experiences and packages',
        'current': daysIntoRamadan > 20,
      },
    ];
  }

  /// Check if a given time slot has Ramadan optimization opportunity
  bool hasRamadanOpportunity(String timeSlot) {
    if (!isRamadanSeason()) return false;

    final hour = int.tryParse(timeSlot.split(':')[0]) ?? 0;
    
    // Pre-Iftar dead hours (16:00-19:30)
    if (hour >= 16 && hour < 20) return true;
    
    // Post-Iftar social hours (20:30-23:00)
    if (hour >= 20 && hour < 23) return true;
    
    // Suhoor hours (02:00-05:00)
    if (hour >= 2 && hour < 5) return true;
    
    return false;
  }

  /// Get recommended discount for Ramadan time slot
  String getRecommendedDiscount(String timeSlot) {
    if (!isRamadanSeason()) return '0%';

    final hour = int.tryParse(timeSlot.split(':')[0]) ?? 0;
    
    // Pre-Iftar: Deep discounts to fill dead hours
    if (hour >= 16 && hour < 20) return '40-60%';
    
    // Post-Iftar: Moderate discounts for volume
    if (hour >= 20 && hour < 23) return '10-25%';
    
    // Suhoor: Good discounts for extended hours
    if (hour >= 2 && hour < 5) return '20-35%';
    
    return '15-30%'; // Default tourist opportunity
  }

  /// Get Ramadan business insights for venue owners
  Map<String, dynamic> getBusinessInsights() {
    if (!isRamadanSeason()) return {};

    return {
      'keyInsights': [
        'Pre-Iftar hours (16:00-19:30) are major dead hour opportunities',
        'Post-Iftar dining surge can support premium pricing',
        'Extended Suhoor hours create new revenue streams',
        'Tourist market remains active during daytime',
      ],
      'actionItems': [
        'Implement tiered pricing for different Ramadan time slots',
        'Create special Iftar and Suhoor menu packages',
        'Target non-fasting tourists during traditional dead hours',
        'Extend operating hours to capture Suhoor market',
      ],
      'successMetrics': [
        'Pre-Iftar capacity utilization above 70%',
        'Post-Iftar revenue per customer increase of 20%+',
        'New Suhoor revenue stream covering operational costs',
        'Overall Ramadan revenue increase of 30-50%',
      ],
    };
  }

  /// Check if Ramadan season is ending soon (last 5 days)
  bool isRamadanEndingSoon() {
    if (!isRamadanSeason()) return false;
    
    final now = DateTime.now();
    final daysRemaining = _ramadanEnd.difference(now).inDays;
    return daysRemaining <= 5;
  }

  /// Get post-Ramadan transition strategy
  Map<String, dynamic> getPostRamadanStrategy() {
    return {
      'transition': 'Post-Ramadan Normalization',
      'timeline': '1-2 weeks after Eid',
      'strategy': [
        'Gradually return to normal operating hours',
        'Maintain successful extended evening offerings',
        'Analyze Ramadan performance data',
        'Plan for next Ramadan season',
      ],
      'retainedBenefits': [
        'Extended evening hours if profitable',
        'Tourist-focused daytime strategies',
        'Improved capacity management skills',
        'Seasonal pricing expertise',
      ],
    };
  }
}