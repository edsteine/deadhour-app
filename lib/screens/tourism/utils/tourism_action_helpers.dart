import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/utils/auth_helpers.dart';

class TourismActionHelpers {
  static void showCitySelector(BuildContext context, String selectedCity,
      Function(String) onCitySelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select City',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...[
              'Casablanca',
              'Marrakech',
              'Fez',
              'Rabat',
              'Tangier',
              'Essaouira'
            ].map((city) {
              return ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(city),
                trailing: selectedCity == city
                    ? const Icon(Icons.check, color: AppColors.tourismCategory)
                    : null,
                onTap: () {
                  onCitySelected(city);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  static void showTourismMenu(
      BuildContext context, Function() showPremiumUpgrade) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tourism Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.workspace_premium,
                  color: AppTheme.moroccoGold),
              title: const Text('Premium Features (Free Beta)'),
              onTap: () {
                Navigator.pop(context);
                showPremiumUpgrade();
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Tourism Help'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Emergency Contacts'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  static void showExpertRequest(BuildContext context, WidgetRef ref,
      bool isPremiumUser, Function() showPremiumUpgrade) {
    // Check if user is authenticated before allowing expert request
    if (!AuthHelpers.requireAuth(context, ref,
        feature: 'connect with local experts')) {
      return; // User not authenticated, helper will show login prompt
    }

    // User is authenticated, proceed with expert request
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Find Local Expert'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isPremiumUser) ...[
              const Text(
                  'Connect with verified local experts for authentic Morocco experiences - free during beta!'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: showPremiumUpgrade,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.moroccoGold),
                child: const Text('Learn More'),
              ),
            ] else ...[
              const Text('What type of local expert do you need?'),
              const SizedBox(height: 16),
              ...[
                'Cultural Guide',
                'Food Expert',
                'Shopping Assistant',
                'Historical Tours'
              ].map(
                (type) => ListTile(
                  title: Text(type),
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/tourism/local-expert');
                  },
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  static void showPremiumUpgrade(
      BuildContext context, Function(bool) setIsPremiumUser) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.workspace_premium, color: AppTheme.moroccoGold),
            SizedBox(width: 8),
            Text('Tourism Premium'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Premium features - free during beta:'),
            SizedBox(height: 12),
            Text('✅ Personal local expert assigned'),
            Text('✅ Exclusive premium experiences'),
            Text('✅ 24/7 cultural support & translation'),
            Text('✅ Access to premium community rooms'),
            Text('✅ Prayer-time smart planning'),
            Text('✅ Emergency assistance'),
            SizedBox(height: 16),
            Text('🎯 All features free during beta phase',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setIsPremiumUser(true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Premium features activated! Welcome to authentic Morocco 🇲🇦'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: AppTheme.moroccoGold),
            child: const Text('Activate Features'),
          ),
        ],
      ),
    );
  }
}
