import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class GuideRoomsTab extends StatelessWidget {
  const GuideRoomsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Role-enhanced rooms for guide network
    final guideRooms = [
      {
        'id': 'guide-network',
        'name': 'Guide Network Hub',
        'category': 'guide',
        'members': 189
      },
      {
        'id': 'cultural-insights',
        'name': 'Cultural Insights',
        'category': 'guide',
        'members': 267
      },
      {
        'id': 'local-secrets',
        'name': 'Local Secrets Exchange',
        'category': 'guide',
        'members': 134
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
            border:
                Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.explore, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room['name']! as String,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${room['members']} local guides',
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.secondaryText),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: AppTheme.secondaryText),
            ],
          ),
        );
      },
    );
  }
}
