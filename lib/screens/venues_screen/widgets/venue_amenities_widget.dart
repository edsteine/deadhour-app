
import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';


/// Venue amenities, features, hours, and cultural information widget
class VenueAmenitiesWidget extends StatelessWidget {
  final dynamic venue;
  final CulturalCalendarService culturalCalendar;

  const VenueAmenitiesWidget({
    super.key,
    required this.venue,
    required this.culturalCalendar,
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
          _buildHoursWidget(),
          const SizedBox(height: 24),
          
          // Cultural information
          if (_shouldShowCulturalInfo(venue.category))
            _buildCulturalInfoWidget(),
        ],
      ),
    );
  }

  List<String> _getVenueFeatures() {
    return [
      'WiFi',
      'Air Conditioning',
      'Parking',
      'Halal Certified',
      'Prayer Room',
      'Family Friendly',
      'Credit Cards',
      'Delivery',
      'Takeaway',
    ];
  }

  Widget _buildHoursWidget() {
    final days = [
      'Monday',
      'Tuesday', 
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    final hours = [
      '9:00 AM - 11:00 PM',
      '9:00 AM - 11:00 PM',
      '9:00 AM - 11:00 PM',
      '9:00 AM - 11:00 PM',
      '2:00 PM - 11:00 PM', // Friday (after prayer)
      '9:00 AM - 12:00 AM',
      '9:00 AM - 11:00 PM',
    ];

    return Column(
      children: List.generate(days.length, (index) {
        final isToday = DateTime.now().weekday - 1 == index;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  days[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: isToday ? AppTheme.moroccoGreen : AppTheme.primaryText,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  hours[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: isToday ? AppTheme.moroccoGreen : AppTheme.secondaryText,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  bool _shouldShowCulturalInfo(String category) {
    return category == 'food'; // Show for restaurants
  }

  Widget _buildCulturalInfoWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cultural Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.verified,
                    color: AppTheme.moroccoGreen,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Halal Certified',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.moroccoGreen,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '✓ All food is halal certified\n'
                '✓ Prayer room available\n'
                '✓ Special Ramadan menu during holy month\n'
                '✓ Adjusted hours during prayer times',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.primaryText,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

