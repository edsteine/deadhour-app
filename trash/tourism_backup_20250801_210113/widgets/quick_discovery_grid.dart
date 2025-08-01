import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class QuickDiscoveryGrid extends StatelessWidget {
  const QuickDiscoveryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'icon': '🏛️', 'name': 'Historic Sites', 'count': '45'},
      {'icon': '🍽️', 'name': 'Food Tours', 'count': '28'},
      {'icon': '🛒', 'name': 'Souks & Markets', 'count': '12'},
      {'icon': '🎨', 'name': 'Art & Crafts', 'count': '34'},
      {'icon': '🌊', 'name': 'Beach & Coast', 'count': '18'},
      {'icon': '🏔️', 'name': 'Mountains', 'count': '22'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(category['icon']!, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 8),
                Text(
                  category['name']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${category['count']} options',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
