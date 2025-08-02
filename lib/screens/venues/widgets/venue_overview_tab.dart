import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/models/venue.dart';
import 'package:deadhour/services/cultural_calendar_service.dart';
import 'package:deadhour/services/social_validation_service.dart';
import 'package:deadhour/screens/venues/widgets/venue_hours_widget.dart';
import 'package:deadhour/screens/venues/widgets/venue_cultural_info_widget.dart';
import 'package:deadhour/screens/venues/widgets/venue_social_validation_widget.dart';

class VenueOverviewTab extends StatelessWidget {
  final Venue venue;
  final CulturalCalendarService culturalCalendar;
  final SocialValidationService socialValidation;

  const VenueOverviewTab({
    super.key,
    required this.venue,
    required this.culturalCalendar,
    required this.socialValidation,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          const Text(
            'About',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            venue.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          
          // Features
          const Text(
            'Features',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _getVenueFeatures().map((feature) {
              return Chip(
                label: Text(feature),
                backgroundColor: AppTheme.moroccoGreen.withValues(alpha: 0.1),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          
          // Hours
          const Text(
            'Hours',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const VenueHoursWidget(),
          const SizedBox(height: 24),
          
          // Cultural information
          if (_shouldShowCulturalInfo(venue.category))
            VenueCulturalInfoWidget(venue: venue),
          
          // Social validation section
          VenueSocialValidationWidget(
            venue: venue,
            socialValidation: socialValidation,
          ),
        ],
      ),
    );
  }

  List<String> _getVenueFeatures() {
    return [
      'Wi-Fi',
      'Air Conditioning',
      'Parking',
      'Credit Cards',
      'Outdoor Seating',
      'Family Friendly',
    ];
  }

  bool _shouldShowCulturalInfo(String category) {
    return ['restaurant', 'cafe', 'culture'].contains(category.toLowerCase());
  }
}