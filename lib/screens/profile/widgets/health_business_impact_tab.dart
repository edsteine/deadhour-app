import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

/// Business impact tab showing revenue correlation and deal performance
class HealthBusinessImpactTab extends StatelessWidget {
  const HealthBusinessImpactTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Revenue Correlation'),
          const SizedBox(height: AppTheme.spacing12),
          _buildRevenueCorrelation(),
          const SizedBox(height: AppTheme.spacing24),
          _buildSectionTitle('Deal Performance by Room'),
          const SizedBox(height: AppTheme.spacing12),
          _buildDealPerformance(),
        ],
      ),
    );
  }

  Widget _buildRevenueCorrelation() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Community Discussion → Booking Conversion',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            _buildCorrelationMetric('High Discussion Deals', '67%', 'conversion rate'),
            _buildCorrelationMetric('Low Discussion Deals', '23%', 'conversion rate'),
            _buildCorrelationMetric('Community Recommended', '78%', 'customer satisfaction'),
            const SizedBox(height: AppTheme.spacing16),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: const Text(
                '💡 Insight: Deals with 10+ community messages have 3x higher booking rates',
                style: TextStyle(
                  color: AppTheme.moroccoGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorrelationMetric(String label, String value, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.moroccoGreen,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealPerformance() {
    final dealData = [
      {'room': '🍕 Food & Dining', 'deals': 45, 'bookings': 234, 'revenue': '€12,400'},
      {'room': '🎮 Entertainment', 'deals': 32, 'bookings': 156, 'revenue': '€8,900'},
      {'room': '💆 Wellness', 'deals': 28, 'bookings': 189, 'revenue': '€15,600'},
      {'room': '🌍 Tourism', 'deals': 22, 'bookings': 98, 'revenue': '€6,700'},
    ];

    return Column(
      children: dealData.map((data) => Card(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  data['room'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${data['deals']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      'deals',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${data['bookings']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppTheme.moroccoGreen,
                      ),
                    ),
                    const Text(
                      'bookings',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      data['revenue'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.purple,
                      ),
                    ),
                    const Text(
                      'revenue',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}