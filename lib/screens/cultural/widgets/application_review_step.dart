import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../application_state.dart';
import 'application_review_section.dart';

/// Review step for cultural ambassador application
class ApplicationReviewStep extends StatelessWidget {
  final ApplicationState state;

  const ApplicationReviewStep({
    super.key,
    required this.state,
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
          ApplicationReviewSection(
            title: 'Personal Information',
            icon: Icons.person,
            items: [
              'Name: ${state.nameController.text}',
              'Email: ${state.emailController.text}',
              'Phone: ${state.phoneController.text}',
              'City: ${state.cityController.text}',
              'Languages: ${state.selectedLanguages.join(', ')}',
            ],
          ),
          const SizedBox(height: 16),

          // Expertise Summary
          ApplicationReviewSection(
            title: 'Cultural Expertise',
            icon: Icons.star,
            items: [
              'Selected Areas: ${state.selectedExpertise.length}',
              'Expertise: ${state.selectedExpertise.map((id) => 
                state.culturalExpertise.firstWhere((e) => e['id'] == id)['name']
              ).join(', ')}',
              'Availability: ${state.availabilityDays.join(', ')}',
            ],
          ),
          const SizedBox(height: 16),

          // Experience Summary
          ApplicationReviewSection(
            title: 'Experience',
            icon: Icons.work,
            items: [
              'Experience: ${_truncateText(state.experienceController.text, 50)}',
              'About: ${_truncateText(state.aboutController.text, 50)}',
            ],
          ),
          const SizedBox(height: 24),

          // Next Steps
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Next Steps',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
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

  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}