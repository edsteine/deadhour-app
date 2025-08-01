import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/app_theme.dart';

class LocalExpertsTab extends StatelessWidget {
  final Function(String) buildSectionHeader;
  final Function(Map<String, String>) buildExpertCard;
  final List<Map<String, String>> experts;

  const LocalExpertsTab({
    super.key,
    required this.buildSectionHeader,
    required this.buildExpertCard,
    required this.experts,
  });

  @override
  Widget build(BuildContext context) {
    // Enhanced expert data with the features from expert_card.dart
    final enhancedExperts = [
      {
        'name': 'Aisha Khan',
        'specialty': 'History & Culture',
        'city': 'Marrakech',
        'rating': '4.9',
        'languages': 'Arabic, French, English',
        'avatar': '👩‍🏫',
        'isPremium': true,
      },
      {
        'name': 'Omar Benali',
        'specialty': 'Adventure & Nature',
        'city': 'Atlas Mountains',
        'rating': '4.8',
        'languages': 'Arabic, English, Berber',
        'avatar': '🧗‍♂️',
        'isPremium': true,
      },
      {
        'name': 'Fatima Alaoui',
        'specialty': 'Culinary Expert',
        'city': 'Fes',
        'rating': '5.0',
        'languages': 'Arabic, French',
        'avatar': '👩‍🍳',
        'isPremium': false,
      },
      {
        'name': 'Youssef Tazi',
        'specialty': 'Architecture & Design',
        'city': 'Casablanca',
        'rating': '4.7',
        'languages': 'Arabic, French, English',
        'avatar': '👨‍💼',
        'isPremium': true,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader('🌟 Available Local Experts'),
          const SizedBox(height: 12),

          // Premium experts section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.moroccoGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.moroccoGold.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.workspace_premium, color: AppTheme.moroccoGold),
                    SizedBox(width: 8),
                    Text(
                      'Premium Expert Access',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.moroccoGold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Chat directly with local experts, get personalized recommendations, and book exclusive experiences.',
                  style: TextStyle(fontSize: 14, color: AppTheme.secondaryText),
                ),
                const SizedBox(height: 16),
                
                // Expert cards using the superior ExpertCard widget
                ...enhancedExperts.map((expert) => _buildExpertCard(expert, context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpertCard(Map<String, dynamic> expert, BuildContext context) {
    final isPremiumUser = expert['isPremium'] == true; // Use expert's premium status
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(expert['avatar']!, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expert['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${expert['specialty']} • ${expert['city']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    Text(' ${expert['rating']} • '),
                    const Icon(Icons.language, size: 14, color: Colors.blue),
                    Expanded(
                      child: Text(
                        ' ${expert['languages']}',
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              if (isPremiumUser) ...[
                ElevatedButton(
                  onPressed: () => context.push('/tourism/local-expert'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(70, 32),
                  ),
                  child: const Text('Chat', style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.moroccoGold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Premium',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.moroccoGold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 4),
              const Text('Online now',
                  style: TextStyle(fontSize: 10, color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}
