import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

/// Premium user testimonials section
class PremiumTestimonialsSection extends StatelessWidget {
  const PremiumTestimonialsSection({super.key});

  static const List<Map<String, dynamic>> _testimonials = [
    {
      'name': 'Sarah, Business Owner',
      'text': 'Premium analytics helped me optimize my dead hours strategy. Revenue up 40%!',
      'avatar': Icons.person,
    },
    {
      'name': 'Ahmed, Local Guide',
      'text': 'Priority booking access and exclusive deals make premium worth every euro.',
      'avatar': Icons.person_outline,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What Premium Users Say',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing16),
        ..._testimonials.map((testimonial) => Card(
          margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                      child: Icon(
                        testimonial['avatar'] as IconData,
                        color: AppTheme.moroccoGreen,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    Text(
                      testimonial['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing12),
                Text(
                  '"${testimonial['text']}"',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}