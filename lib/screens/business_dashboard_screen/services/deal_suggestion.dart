import 'package:flutter/material.dart';

class DealSuggestion {
  final String title;
  final String description;
  final int discountPercentage;
  final TimeOfDay targetTime;
  final TimeOfDay endTime;
  final String community;
  final int effectivenessScore;
  final List<String> tags;
  final String icon;

  DealSuggestion({
    required this.title,
    required this.description,
    required this.discountPercentage,
    required this.targetTime,
    required this.endTime,
    required this.community,
    required this.effectivenessScore,
    required this.tags,
    required this.icon,
  });
}