import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/cultural/state/application_state.dart';

class ReviewStep extends StatelessWidget {
  final ApplicationState applicationState;

  const ReviewStep({
    super.key,
    required this.applicationState,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review Application',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please review your application before submitting.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 24),

          // Personal Info Summary
          _buildReviewSection(
            'Personal Information',
            Icons.person,
            [
              'Name: ${applicationState.nameController.text}',
              'Email: ${applicationState.emailController.text}',
              'Phone: ${applicationState.phoneController.text}',
              'City: ${applicationState.cityController.text}',
              'Languages: ${applicationState.selectedLanguages.join(', ')}',
            ],
          ),
          const SizedBox(height: 16),

          // Expertise Summary
          _buildReviewSection(
            'Cultural Expertise',
            Icons.star,
            [
              'Selected Areas: ${applicationState.selectedExpertise.length}',
              'Expertise: ${applicationState.selectedExpertise.map((id) => 
                applicationState.culturalExpertise.firstWhere((e) => e['id'] == id)['name']
              ).join(', ')}',
              'Availability: ${applicationState.availabilityDays.join(', ')}',
            ],
          ),
          const SizedBox(height: 16),

          // Experience Summary
          _buildReviewSection(
            'Experience',
            Icons.work,
            [
              'Experience: ${_truncateText(applicationState.experienceController.text, 50)}',
              'About: ${_truncateText(applicationState.aboutController.text, 50)}',
            ],
          ),
          const SizedBox(height: 24),

          // Terms and conditions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: AppColors.info),
                    SizedBox(width: 8),
                    Text(
                      'Next Steps',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.info,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  '• Your application will be reviewed within 3-5 business days\n'
                  '• You\'ll receive an email notification about the status\n'
                  '• If approved, you\'ll get access to the Cultural Ambassador dashboard\n'
                  '• Training materials and guidelines will be provided',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection(String title, IconData icon, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppTheme.moroccoGreen),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                item,
                style: const TextStyle(fontSize: 14),
              ),
            )),
          ],
        ),
      ),
    );
  }

  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}