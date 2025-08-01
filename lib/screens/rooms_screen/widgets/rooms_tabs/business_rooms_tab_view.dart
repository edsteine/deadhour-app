import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/utils/app_theme.dart';


class BusinessRoomsTabView extends ConsumerWidget {
  const BusinessRoomsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Role-enhanced rooms for business owners - specialized content
    final businessRooms = [
      {
        'id': 'business-owners-lounge',
        'name': 'Business Owners Lounge',
        'category': 'business',
        'members': 234,
        'description': 'Connect with fellow business owners and share insights'
      },
      {
        'id': 'revenue-optimization',
        'name': 'Revenue Optimization',
        'category': 'business',
        'members': 156,
        'description': 'Strategies to maximize your venue revenue during dead hours'
      },
      {
        'id': 'dead-hours-strategies',
        'name': 'Dead Hours Strategies',
        'category': 'business',
        'members': 89,
        'description': 'Proven tactics to fill empty seats and boost profits'
      },
      {
        'id': 'morocco-business-network',
        'name': 'Morocco Business Network',
        'category': 'business',
        'members': 312,
        'description': 'Local business networking and partnership opportunities'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: businessRooms.length,
      itemBuilder: (context, index) {
        final room = businessRooms[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
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
              // Handle business room tap - navigate to room detail
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
                    color: AppTheme.moroccoGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.business, color: Colors.white, size: 24),
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
                            Icons.people,
                            size: 14,
                            color: AppTheme.moroccoGreen,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${room['members']} business owners',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.moroccoGreen,
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
