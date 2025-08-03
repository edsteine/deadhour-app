import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class VenueCulturalInfoWidget extends StatelessWidget {
  final dynamic venue;

  const VenueCulturalInfoWidget({
    super.key,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
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
            color: AppTheme.moroccoGreen.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.moroccoGreen.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCulturalRow(Icons.restaurant_menu, 'Halal Certified', 'Yes'),
              const SizedBox(height: 8),
              _buildCulturalRow(Icons.access_time, 'Prayer Breaks', 'Respected'),
              const SizedBox(height: 8),
              _buildCulturalRow(Icons.language, 'Local Cuisine', 'Traditional Moroccan'),
              const SizedBox(height: 8),
              _buildCulturalRow(Icons.star, 'Tourist Friendly', 'Very Welcome'),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCulturalRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.moroccoGreen,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}