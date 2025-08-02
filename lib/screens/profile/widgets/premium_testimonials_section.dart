import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/profile/state/premium_role_state.dart';

class PremiumTestimonialsSection extends StatelessWidget {
  final PremiumRoleState state;

  const PremiumTestimonialsSection({
    super.key,
    required this.state,
  });

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
        ...state.testimonials.map((testimonial) => Card(
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
                        _getAvatarIcon(testimonial['avatar']!),
                        color: AppTheme.moroccoGreen,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    Text(
                      testimonial['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing12),
                Text(
                  '"${testimonial['text']!}"',
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

  IconData _getAvatarIcon(String iconName) {
    switch (iconName) {
      case 'person':
        return Icons.person;
      case 'person_outline':
        return Icons.person_outline;
      default:
        return Icons.person;
    }
  }
}