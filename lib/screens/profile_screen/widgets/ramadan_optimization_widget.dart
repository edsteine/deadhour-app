import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';




class RamadanOptimizationWidget extends StatelessWidget {
  final RamadanBusinessService ramadanService;

  const RamadanOptimizationWidget({
    super.key,
    required this.ramadanService,
  });

  @override
  Widget build(BuildContext context) {
    final optimization = ramadanService.getRamadanBusinessOptimization();
    final strategies = ramadanService.getRamadanDealStrategies();
    final insights = ramadanService.getBusinessInsights();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🌙 Ramadan Business Optimization',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        
        // Seasonal revenue multiplier
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.moroccoGold.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.moroccoGold.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.trending_up, color: AppTheme.moroccoGold, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Revenue Multiplier: ${optimization['revenueMultiplier']}x',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.moroccoGold,
                      ),
                    ),
                    const Text(
                      'Seasonal dead hours optimization opportunities',
                      style: TextStyle(fontSize: 14, color: AppTheme.secondaryText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // Dead hour opportunities
        ...strategies.take(3).map((strategy) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.schedule,
                  color: AppTheme.moroccoGreen,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strategy['dealType'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${strategy['timeSlot']} • ${strategy['discountRange']} discount',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                strategy['targetRevenue'],
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.moroccoGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )),
        
        // Key insights button
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => RamadanInsightsDialog.show(context, insights),
            icon: const Icon(Icons.lightbulb_outline),
            label: const Text('View Ramadan Business Insights'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.moroccoGold,
              side: const BorderSide(color: AppTheme.moroccoGold),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}