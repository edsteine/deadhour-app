import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class BusinessRoomsTab extends StatelessWidget {
  const BusinessRoomsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Role-enhanced rooms for business owners
    final businessRooms = [
      {'id': 'business-owners-lounge', 'name': 'Business Owners Lounge', 'category': 'business', 'members': 234},
      {'id': 'revenue-optimization', 'name': 'Revenue Optimization', 'category': 'business', 'members': 156},
      {'id': 'dead-hours-strategies', 'name': 'Dead Hours Strategies', 'category': 'business', 'members': 89},
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
                child: const Icon(Icons.business, color: Colors.white, size: 20),
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
                      '${room['members']} business owners',
                      style: const TextStyle(fontSize: 12, color: AppTheme.secondaryText),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.secondaryText),
            ],
          ),
        );
      },
    );
  }
}
