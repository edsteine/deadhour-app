import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/theme.dart';
import '../services/cashback_service.dart';

/// Header widget with results count, controls, and cashback info
class DealsHeaderWidget extends StatelessWidget {
  final int dealCount;
  final String selectedFilter;
  final bool showMap;
  final bool autoApplyEnabled;
  final Function() onMapToggle;
  final Function(bool) onAutoApplyToggle;
  final Function() onFiltersClear;
  final Function() onShowCashbackDetails;
  final CashbackService cashbackService;

  const DealsHeaderWidget({
    super.key,
    required this.dealCount,
    required this.selectedFilter,
    required this.showMap,
    required this.autoApplyEnabled,
    required this.onMapToggle,
    required this.onAutoApplyToggle,
    required this.onFiltersClear,
    required this.onShowCashbackDetails,
    required this.cashbackService,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        children: [
          // Results and controls row
          Row(
            children: [
              Text(
                '$dealCount deals found',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.primaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              // Map toggle button
              IconButton(
                onPressed: onMapToggle,
                icon: Icon(
                  showMap ? Icons.list : Icons.map,
                  color: AppTheme.moroccoGreen,
                ),
                tooltip: showMap ? 'List View' : 'Map View',
              ),
              // Browser extension button
              IconButton(
                onPressed: () => context.go('/web-companion'),
                icon: const Icon(
                  Icons.extension,
                  color: AppTheme.moroccoGreen,
                ),
                tooltip: 'Browser Extension',
              ),
              const SizedBox(width: 8),
              if (selectedFilter != 'all')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _getFilterDisplayName(selectedFilter),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.moroccoGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: onFiltersClear,
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: AppTheme.moroccoGreen,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          
          // Auto-Apply Toggle
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.auto_mode,
                size: 16,
                color: AppTheme.moroccoGreen,
              ),
              const SizedBox(width: 8),
              const Text(
                'Auto-Apply Best Deals',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.primaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Switch(
                value: autoApplyEnabled,
                onChanged: onAutoApplyToggle,
                activeColor: AppTheme.moroccoGreen,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
          
          // Cashback Info Bar
          const SizedBox(height: 8),
          _buildCashbackInfoBar(),
        ],
      ),
    );
  }

  Widget _buildCashbackInfoBar() {
    final summary = cashbackService.getCashbackSummary();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.moroccoGreen.withValues(alpha: 0.1),
            AppTheme.moroccoGreen.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.moroccoGreen.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.monetization_on,
            color: AppTheme.moroccoGreen,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Cashback: ${summary.availableAmount.toStringAsFixed(2)} MAD',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.primaryText,
                  ),
                ),
                Text(
                  '${_getTierDisplayName(summary.tier)} • Earn up to 25% back on dead hour deals',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onShowCashbackDetails,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'View',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getFilterDisplayName(String filter) {
    switch (filter) {
      case 'active':
        return 'Active Only';
      case 'ending_soon':
        return 'Ending Soon';
      case 'food':
        return 'Food';
      case 'entertainment':
        return 'Entertainment';  
      case 'wellness':
        return 'Wellness';
      default:
        return 'All Deals';
    }
  }

  String _getTierDisplayName(CashbackTier tier) {
    switch (tier) {
      case CashbackTier.bronze:
        return 'Bronze Tier';
      case CashbackTier.silver:
        return 'Silver Tier';
      case CashbackTier.gold:
        return 'Gold Tier';
      case CashbackTier.platinum:
        return 'Platinum Tier';
    }
  }
}