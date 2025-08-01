import 'package:flutter/material.dart';

import '../services/group_booking_service.dart';
import 'group_booking_empty_state.dart';
import 'group_deal_opportunity_card.dart';

/// Tab displaying deal opportunities for group bookings
class GroupBookingDealsTab extends StatelessWidget {
  final GroupBookingService groupBookingService;
  final VoidCallback onRefresh;

  const GroupBookingDealsTab({
    super.key,
    required this.groupBookingService,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final opportunities = groupBookingService.getGroupDealOpportunities();
    
    if (opportunities.isEmpty) {
      return const GroupBookingEmptyState(
        title: 'No deal opportunities',
        subtitle: 'Create larger groups to unlock group discounts!',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: opportunities.length,
      itemBuilder: (context, index) {
        final opportunity = opportunities[index];
        return GroupDealOpportunityCard(
          opportunity: opportunity,
          onRefresh: onRefresh,
        );
      },
    );
  }
}