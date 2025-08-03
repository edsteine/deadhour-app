import 'package:flutter/material.dart';
import '../utils/mock_data.dart';
import 'validation/validation_types.dart';
import 'validation/deal_validation.dart';
import 'validation/deal_rating.dart';
import 'validation/deal_photo.dart';
import 'validation/validation_summary.dart';
import 'validation/top_validator.dart';

class DealValidationService extends ChangeNotifier {
  static final DealValidationService _instance =
      DealValidationService._internal();
  factory DealValidationService() => _instance;
  DealValidationService._internal();

  // Deal validation data
  final Map<String, List<DealValidation>> _dealValidations = {};
  final Map<String, DealRating> _dealRatings = {};
  final Map<String, List<DealPhoto>> _dealPhotos = {};

  // Community trust scores
  final Map<String, double> _userTrustScores = {};

  // Initialize with mock data
  void initialize() {
    _initializeMockValidations();
    _initializeMockRatings();
    _initializeMockPhotos();
    _calculateTrustScores();
  }

  void _initializeMockValidations() {
    for (final deal in MockData.deals) {
      _dealValidations[deal.id] = [
        DealValidation(
          id: '${deal.id}_val_1',
          userId: 'user_1',
          userName: 'Ahmed K.',
          userAvatar: '👨‍💼',
          dealId: deal.id,
          validationType: ValidationType.verified,
          comment:
              'Just tried this! Amazing coffee and the WiFi is perfect for work. Totally worth it! 🔥',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          helpfulCount: 12,
          photos: ['photo_1', 'photo_2'],
          tags: ['confirmed', 'wifi', 'work-friendly'],
        ),
        DealValidation(
          id: '${deal.id}_val_2',
          userId: 'user_2',
          userName: 'Fatima M.',
          userAvatar: '👩‍🎓',
          dealId: deal.id,
          validationType: ValidationType.confirmed,
          comment:
              'Perfect study spot! Quiet atmosphere and great pastries. The 35% off is real.',
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          helpfulCount: 8,
          photos: ['photo_3'],
          tags: ['confirmed', 'quiet', 'study'],
        ),
        DealValidation(
          id: '${deal.id}_val_3',
          userId: 'user_3',
          userName: 'Youssef A.',
          userAvatar: '🧑‍💻',
          dealId: deal.id,
          validationType: ValidationType.warning,
          comment:
              'Deal is good but gets crowded after 15:30. Go early for best experience.',
          timestamp: DateTime.now().subtract(const Duration(hours: 8)),
          helpfulCount: 15,
          photos: [],
          tags: ['warning', 'crowded', 'timing'],
        ),
      ];
    }
  }

  void _initializeMockRatings() {
    for (final deal in MockData.deals) {
      _dealRatings[deal.id] = DealRating(
        dealId: deal.id,
        averageRating: 4.3,
        totalRatings: 47,
        ratingBreakdown: {
          5: 18,
          4: 15,
          3: 9,
          2: 3,
          1: 2,
        },
        valueForMoney: 4.5,
        quality: 4.2,
        service: 4.1,
        authenticity: 4.4,
      );
    }
  }

  void _initializeMockPhotos() {
    for (final deal in MockData.deals) {
      _dealPhotos[deal.id] = [
        DealPhoto(
          id: 'photo_1',
          url: 'https://example.com/coffee1.jpg',
          userId: 'user_1',
          userName: 'Ahmed K.',
          caption: 'The coffee setup - perfect for afternoon work!',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          likes: 23,
        ),
        DealPhoto(
          id: 'photo_2',
          url: 'https://example.com/cafe_atmosphere.jpg',
          userId: 'user_2',
          userName: 'Fatima M.',
          caption: 'Such a peaceful study environment ☕📚',
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          likes: 18,
        ),
      ];
    }
  }

  void _calculateTrustScores() {
    _userTrustScores['user_1'] = 4.7;
    _userTrustScores['user_2'] = 4.3;
    _userTrustScores['user_3'] = 4.8;
  }

  // Get validations for a deal
  List<DealValidation> getDealValidations(String dealId) {
    return _dealValidations[dealId] ?? [];
  }

  // Get rating for a deal
  DealRating? getDealRating(String dealId) {
    return _dealRatings[dealId];
  }

  // Get photos for a deal
  List<DealPhoto> getDealPhotos(String dealId) {
    return _dealPhotos[dealId] ?? [];
  }

  // Get user trust score
  double getUserTrustScore(String userId) {
    return _userTrustScores[userId] ?? 3.0;
  }

  // Add new validation
  Future<void> addValidation(DealValidation validation) async {
    if (_dealValidations[validation.dealId] == null) {
      _dealValidations[validation.dealId] = [];
    }

    _dealValidations[validation.dealId]!.insert(0, validation);
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Add new rating
  Future<void> addRating(String dealId, UserRating userRating) async {
    final currentRating = _dealRatings[dealId];

    if (currentRating != null) {
      // Update existing rating
      final newTotal = currentRating.totalRatings + 1;
      final newAverage =
          ((currentRating.averageRating * currentRating.totalRatings) +
                  userRating.overall) /
              newTotal;

      final newBreakdown = Map<int, int>.from(currentRating.ratingBreakdown);
      newBreakdown[userRating.overall] =
          (newBreakdown[userRating.overall] ?? 0) + 1;

      _dealRatings[dealId] = DealRating(
        dealId: dealId,
        averageRating: newAverage,
        totalRatings: newTotal,
        ratingBreakdown: newBreakdown,
        valueForMoney:
            ((currentRating.valueForMoney * currentRating.totalRatings) +
                    userRating.valueForMoney) /
                newTotal,
        quality: ((currentRating.quality * currentRating.totalRatings) +
                userRating.quality) /
            newTotal,
        service: ((currentRating.service * currentRating.totalRatings) +
                userRating.service) /
            newTotal,
        authenticity:
            ((currentRating.authenticity * currentRating.totalRatings) +
                    userRating.authenticity) /
                newTotal,
      );
    } else {
      // Create new rating
      _dealRatings[dealId] = DealRating(
        dealId: dealId,
        averageRating: userRating.overall.toDouble(),
        totalRatings: 1,
        ratingBreakdown: {userRating.overall: 1},
        valueForMoney: userRating.valueForMoney,
        quality: userRating.quality,
        service: userRating.service,
        authenticity: userRating.authenticity,
      );
    }

    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Mark validation as helpful
  Future<void> markHelpful(String validationId) async {
    for (final validations in _dealValidations.values) {
      for (final validation in validations) {
        if (validation.id == validationId) {
          validation.helpfulCount++;
          notifyListeners();
          break;
        }
      }
    }

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 200));
  }

  // Get validation summary for a deal
  ValidationSummary getValidationSummary(String dealId) {
    final validations = getDealValidations(dealId);
    final rating = getDealRating(dealId);

    int confirmedCount = 0;
    int warningCount = 0;
    int verifiedCount = 0;

    for (final validation in validations) {
      switch (validation.validationType) {
        case ValidationType.confirmed:
          confirmedCount++;
          break;
        case ValidationType.warning:
          warningCount++;
          break;
        case ValidationType.verified:
          verifiedCount++;
          break;
      }
    }

    final totalValidations = validations.length;
    final trustScore = totalValidations > 0
        ? (confirmedCount + verifiedCount * 2) /
            (totalValidations + warningCount)
        : 0.0;

    return ValidationSummary(
      dealId: dealId,
      totalValidations: totalValidations,
      confirmedCount: confirmedCount,
      warningCount: warningCount,
      verifiedCount: verifiedCount,
      trustScore: trustScore,
      averageRating: rating?.averageRating ?? 0.0,
      totalRatings: rating?.totalRatings ?? 0,
      communityStatus: _getCommunityStatus(trustScore, totalValidations),
    );
  }

  CommunityStatus _getCommunityStatus(double trustScore, int totalValidations) {
    if (totalValidations == 0) return CommunityStatus.unverified;
    if (trustScore >= 0.8 && totalValidations >= 5) {
      return CommunityStatus.trusted;
    }
    if (trustScore >= 0.6 && totalValidations >= 3) {
      return CommunityStatus.verified;
    }
    if (trustScore >= 0.4) return CommunityStatus.caution;
    return CommunityStatus.warning;
  }

  // Get top community validators
  List<TopValidator> getTopValidators() {
    return [
      TopValidator(
        userId: 'user_1',
        userName: 'Ahmed K.',
        avatar: '👨‍💼',
        trustScore: 4.7,
        totalValidations: 156,
        badge: 'Local Expert',
        specialties: ['Food', 'Coffee', 'Work-friendly'],
      ),
      TopValidator(
        userId: 'user_3',
        userName: 'Youssef A.',
        avatar: '🧑‍💻',
        trustScore: 4.8,
        totalValidations: 203,
        badge: 'Super Validator',
        specialties: ['Tech', 'Entertainment', 'Gaming'],
      ),
      TopValidator(
        userId: 'user_2',
        userName: 'Fatima M.',
        avatar: '👩‍🎓',
        trustScore: 4.3,
        totalValidations: 89,
        badge: 'Study Expert',
        specialties: ['Study spots', 'Quiet places', 'Student deals'],
      ),
    ];
  }
}