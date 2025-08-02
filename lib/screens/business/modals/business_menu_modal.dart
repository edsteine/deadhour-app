import 'package:flutter/material.dart';

class BusinessMenuModal extends StatelessWidget {
  const BusinessMenuModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const BusinessMenuModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Business Menu',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildMenuOption(
            'Venue Settings',
            'Manage venue information, hours, and preferences',
            Icons.store,
            () {
              Navigator.pop(context);
              debugPrint('Navigate to venue settings');
            },
          ),
          _buildMenuOption(
            'Staff Management',
            'Add and manage staff accounts and permissions',
            Icons.people,
            () {
              Navigator.pop(context);
              debugPrint('Navigate to staff management');
            },
          ),
          _buildMenuOption(
            'Payment & Billing',
            'View subscription, billing history, and payment methods',
            Icons.payment,
            () {
              Navigator.pop(context);
              debugPrint('Navigate to payment settings');
            },
          ),
          _buildMenuOption(
            'Marketing Tools',
            'Promotional campaigns, social media, and advertising',
            Icons.campaign,
            () {
              Navigator.pop(context);
              debugPrint('Navigate to marketing tools');
            },
          ),
          _buildMenuOption(
            'Reports & Export',
            'Download detailed reports and export data',
            Icons.file_download,
            () {
              Navigator.pop(context);
              debugPrint('Navigate to reports');
            },
          ),
          _buildMenuOption(
            'Help & Support',
            'Get help, contact support, or access documentation',
            Icons.help,
            () {
              Navigator.pop(context);
              debugPrint('Navigate to help center');
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildMenuOption(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.withValues(alpha: 0.1),
        child: Icon(icon, color: Colors.grey[700]),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}