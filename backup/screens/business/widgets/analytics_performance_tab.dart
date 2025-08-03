import 'package:flutter/material.dart';
import 'analytics_kpi_card.dart';
import 'analytics_competitor_widget.dart';
import 'analytics_recommendations_widget.dart';

class AnalyticsPerformanceTab extends StatelessWidget {
  const AnalyticsPerformanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KPI Cards
          Row(
            children: [
              Expanded(
                child: AnalyticsKPICard(
                  title: 'Conversion Rate',
                  value: '12.4%',
                  change: '+2.1%',
                  color: Colors.blue,
                  icon: Icons.trending_up,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: AnalyticsKPICard(
                  title: 'Deal Success',
                  value: '89%',
                  change: '+5.3%',
                  color: Colors.green,
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AnalyticsKPICard(
                  title: 'Utilization',
                  value: '76%',
                  change: '+8.7%',
                  color: Colors.orange,
                  icon: Icons.schedule,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: AnalyticsKPICard(
                  title: 'Rating',
                  value: '4.6',
                  change: '+0.2',
                  color: Colors.amber,
                  icon: Icons.star,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Competitor Analysis
          Text(
            'Competitor Analysis',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          AnalyticsCompetitorWidget(),
          SizedBox(height: 24),

          // Recommendations
          Text(
            'Improvement Recommendations',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          AnalyticsRecommendationsWidget(),
        ],
      ),
    );
  }
}