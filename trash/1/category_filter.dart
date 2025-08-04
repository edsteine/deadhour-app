import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class CategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'id': 'all', 'name': 'All Rooms', 'icon': '🏷️'},
      {
        'id': 'food',
        'name': 'Food & Dining',
        'icon': '🍕',
        'color': AppColors.foodCategory
      },
      {
        'id': 'entertainment',
        'name': 'Entertainment',
        'icon': '🎮',
        'color': AppColors.entertainmentCategory
      },
      {
        'id': 'wellness',
        'name': 'Wellness & Spa',
        'icon': '💆',
        'color': AppColors.wellnessCategory
      },
      {
        'id': 'tourism',
        'name': 'Tourism & Culture',
        'icon': '🌍',
        'color': AppColors.tourismCategory
      },
      {
        'id': 'sports',
        'name': 'Sports & Fitness',
        'icon': '⚽',
        'color': AppColors.sportsCategory
      },
      {
        'id': 'family',
        'name': 'Family Fun',
        'icon': '👨‍👩‍👧‍👦',
        'color': AppColors.familyCategory
      },
    ];

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category['id'];

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(category['icon']! as String,
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(category['name']! as String),
                ],
              ),
              onSelected: (selected) {
                onCategorySelected(category['id']! as String);
              },
              selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
              checkmarkColor: AppTheme.moroccoGreen,
            ),
          );
        },
      ),
    );
  }
}
