import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/theme.dart';

class AppFeaturesSection extends StatelessWidget {
  const AppFeaturesSection({super.key});

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
                Icons.apps,
                color: AppTheme.moroccoGreen,
                size: 28,
              ),
              SizedBox(width: 12),
              Text(
                'App Features',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFeatureGrid(context),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final features = [
      {
        'icon': Icons.local_offer,
        'title': 'Browse Deals',
        'route': '/home/deals'
      },
      {'icon': Icons.people, 'title': 'Communities', 'route': '/community'},
      {'icon': Icons.explore, 'title': 'Explore Morocco', 'route': '/tourism'},
      {'icon': Icons.favorite, 'title': 'Favorites', 'route': null},
      {'icon': Icons.history, 'title': 'Order History', 'route': null},
      {'icon': Icons.notifications, 'title': 'Notifications', 'route': null},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return GestureDetector(
          onTap: () {
            if (feature['route'] != null) {
              context.go(feature['route'] as String);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${feature['title']} - Coming Soon')),
              );
            }
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  feature['icon'] as IconData,
                  color: AppTheme.moroccoGreen,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  feature['title'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}