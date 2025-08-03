import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../../../services/social_validation_service.dart';

class VenueSocialValidationWidget extends StatelessWidget {
  final dynamic venue;
  final SocialValidationService socialValidation;

  const VenueSocialValidationWidget({
    super.key,
    required this.venue,
    required this.socialValidation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Community Validation',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        // Validation stats
        Row(
          children: [
            Expanded(
              child: _buildValidationCard(
                'Verified Deals',
                '12',
                Icons.verified,
                Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildValidationCard(
                'Community Score',
                '4.8',
                Icons.star,
                Colors.amber,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Recent validations
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recent Validations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ..._getRecentValidations().map((validation) => 
                _buildValidationItem(validation)
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValidationCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildValidationItem(Map<String, dynamic> validation) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppTheme.moroccoGreen.withValues(alpha: 0.1),
            child: Text(
              validation['user'][0].toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.moroccoGreen,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  validation['user'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  validation['action'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            validation['time'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getRecentValidations() {
    return [
      {
        'user': 'Ahmed M.',
        'action': 'Verified lunch deal is active',
        'time': '2h ago',
      },
      {
        'user': 'Sarah L.',
        'action': 'Confirmed happy hour prices',
        'time': '5h ago',
      },
      {
        'user': 'Omar K.',
        'action': 'Validated restaurant quality',
        'time': '1d ago',
      },
    ];
  }
}