import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:go_router/go_router.dart';

class ExpertCard extends StatelessWidget {
  final Map<String, dynamic> expert;
  final bool isPremiumUser;

  const ExpertCard({
    super.key,
    required this.expert,
    required this.isPremiumUser,
  });

  @override
  Widget build(BuildContext context) {
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
              color: AppColors.tourismCategory.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child:
                  Text(expert['avatar']!, style: const TextStyle(fontSize: 24)),
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
                    const Icon(Icons.language, size: 14, color: AppColors.info),
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
                    backgroundColor: AppColors.tourismCategory,
                    minimumSize: const Size(70, 32),
                  ),
                  child: const Text('Chat', style: TextStyle(fontSize: 12)),
                ),
              ] else ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  style: TextStyle(fontSize: 10, color: AppColors.success)),
            ],
          ),
        ],
      ),
    );
  }
}
