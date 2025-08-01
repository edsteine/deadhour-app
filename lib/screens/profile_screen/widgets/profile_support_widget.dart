import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Support section widget showing help and information options
class ProfileSupportWidget extends StatelessWidget {
  const ProfileSupportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.support_agent,
                color: AppTheme.moroccoGreen,
                size: 28,
              ),
              SizedBox(width: 12),
              Text(
                'Support & Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSupportTile(
            context,
            icon: Icons.help_center,
            title: 'Help Center',
            subtitle: 'FAQs and guides',
          ),
          _buildSupportTile(
            context,
            icon: Icons.chat,
            title: 'Contact Support',
            subtitle: 'Get help from our team',
          ),
          _buildSupportTile(
            context,
            icon: Icons.feedback,
            title: 'Send Feedback',
            subtitle: 'Help us improve DeadHour',
          ),
          _buildSupportTile(
            context,
            icon: Icons.star_rate,
            title: 'Rate the App',
            subtitle: 'Share your experience',
          ),
          _buildSupportTile(
            context,
            icon: Icons.info,
            title: 'About DeadHour',
            subtitle: 'v1.0.0 - Morocco\'s dual-problem platform',
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Text(
                  '🇲🇦 Made with ❤️ for Morocco',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Connecting businesses and community for authentic experiences',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.moroccoGreen),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title - Coming Soon')),
        );
      },
    );
  }
}