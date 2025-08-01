import 'package:flutter/material.dart';





class DealSuggestionsService {
  static final DealSuggestionsService _instance =
      DealSuggestionsService._internal();
  factory DealSuggestionsService() => _instance;
  DealSuggestionsService._internal();

  // Smart suggestions based on business context
  List<DealSuggestion> generateSuggestions({
    required String businessType,
    required TimeOfDay currentTime,
    required String city,
    required int dayOfWeek,
  }) {
    final suggestions = <DealSuggestion>[];

    // Add category-specific suggestions
    suggestions.addAll(_getCategorySpecificSuggestions(businessType));

    // Add time-based suggestions
    suggestions.addAll(_getTimeBasedSuggestions(currentTime));

    // Add day-specific suggestions
    suggestions.addAll(_getDaySpecificSuggestions(dayOfWeek));

    // Add cultural suggestions
    suggestions.addAll(_getCulturalSuggestions(currentTime));

    // Sort by effectiveness score
    suggestions
        .sort((a, b) => b.effectivenessScore.compareTo(a.effectivenessScore));

    return suggestions.take(6).toList();
  }

  List<DealSuggestion> _getCategorySpecificSuggestions(String businessType) {
    switch (businessType) {
      case 'food':
        return [
          DealSuggestion(
            title: 'Afternoon Coffee + Pastry Combo',
            description: 'Perfect for study sessions and work meetings',
            discountPercentage: 35,
            targetTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 16, minute: 30),
            community: 'Students, remote workers love this',
            effectivenessScore: 85,
            tags: ['coffee', 'study', 'wifi'],
            icon: '☕',
          ),
          DealSuggestion(
            title: 'Early Bird Breakfast Special',
            description: 'Traditional Moroccan breakfast with mint tea',
            discountPercentage: 25,
            targetTime: const TimeOfDay(hour: 7, minute: 0),
            endTime: const TimeOfDay(hour: 9, minute: 30),
            community: 'Working professionals, tourists',
            effectivenessScore: 75,
            tags: ['breakfast', 'traditional', 'mint-tea'],
            icon: '🥞',
          ),
          DealSuggestion(
            title: 'Late Night Munchies Deal',
            description: 'Casual dining for night owls and workers',
            discountPercentage: 30,
            targetTime: const TimeOfDay(hour: 22, minute: 0),
            endTime: const TimeOfDay(hour: 1, minute: 0),
            community: 'Night shift workers, students',
            effectivenessScore: 70,
            tags: ['late-night', 'casual', 'comfort-food'],
            icon: '🌙',
          ),
        ];

      case 'entertainment':
        return [
          DealSuggestion(
            title: 'Afternoon Gaming Session',
            description: 'Beat the post-lunch energy dip with gaming',
            discountPercentage: 40,
            targetTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 17, minute: 0),
            community: 'Gamers, friends groups',
            effectivenessScore: 80,
            tags: ['gaming', 'friends', 'afternoon'],
            icon: '🎮',
          ),
          DealSuggestion(
            title: 'Weekday Movie Matinee',
            description: 'Discounted tickets for off-peak screenings',
            discountPercentage: 50,
            targetTime: const TimeOfDay(hour: 13, minute: 0),
            endTime: const TimeOfDay(hour: 16, minute: 0),
            community: 'Movie lovers, couples, retirees',
            effectivenessScore: 75,
            tags: ['movies', 'matinee', 'couples'],
            icon: '🎬',
          ),
        ];

      case 'wellness':
        return [
          DealSuggestion(
            title: 'Midday Relaxation Package',
            description: 'Perfect lunch break spa treatment',
            discountPercentage: 30,
            targetTime: const TimeOfDay(hour: 12, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 0),
            community: 'Working professionals, stressed individuals',
            effectivenessScore: 85,
            tags: ['spa', 'relaxation', 'lunch-break'],
            icon: '💆',
          ),
          DealSuggestion(
            title: 'Morning Yoga & Hammam',
            description: 'Start your day with traditional wellness',
            discountPercentage: 25,
            targetTime: const TimeOfDay(hour: 8, minute: 0),
            endTime: const TimeOfDay(hour: 11, minute: 0),
            community: 'Health enthusiasts, tourists',
            effectivenessScore: 70,
            tags: ['yoga', 'hammam', 'morning', 'traditional'],
            icon: '🧘',
          ),
        ];

      case 'sports':
        return [
          DealSuggestion(
            title: 'Afternoon Padel Special',
            description: 'Beat the heat with indoor courts',
            discountPercentage: 35,
            targetTime: const TimeOfDay(hour: 15, minute: 0),
            endTime: const TimeOfDay(hour: 18, minute: 0),
            community: 'Sports enthusiasts, friends',
            effectivenessScore: 75,
            tags: ['padel', 'indoor', 'friends'],
            icon: '🏸',
          ),
          DealSuggestion(
            title: 'Early Morning Fitness',
            description: 'Start strong before work',
            discountPercentage: 20,
            targetTime: const TimeOfDay(hour: 6, minute: 0),
            endTime: const TimeOfDay(hour: 8, minute: 30),
            community: 'Fitness enthusiasts, early risers',
            effectivenessScore: 65,
            tags: ['fitness', 'morning', 'gym'],
            icon: '💪',
          ),
        ];

      default:
        return [
          DealSuggestion(
            title: 'Dead Hours Special',
            description: 'Turn slow periods into opportunities',
            discountPercentage: 30,
            targetTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 16, minute: 0),
            community: 'Bargain hunters, flexible schedules',
            effectivenessScore: 60,
            tags: ['general', 'discount'],
            icon: '⏰',
          ),
        ];
    }
  }

  List<DealSuggestion> _getTimeBasedSuggestions(TimeOfDay currentTime) {
    final hour = currentTime.hour;

    if (hour >= 6 && hour <= 9) {
      return [
        DealSuggestion(
          title: 'Morning Boost',
          description: 'Start your day right with early bird pricing',
          discountPercentage: 25,
          targetTime: const TimeOfDay(hour: 7, minute: 0),
          endTime: const TimeOfDay(hour: 10, minute: 0),
          community: 'Early risers, commuters',
          effectivenessScore: 70,
          tags: ['morning', 'early-bird'],
          icon: '🌅',
        ),
      ];
    } else if (hour >= 14 && hour <= 16) {
      return [
        DealSuggestion(
          title: 'Afternoon Escape',
          description: 'Beat the post-lunch dip with great deals',
          discountPercentage: 35,
          targetTime: const TimeOfDay(hour: 14, minute: 0),
          endTime: const TimeOfDay(hour: 16, minute: 30),
          community: 'Remote workers, flexible schedules',
          effectivenessScore: 85,
          tags: ['afternoon', 'break'],
          icon: '☀️',
        ),
      ];
    } else if (hour >= 21) {
      return [
        DealSuggestion(
          title: 'Night Owl Special',
          description: 'For those who love the night scene',
          discountPercentage: 30,
          targetTime: const TimeOfDay(hour: 21, minute: 0),
          endTime: const TimeOfDay(hour: 1, minute: 0),
          community: 'Night owls, late workers',
          effectivenessScore: 65,
          tags: ['night', 'late'],
          icon: '🌙',
        ),
      ];
    }

    return [];
  }

  List<DealSuggestion> _getDaySpecificSuggestions(int dayOfWeek) {
    if (dayOfWeek == DateTime.monday) {
      return [
        DealSuggestion(
          title: 'Monday Motivation',
          description: 'Start your week strong with special pricing',
          discountPercentage: 25,
          targetTime: const TimeOfDay(hour: 12, minute: 0),
          endTime: const TimeOfDay(hour: 18, minute: 0),
          community: 'Everyone needs Monday motivation',
          effectivenessScore: 70,
          tags: ['monday', 'motivation'],
          icon: '💪',
        ),
      ];
    } else if (dayOfWeek == DateTime.friday) {
      return [
        DealSuggestion(
          title: 'Friday Celebration',
          description: 'End the week on a high note',
          discountPercentage: 30,
          targetTime: const TimeOfDay(hour: 17, minute: 0),
          endTime: const TimeOfDay(hour: 22, minute: 0),
          community: 'Weekend celebrators, social groups',
          effectivenessScore: 80,
          tags: ['friday', 'celebration', 'weekend'],
          icon: '🎉',
        ),
      ];
    }

    return [];
  }

  List<DealSuggestion> _getCulturalSuggestions(TimeOfDay currentTime) {
    // Prayer time considerations
    final suggestions = <DealSuggestion>[];

    // Between prayers suggestions
    suggestions.add(
      DealSuggestion(
        title: 'Between Prayers Special',
        description: 'Respectful timing for practicing Muslims',
        discountPercentage: 20,
        targetTime: const TimeOfDay(hour: 15, minute: 30),
        endTime: const TimeOfDay(hour: 17, minute: 45),
        community: 'Local community, respectful timing',
        effectivenessScore: 75,
        tags: ['halal', 'prayer-aware', 'respectful'],
        icon: '🕌',
      ),
    );

    return suggestions;
  }

  // Get optimal pricing suggestions based on market data
  PricingSuggestion getOptimalPricing({
    required String businessType,
    required TimeOfDay targetTime,
    required int currentOccupancy,
  }) {
    int suggestedDiscount;
    String reasoning;

    final hour = targetTime.hour;

    // Dead hours typically need higher discounts
    if ((hour >= 14 && hour <= 16) || (hour >= 21)) {
      if (currentOccupancy < 20) {
        suggestedDiscount = 40;
        reasoning =
            'High discount needed - very low occupancy during dead hours';
      } else if (currentOccupancy < 50) {
        suggestedDiscount = 30;
        reasoning = 'Moderate discount - some customers but below capacity';
      } else {
        suggestedDiscount = 20;
        reasoning = 'Light discount - decent occupancy, gentle nudge needed';
      }
    } else {
      // Peak or semi-peak hours
      suggestedDiscount = 15;
      reasoning = 'Small discount - not typical dead hours';
    }

    return PricingSuggestion(
      discountPercentage: suggestedDiscount,
      reasoning: reasoning,
      expectedIncrease:
          '${suggestedDiscount + 20}% revenue boost vs empty venue',
    );
  }

  // Community messaging suggestions
  List<String> getCommunityMessageSuggestions({
    required String dealTitle,
    required String businessType,
    required int discountPercentage,
  }) {
    return [
      '🔥 $discountPercentage% OFF during dead hours! Perfect timing for a break. Who\'s joining? #DeadHourDeals',
      '💡 Beat the afternoon slump! $dealTitle - great vibes, even better prices. Perfect for remote work!',
      '📍 Local tip: This is THE time to visit! $discountPercentage% off and way less crowded. Thank me later! 😉',
      '⏰ Smart timing = Smart savings! $dealTitle available now. Community-tested, local-approved! ✅',
      '🎯 Pro tip from the community: Best deals happen during dead hours. $dealTitle is proof! Who\'s in?',
    ];
  }
}

