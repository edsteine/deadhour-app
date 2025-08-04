import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';
import 'deal_card.dart';
import 'optimized_list_view.dart';


/// Optimized list view for displaying deals
class DealsListView extends StatelessWidget {
  final List<dynamic> deals;
  final Function(dynamic) onDealTap;
  final Future<void> Function() onRefresh;
  final bool autoApplyEnabled;
  final Function(String) onPriceTrackingStart;

  const DealsListView({
    super.key,
    required this.deals,
    required this.onDealTap,
    required this.onRefresh,
    this.autoApplyEnabled = false,
    required this.onPriceTrackingStart,
  });

  @override
  Widget build(BuildContext context) {
    if (deals.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: BasicOptimizedListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: deals.length,
        itemBuilder: (context, index) {
          final deal = deals[index];
          // Start price tracking if auto-apply is enabled
          if (autoApplyEnabled) {
            onPriceTrackingStart(deal.id);
          }
          return DealCard(
            deal: deal,
            onTap: () => onDealTap(deal),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: AppTheme.lightText,
            ),
            const SizedBox(height: 16),
            const Text(
              'No deals found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.secondaryText,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your filters or check back later for new deals',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.lightText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // This would call back to parent to clear filters
                // For now, just a placeholder
              },
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }
}

