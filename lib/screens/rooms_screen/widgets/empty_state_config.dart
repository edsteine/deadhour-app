import 'package:flutter/material.dart';

class EmptyStateConfig {
  final String emoji;
  final String title;
  final String description;
  final Color color;
  final String? primaryActionText;
  final IconData? primaryIcon;
  final VoidCallback? primaryAction;
  final String? secondaryActionText;
  final IconData? secondaryIcon;
  final VoidCallback? secondaryAction;
  final List<String> helpfulTips;

  EmptyStateConfig({
    required this.emoji,
    required this.title,
    required this.description,
    required this.color,
    this.primaryActionText,
    this.primaryIcon,
    this.primaryAction,
    this.secondaryActionText,
    this.secondaryIcon,
    this.secondaryAction,
    this.helpfulTips = const [],
  });
}