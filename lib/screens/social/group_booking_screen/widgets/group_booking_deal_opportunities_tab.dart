import 'package:flutter/material.dart';
import 'package:deadhour/services/group_booking_service.dart';
import 'package:deadhour/screens/social/group_booking_screen/widgets/group_booking_deal_opportunity_card.dart';
import 'package:deadhour/screens/social/group_booking_screen/widgets/group_booking_empty_state.dart';

class GroupBookingDealOpportunitiesTab extends StatelessWidget {
  final GroupBookingService groupBookingService;
  final Function(Map<String, dynamic>) onNegotiateDeal;

  const GroupBookingDealOpportunitiesTab({
    super.key,
    required this.groupBookingService,
    required this.onNegotiateDeal,
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
        return GroupBookingDealOpportunityCard(
          opportunity: opportunity,
          onNegotiateDeal: () => onNegotiateDeal(opportunity),
        );
      },
    );
  }
}