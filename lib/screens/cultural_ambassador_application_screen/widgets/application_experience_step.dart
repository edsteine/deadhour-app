import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';



/// Experience and motivation step for cultural ambassador application
class ApplicationExperienceStep extends StatelessWidget {
  final ApplicationState state;

  const ApplicationExperienceStep({
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
            'Experience & Motivation',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Share your experience and passion for Moroccan culture.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 24),

          // Experience
          TextFormField(
            controller: state.experienceController,
            decoration: const InputDecoration(
              labelText: 'Relevant Experience',
              hintText: 'Tour guide, cultural studies, local business...',
              prefixIcon: Icon(Icons.work),
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please describe your relevant experience';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // About yourself
          TextFormField(
            controller: state.aboutController,
            decoration: const InputDecoration(
              labelText: 'About Yourself',
              hintText: 'Tell us about your background and interests...',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please tell us about yourself';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Motivation
          TextFormField(
            controller: state.motivationController,
            decoration: const InputDecoration(
              labelText: 'Why do you want to be a Cultural Ambassador?',
              hintText: 'Share your passion for Moroccan culture...',
              prefixIcon: Icon(Icons.favorite),
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please share your motivation';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Cultural commitment note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.3),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.moroccoGreen,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Cultural Ambassador Commitment',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.moroccoGreen,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'As a Cultural Ambassador, you\'ll help visitors discover authentic Moroccan experiences while respecting local customs and traditions. This includes being mindful of prayer times, cultural sensitivities, and promoting halal-friendly activities.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}