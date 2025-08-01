import 'package:flutter/material.dart';

import '../../../utils/theme.dart';
import '../../dev_menu/dead_hour_app_bar.dart';
import '../../profile/services/cultural_calendar_service.dart';
import 'tourist_cultural_events.dart';
import 'tourist_cultural_insights_card.dart';
import 'tourist_featured_experiences.dart';
import 'tourist_local_expert_recommendations.dart';
import 'tourist_location_selector.dart';
import 'tourist_quick_actions.dart';
import 'tourist_trending_deals.dart';
// Import modular tourist widgets
import 'tourist_welcome_section.dart';

class TouristHomeScreen extends StatefulWidget {
  const TouristHomeScreen({super.key});

  @override
  State<TouristHomeScreen> createState() => _TouristHomeScreenState();
}

class _TouristHomeScreenState extends State<TouristHomeScreen> {
  final _culturalService = CulturalCalendarService();
  String _selectedCity = 'Casablanca';

  void _onCityChanged(String city) {
    setState(() {
      _selectedCity = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeadHourAppBar(
        title: 'Discover Morocco',
        subtitle: 'Premium Tourist Experience',
        customActions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(
                  'Premium',
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          children: [
            const TouristWelcomeSection(),
            const SizedBox(height: AppTheme.spacing24),
            TouristCulturalInsightsCard(culturalService: _culturalService),
            const SizedBox(height: AppTheme.spacing24),
            TouristLocationSelector(
              selectedCity: _selectedCity,
              onCityChanged: _onCityChanged,
            ),
            const SizedBox(height: AppTheme.spacing24),
            const TouristQuickActions(),
            const SizedBox(height: AppTheme.spacing24),
            const TouristFeaturedExperiences(),
            const SizedBox(height: AppTheme.spacing24),
            const TouristTrendingDeals(),
            const SizedBox(height: AppTheme.spacing24),
            const TouristLocalExpertRecommendations(),
            const SizedBox(height: AppTheme.spacing24),
            const TouristCulturalEvents(),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    // Simulate data refresh
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Refresh state if needed
    });
  }
}