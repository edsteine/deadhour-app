import 'package:flutter/material.dart';

class OnboardingPage {
  final String title;
  final String subtitle;
  final String description;
  final String icon;
  final List<Color> gradient;
  final bool isActionPage;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.gradient,
    this.isActionPage = false,
  });
}