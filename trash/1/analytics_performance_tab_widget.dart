import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import 'analytics_kpi_card_widget.dart';
import 'analytics_competitor_widget.dart';
import 'analytics_recommendations_widget.dart';

/// Performance tab widget showing performance analytics
class AnalyticsPerformanceTabWidget extends StatelessWidget {
  final String selectedPeriod;

  const AnalyticsPerformanceTabWidget({
    super.key,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Performance Metrics
          Text(
            'Key Performance Indicators',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          AnalyticsKpiCardWidget(
            title: 'Occupancy Rate',
            value: '73%',
            change: '+5% vs last month',
            color: AppTheme.moroccoGreen,
            icon: Icons.event_seat,
            isGood: true,
          ),

          AnalyticsKpiCardWidget(
            title: 'Dead Hours Filled',
            value: '68%',
            change: '+12% vs last month',
            color: AppTheme.moroccoGold,
            icon: Icons.schedule,
            isGood: true,
          ),

          AnalyticsKpiCardWidget(
            title: 'Average Wait Time',
            value: '8 min',
            change: '-3 min vs last month',
            color: Colors.blue,
            icon: Icons.timer,
            isGood: true,
          ),

          AnalyticsKpiCardWidget(
            title: 'Customer Retention',
            value: '68%',
            change: '-2% vs last month',
            color: AppTheme.moroccoRed,
            icon: Icons.people_outline,
            isGood: false,
          ),

          SizedBox(height: 24),

          // Competitor Comparison
          Text(
            'Competitor Benchmarking',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          AnalyticsCompetitorWidget(),

          SizedBox(height: 24),

          // Recommendations
          Text(
            'Improvement Recommendations',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          AnalyticsRecommendationsWidget(
            icon: Icons.trending_up,
            title: 'Increase Lunch Capacity',
            description: 'Your lunch hours are at 89% capacity. Consider expanding seating or offering takeaway options.',
            impact: 'High Impact',
            color: AppTheme.moroccoGreen,
          ),

          AnalyticsRecommendationsWidget(
            icon: Icons.schedule,
            title: 'Optimize Dead Hours',
            description: 'Tuesday 15:00-17:00 shows lowest occupancy. Create targeted promotions for this slot.',
            impact: 'Medium Impact',
            color: AppTheme.moroccoGold,
          ),

          AnalyticsRecommendationsWidget(
            icon: Icons.star,
            title: 'Improve Service Speed',
            description: 'Reduce average wait time to under 6 minutes to match top performers in your category.',
            impact: 'Low Impact',
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}