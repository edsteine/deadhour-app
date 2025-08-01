import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';






/// Customer tab widget showing customer analytics
class AnalyticsCustomerTabWidget extends StatelessWidget {
  final String selectedPeriod;

  const AnalyticsCustomerTabWidget({
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
          // Customer Metrics
          Row(
            children: [
              Expanded(
                child: AnalyticsMetricCardWidget(
                  title: 'Total Customers',
                  value: '1,247',
                  subtitle: '+23 this week',
                  color: AppTheme.moroccoGreen,
                  icon: Icons.people,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: AnalyticsMetricCardWidget(
                  title: 'Repeat Customers',
                  value: '68%',
                  subtitle: 'Loyalty rate',
                  color: AppTheme.moroccoGold,
                  icon: Icons.favorite,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: AnalyticsMetricCardWidget(
                  title: 'Avg. Spend',
                  value: '125 MAD',
                  subtitle: 'Per visit',
                  color: Colors.blue,
                  icon: Icons.receipt,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: AnalyticsMetricCardWidget(
                  title: 'Customer Rating',
                  value: '4.7★',
                  subtitle: 'Average rating',
                  color: Colors.amber,
                  icon: Icons.star,
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Customer Demographics
          Text(
            'Customer Demographics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          AnalyticsDemographicWidget(),

          SizedBox(height: 24),

          // Peak Hours
          Text(
            'Customer Peak Hours',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          AnalyticsPeakHoursWidget(),

          SizedBox(height: 24),

          // Customer Feedback
          Text(
            'Recent Customer Feedback',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          AnalyticsFeedbackWidget(
            feedback: 'Amazing atmosphere and great deals!',
            customer: 'Sarah M.',
            rating: 5,
            time: '2 days ago',
          ),
          AnalyticsFeedbackWidget(
            feedback: 'Perfect place for business meetings.',
            customer: 'Ahmed K.',
            rating: 4,
            time: '1 week ago',
          ),
          AnalyticsFeedbackWidget(
            feedback: 'Love the dead hour discounts!',
            customer: 'Fatima Z.',
            rating: 5,
            time: '1 week ago',
          ),
        ],
      ),
    );
  }
}