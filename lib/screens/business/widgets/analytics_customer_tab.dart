import 'package:flutter/material.dart';
import 'package:deadhour/screens/business/widgets/analytics_metric_card.dart';
import 'package:deadhour/screens/business/widgets/analytics_demographic_widget.dart';
import 'package:deadhour/screens/business/widgets/analytics_peak_hours_widget.dart';
import 'package:deadhour/screens/business/widgets/analytics_feedback_widget.dart';

class AnalyticsCustomerTab extends StatelessWidget {
  const AnalyticsCustomerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer Metrics Cards
          Row(
            children: [
              Expanded(
                child: AnalyticsMetricCard(
                  title: 'Total Customers',
                  value: '1,247',
                  change: '+12.5%',
                  changeColor: Colors.green,
                  icon: Icons.people,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: AnalyticsMetricCard(
                  title: 'New Customers',
                  value: '89',
                  change: '+8.2%',
                  changeColor: Colors.green,
                  icon: Icons.person_add,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AnalyticsMetricCard(
                  title: 'Returning Rate',
                  value: '68%',
                  change: '+4.1%',
                  changeColor: Colors.green,
                  icon: Icons.refresh,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: AnalyticsMetricCard(
                  title: 'Avg. Spend',
                  value: '€28',
                  change: '-2.3%',
                  changeColor: Colors.red,
                  icon: Icons.euro,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Demographics
          Text(
            'Customer Demographics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          AnalyticsDemographicWidget(),
          SizedBox(height: 24),

          // Peak Hours
          Text(
            'Peak Customer Hours',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          AnalyticsPeakHoursWidget(),
          SizedBox(height: 24),

          // Customer Feedback
          Text(
            'Customer Feedback',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          AnalyticsFeedbackWidget(),
        ],
      ),
    );
  }
}