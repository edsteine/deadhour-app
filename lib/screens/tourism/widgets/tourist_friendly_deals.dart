import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class TouristFriendlyDeals extends StatelessWidget {
  const TouristFriendlyDeals({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: AppColors.tourismCategory.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.tourismCategory.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('☕', style: TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rick\'s Café - 20% OFF',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Famous movie location café',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.language,
                            size: 14, color: AppColors.success),
                        Text(' English menu', style: TextStyle(fontSize: 12)),
                        SizedBox(width: 8),
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        Text(' 4.7', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tourismCategory,
                      minimumSize: const Size(80, 32),
                    ),
                    child: const Text('Book', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(height: 4),
                  const Text('2.1km',
                      style: TextStyle(
                          fontSize: 10, color: AppTheme.secondaryText)),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
