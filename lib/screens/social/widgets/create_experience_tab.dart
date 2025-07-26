import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/social/widgets/benefit_card.dart';
import 'package:deadhour/screens/social/widgets/category_card.dart';

class CreateExperienceTab extends StatelessWidget {
  final VoidCallback onStartHostApplication;
  final Function(String) onExploreCategory;

  const CreateExperienceTab({
    super.key,
    required this.onStartHostApplication,
    required this.onExploreCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Host Benefits
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[400]!, Colors.purple[600]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Become a Host',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Share your passion, meet amazing people, and earn money by hosting unique experiences',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onStartHostApplication,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple[600],
                  ),
                  child: const Text('Start Hosting'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Host Benefits
          const Text(
            'Why Host with DeadHour?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          BenefitCard(
            icon: Icons.monetization_on,
            title: 'Earn Good Money',
            description: 'Set your own prices and keep 85% of earnings',
            color: AppTheme.moroccoGreen,
          ),

          BenefitCard(
            icon: Icons.people,
            title: 'Meet Like-minded People',
            description: 'Connect with travelers and locals who share your interests',
            color: AppTheme.moroccoGold,
          ),

          BenefitCard(
            icon: Icons.local_offer,
            title: 'Connect with Venues',
            description: 'Partner with local businesses for special deals and enhanced experiences',
            color: Colors.blue,
          ),

          BenefitCard(
            icon: Icons.support,
            title: 'Full Support',
            description: 'Marketing help, insurance coverage, and 24/7 customer support',
            color: Colors.green,
          ),

          const SizedBox(height: 24),

          // Experience Ideas
          const Text(
            'Popular Experience Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              CategoryCard(emoji: '🍽️', title: 'Food Tours', description: 'Share local cuisine', onTap: () => onExploreCategory('Food Tours')),
              CategoryCard(emoji: '🎭', title: 'Cultural', description: 'Traditional experiences', onTap: () => onExploreCategory('Cultural')),
              CategoryCard(emoji: '🏔️', title: 'Adventure', description: 'Outdoor activities', onTap: () => onExploreCategory('Adventure')),
              CategoryCard(emoji: '🧘', title: 'Wellness', description: 'Relaxation & health', onTap: () => onExploreCategory('Wellness')),
              CategoryCard(emoji: '🌙', title: 'Nightlife', description: 'Evening experiences', onTap: () => onExploreCategory('Nightlife')),
              CategoryCard(emoji: '🗝️', title: 'Hidden Gems', description: 'Secret local spots', onTap: () => onExploreCategory('Hidden Gems')),
            ],
          ),
        ],
      ),
    );
  }
}
