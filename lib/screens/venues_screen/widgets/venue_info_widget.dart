
import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';



/// Venue information tab widget with contact, location, and cultural timing
class VenueInfoWidget extends StatelessWidget {
  final dynamic venue;
  final CulturalCalendarService culturalCalendar;

  const VenueInfoWidget({
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
          _buildInfoSection('Contact', [
            _buildInfoRow(Icons.phone, 'Phone', '+212 5XX-XXXXXX'),
            _buildInfoRow(Icons.email, 'Email', 'info@${venue.name.toLowerCase().replaceAll(' ', '')}.ma'),
            _buildInfoRow(Icons.language, 'Website', 'www.${venue.name.toLowerCase().replaceAll(' ', '')}.ma'),
          ]),
          
          const SizedBox(height: 24),
          
          _buildInfoSection('Location', [
            _buildInfoRow(Icons.location_on, 'Address', venue.location),
            _buildInfoRow(Icons.directions, 'Distance', '1.2 km away'),
            _buildInfoRow(Icons.local_parking, 'Parking', 'Available'),
          ]),
          
          const SizedBox(height: 24),
          
          _buildInfoSection('Payment & Booking', [
            _buildInfoRow(Icons.payment, 'Payment', 'Cash, Card, Mobile'),
            _buildInfoRow(Icons.book_online, 'Booking', 'Required for deals'),
            _buildInfoRow(Icons.cancel, 'Cancellation', 'Free up to 2 hours before'),
          ]),
          
          const SizedBox(height: 24),
          
          VenueCulturalTimingWidget(culturalCalendar: culturalCalendar),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...items,
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppTheme.secondaryText,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.primaryText,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}