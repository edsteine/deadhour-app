import 'package:flutter/material.dart';

class DiscoverTab extends StatelessWidget {
  final Function(String) buildSectionHeader;
  final Function() buildQuickDiscoveryGrid;
  final Function() buildTrendingExperiences;
  final Function() buildSocialDiscoveryButton;
  final Function() buildTouristFriendlyDeals;

  const DiscoverTab({
    super.key,
    required this.buildSectionHeader,
    required this.buildQuickDiscoveryGrid,
    required this.buildTrendingExperiences,
    required this.buildSocialDiscoveryButton,
    required this.buildTouristFriendlyDeals,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick discovery categories
          buildSectionHeader('🎯 Quick Discovery'),
          const SizedBox(height: 12),
          buildQuickDiscoveryGrid(),
          const SizedBox(height: 24),

          // Trending experiences
          buildSectionHeader('🔥 Trending This Week'),
          const SizedBox(height: 12),
          buildTrendingExperiences(),
          const SizedBox(height: 24),

          // Social Discovery Button
          buildSocialDiscoveryButton(),
          const SizedBox(height: 24),

          // Tourist-friendly venues with deals
          buildSectionHeader('🏪 Tourist-Friendly Deals'),
          const SizedBox(height: 12),
          buildTouristFriendlyDeals(),
        ],
      ),
    );
  }
}
