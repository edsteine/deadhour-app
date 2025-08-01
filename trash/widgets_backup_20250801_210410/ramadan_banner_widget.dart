import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';
import '../business/services/ramadan_business_service.dart';

/// Ramadan seasonal banner widget
class RamadanBannerWidget extends StatelessWidget {
  final RamadanBusinessService ramadanService;
  final VoidCallback onViewDeals;

  const RamadanBannerWidget({
    super.key,
    required this.ramadanService,
    required this.onViewDeals,
  });

  @override
  Widget build(BuildContext context) {
    final strategies = ramadanService.getRamadanDealStrategies();
    final isEndingSoon = ramadanService.isRamadanEndingSoon();
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.moroccoGold.withValues(alpha: 0.1),
            AppTheme.moroccoGold.withValues(alpha: 0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.moroccoGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🌙', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEndingSoon ? 'Ramadan Ending Soon!' : 'Ramadan Season Active',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.moroccoGold,
                      ),
                    ),
                    const Text(
                      'Seasonal dead hours optimization opportunities',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: onViewDeals,
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.moroccoGold,
                ),
                child: const Text('View Deals'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: strategies.length,
              itemBuilder: (context, index) {
                final strategy = strategies[index];
                return Container(
                  width: 180,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.moroccoGold.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strategy['dealType'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${strategy['timeSlot']}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${strategy['discountRange']} discount',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppTheme.moroccoGold,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}