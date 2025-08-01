import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/theme.dart';

class GuideRoomsTabView extends ConsumerWidget {
  const GuideRoomsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Role-enhanced rooms for local guides and tourism experts
    final guideRooms = [
      {
        'id': 'guide-network',
        'name': 'Guide Network Hub',
        'category': 'guide',
        'members': 189,
        'description': 'Connect with fellow guides and share experiences'
      },
      {
        'id': 'cultural-insights',
        'name': 'Cultural Insights',
        'category': 'guide',
        'members': 267,
        'description': 'Deep cultural knowledge and authentic experiences'
      },
      {
        'id': 'local-secrets',
        'name': 'Local Secrets Exchange',
        'category': 'guide',
        'members': 134,
        'description': 'Hidden gems and off-the-beaten-path discoveries'
      },
      {
        'id': 'morocco-heritage',
        'name': 'Morocco Heritage Stories',
        'category': 'guide',
        'members': 298,
        'description': 'Share the rich history and traditions of Morocco'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: guideRooms.length,
      itemBuilder: (context, index) {
        final room = guideRooms[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              // Handle guide room tap - navigate to room detail
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening ${room['name']}')),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.explore, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room['name']! as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        room['description']! as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.tour,
                            size: 14,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${room['members']} local guides',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppTheme.secondaryText,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
