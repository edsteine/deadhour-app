import '../../../utils/mock_data.dart';
import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import 'analytics_revenue_card_widget.dart';
import 'analytics_weekly_chart_widget.dart';
import 'analytics_revenue_source_widget.dart';

/// Revenue tab widget showing revenue analytics
class AnalyticsRevenueTabWidget extends StatelessWidget {
  final String selectedPeriod;

  const AnalyticsRevenueTabWidget({
    super.key,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    final analytics = MockData.businessAnalytics;
    final monthlyRevenue = analytics['monthlyRevenue'] as Map<String, dynamic>;
    final weeklyTraffic =
        analytics['weeklyTraffic'] as List<Map<String, dynamic>>;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Revenue Summary Cards
          Row(
            children: [
              Expanded(
                child: AnalyticsRevenueCardWidget(
                  title: 'Total Revenue',
                  value: '${monthlyRevenue['total']} MAD',
                  subtitle: '+${monthlyRevenue['growth']}%',
                  color: AppTheme.moroccoGreen,
                  icon: Icons.attach_money,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnalyticsRevenueCardWidget(
                  title: 'Platform Commission',
                  value: '${monthlyRevenue['commission']} MAD',
                  subtitle: 'DeadHour fees',
                  color: AppTheme.moroccoGold,
                  icon: Icons.business,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: AnalyticsRevenueCardWidget(
                  title: 'Net Earnings',
                  value: '${monthlyRevenue['netEarnings']} MAD',
                  subtitle: 'After all fees',
                  color: AppTheme.darkGreen,
                  icon: Icons.trending_up,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnalyticsRevenueCardWidget(
                  title: 'Avg. Deal Value',
                  value: '${(monthlyRevenue['total'] as int) ~/ 45} MAD',
                  subtitle: 'Per transaction',
                  color: Colors.blue,
                  icon: Icons.local_offer,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Weekly Traffic Chart
          const Text(
            'Weekly Performance',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          AnalyticsWeeklyChartWidget(weeklyTraffic: weeklyTraffic),

          const SizedBox(height: 24),

          // Revenue Breakdown
          const Text(
            'Revenue Sources',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          const AnalyticsRevenueSourceWidget(
            source: 'Regular Bookings',
            amount: '2,890 MAD',
            percentage: '58%',
            color: AppTheme.moroccoGreen,
          ),
          const AnalyticsRevenueSourceWidget(
            source: 'Dead Hour Deals',
            amount: '1,340 MAD',
            percentage: '27%',
            color: AppTheme.moroccoGold,
          ),
          const AnalyticsRevenueSourceWidget(
            source: 'Premium Services',
            amount: '465 MAD',
            percentage: '9%',
            color: Colors.purple,
          ),
          const AnalyticsRevenueSourceWidget(
            source: 'Group Bookings',
            amount: '295 MAD',
            percentage: '6%',
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}