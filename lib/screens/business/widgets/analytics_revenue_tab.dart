import 'package:flutter/material.dart';
import 'package:deadhour/screens/business/widgets/analytics_revenue_card.dart';
import 'package:deadhour/screens/business/widgets/analytics_revenue_source_widget.dart';
import 'package:deadhour/screens/business/widgets/analytics_weekly_chart_widget.dart';

class AnalyticsRevenueTab extends StatelessWidget {
  final String selectedPeriod;

  const AnalyticsRevenueTab({
    super.key,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Revenue Overview Cards
          Row(
            children: [
              Expanded(
                child: AnalyticsRevenueCard(
                  title: 'Total Revenue',
                  amount: '€12,450',
                  change: '+15.3%',
                  changeColor: Colors.green,
                  period: selectedPeriod,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnalyticsRevenueCard(
                  title: 'Dead Hour Revenue',
                  amount: '€4,280',
                  change: '+28.7%',
                  changeColor: Colors.green,
                  period: selectedPeriod,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Revenue Chart
          const Text(
            'Revenue Trend',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const AnalyticsWeeklyChartWidget(),
          const SizedBox(height: 24),

          // Revenue Sources
          const Text(
            'Revenue Sources',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const AnalyticsRevenueSourceWidget(),
        ],
      ),
    );
  }
}