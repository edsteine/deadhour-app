import 'package:flutter/material.dart';

class VenueInfoTab extends StatelessWidget {
  final dynamic venue;

  const VenueInfoTab({
    super.key,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoSection('Contact', [
            _buildInfoRow(Icons.phone, 'Phone', '+212 522 123 456'),
            _buildInfoRow(Icons.email, 'Email', 'info@venue.ma'),
            _buildInfoRow(Icons.language, 'Website', 'www.venue.ma'),
          ]),
          const SizedBox(height: 24),
          
          _buildInfoSection('Location', [
            _buildInfoRow(Icons.location_on, 'Address', venue.address),
            _buildInfoRow(Icons.directions, 'District', 'Maarif, Casablanca'),
            _buildInfoRow(Icons.map, 'GPS', '33.5731, -7.5898'),
          ]),
          const SizedBox(height: 24),
          
          _buildInfoSection('Services', [
            _buildInfoRow(Icons.wifi, 'Wi-Fi', 'Free'),
            _buildInfoRow(Icons.local_parking, 'Parking', 'Available'),
            _buildInfoRow(Icons.credit_card, 'Payment', 'Cash, Cards'),
            _buildInfoRow(Icons.accessible, 'Accessibility', 'Wheelchair accessible'),
          ]),
          const SizedBox(height: 24),
          
          _buildInfoSection('Languages', [
            _buildInfoRow(Icons.translate, 'Staff speaks', 'Arabic, French, English'),
          ]),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}