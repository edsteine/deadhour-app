import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/utils/mock_data.dart';

class DeadHoursTab extends StatelessWidget {
  final Function(BuildContext) showOptimizationSuggestions;
  final Function(BuildContext, Map<String, dynamic>) createTargetedDeal;
  final Function(BuildContext, Map<String, dynamic>) optimizeTimeSlot;

  const DeadHoursTab({
    super.key,
    required this.showOptimizationSuggestions,
    required this.createTargetedDeal,
    required this.optimizeTimeSlot,
  });

  @override
  Widget build(BuildContext context) {
    final analytics = MockData.businessAnalytics;
    final deadHours = analytics['deadHours'] as List<Map<String, dynamic>>;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dead Hours Overview
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.moroccoRed, AppTheme.moroccoGold],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.trending_down, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Revenue Opportunity',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'You\'re losing 2,340 MAD weekly during dead hours',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Optimize these periods to increase revenue by 35%',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => showOptimizationSuggestions(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.moroccoRed,
                  ),
                  child: const Text('Get AI Recommendations'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Dead Hours Breakdown
          const Text(
            'Dead Hours Analysis',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          ...deadHours.map((hour) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppTheme.moroccoRed.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.schedule,
                            color: AppTheme.moroccoRed,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hour['time'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${hour['occupancy']}% occupancy',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Lost: ${(100 - hour['occupancy'] as int) * 12} MAD',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.moroccoRed,
                              ),
                            ),
                            const Text(
                              'per day',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => createTargetedDeal(context, hour),
                            icon: const Icon(Icons.local_offer, size: 16),
                            label: const Text('Create Deal'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.moroccoGreen,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => optimizeTimeSlot(context, hour),
                            icon: const Icon(Icons.auto_fix_high, size: 16),
                            label: const Text('Optimize'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.moroccoGreen,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
