import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../../widgets/common/enhanced_app_bar.dart';

class AnalyticsDashboardScreen extends StatefulWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  State<AnalyticsDashboardScreen> createState() => _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState extends State<AnalyticsDashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'week';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const EnhancedAppBar(
        title: 'Business Analytics',
        subtitle: 'Deep insights into your performance',
        showBackButton: true,
        showGradient: true,
      ),
      body: Column(
        children: [
          _buildPeriodSelector(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRevenueTab(),
                _buildCustomerTab(),
                _buildPerformanceTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          'week',
          'month',
          'quarter',
          'year',
        ].map((period) {
          final isSelected = _selectedPeriod == period;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedPeriod = period;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.moroccoGreen : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppTheme.moroccoGreen : Colors.grey[300]!,
                ),
              ),
              child: Text(
                period.toUpperCase(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppTheme.moroccoGreen,
        labelColor: AppTheme.moroccoGreen,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: 'Revenue'),
          Tab(text: 'Customers'),
          Tab(text: 'Performance'),
        ],
      ),
    );
  }

  Widget _buildRevenueTab() {
    final analytics = MockData.businessAnalytics;
    final monthlyRevenue = analytics['monthlyRevenue'] as Map<String, dynamic>;
    final weeklyTraffic = analytics['weeklyTraffic'] as List<Map<String, dynamic>>;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Revenue Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildRevenueCard(
                  'Total Revenue',
                  '${monthlyRevenue['total']} MAD',
                  '+${monthlyRevenue['growth']}%',
                  AppTheme.moroccoGreen,
                  Icons.attach_money,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildRevenueCard(
                  'Platform Commission',
                  '${monthlyRevenue['commission']} MAD',
                  'DeadHour fees',
                  AppTheme.moroccoGold,
                  Icons.business,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildRevenueCard(
                  'Net Earnings',
                  '${monthlyRevenue['netEarnings']} MAD',
                  'After all fees',
                  AppTheme.darkGreen,
                  Icons.trending_up,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildRevenueCard(
                  'Avg. Deal Value',
                  '${(monthlyRevenue['total'] as int) ~/ 45} MAD',
                  'Per transaction',
                  Colors.blue,
                  Icons.local_offer,
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

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Daily Occupancy %',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Peak: ${weeklyTraffic.map((d) => d['occupancy'] as int).reduce((a, b) => a > b ? a : b)}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: weeklyTraffic.map((day) {
                      final occupancy = day['occupancy'] as int;
                      final height = (occupancy / 100) * 120;
                      
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '$occupancy%',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 20,
                            height: height,
                            decoration: BoxDecoration(
                              color: occupancy > 70 
                                  ? AppTheme.moroccoGreen
                                  : occupancy > 40 
                                      ? AppTheme.moroccoGold
                                      : AppTheme.moroccoRed,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            day['day'] as String,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Revenue Breakdown
          const Text(
            'Revenue Sources',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildRevenueSource('Regular Bookings', '2,890 MAD', '58%', AppTheme.moroccoGreen),
          _buildRevenueSource('Dead Hour Deals', '1,340 MAD', '27%', AppTheme.moroccoGold),
          _buildRevenueSource('Premium Services', '465 MAD', '9%', Colors.purple),
          _buildRevenueSource('Group Bookings', '295 MAD', '6%', Colors.blue),
        ],
      ),
    );
  }

  Widget _buildCustomerTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer Metrics
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Total Customers',
                  '1,247',
                  '+23 this week',
                  AppTheme.moroccoGreen,
                  Icons.people,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  'Repeat Customers',
                  '68%',
                  'Loyalty rate',
                  AppTheme.moroccoGold,
                  Icons.favorite,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Avg. Spend',
                  '125 MAD',
                  'Per visit',
                  Colors.blue,
                  Icons.receipt,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  'Customer Rating',
                  '4.7★',
                  'Average rating',
                  Colors.amber,
                  Icons.star,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Customer Demographics
          const Text(
            'Customer Demographics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                _buildDemographicRow('Age 18-25', '32%', AppTheme.moroccoGreen),
                _buildDemographicRow('Age 26-35', '41%', AppTheme.moroccoGold),
                _buildDemographicRow('Age 36-45', '19%', Colors.blue),
                _buildDemographicRow('Age 45+', '8%', Colors.grey),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Peak Hours
          const Text(
            'Customer Peak Hours',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                _buildPeakHourRow('12:00-14:00', 'Lunch Rush', '89%', AppTheme.moroccoGreen),
                _buildPeakHourRow('19:00-21:00', 'Dinner Time', '76%', AppTheme.moroccoGold),
                _buildPeakHourRow('15:00-17:00', 'Afternoon Coffee', '34%', AppTheme.moroccoRed),
                _buildPeakHourRow('21:00-23:00', 'Late Night', '28%', Colors.grey),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Customer Feedback
          const Text(
            'Recent Customer Feedback',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildFeedbackCard(
            'Amazing atmosphere and great deals!',
            'Sarah M.',
            5,
            '2 days ago',
          ),
          _buildFeedbackCard(
            'Perfect place for business meetings.',
            'Ahmed K.',
            4,
            '1 week ago',
          ),
          _buildFeedbackCard(
            'Love the dead hour discounts!',
            'Fatima Z.',
            5,
            '1 week ago',
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Performance Metrics
          const Text(
            'Key Performance Indicators',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildKPICard(
            'Occupancy Rate',
            '73%',
            '+5% vs last month',
            AppTheme.moroccoGreen,
            Icons.event_seat,
            true,
          ),

          _buildKPICard(
            'Dead Hours Filled',
            '68%',
            '+12% vs last month',
            AppTheme.moroccoGold,
            Icons.schedule,
            true,
          ),

          _buildKPICard(
            'Average Wait Time',
            '8 min',
            '-3 min vs last month',
            Colors.blue,
            Icons.timer,
            true,
          ),

          _buildKPICard(
            'Customer Retention',
            '68%',
            '-2% vs last month',
            AppTheme.moroccoRed,
            Icons.people_outline,
            false,
          ),

          const SizedBox(height: 24),

          // Competitor Comparison
          const Text(
            'Competitor Benchmarking',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                _buildCompetitorMetric('Revenue per sqm', 'You: 1,200 MAD', 'Market avg: 980 MAD', true),
                const Divider(),
                _buildCompetitorMetric('Customer Rating', 'You: 4.7★', 'Market avg: 4.2★', true),
                const Divider(),
                _buildCompetitorMetric('Pricing', 'You: 125 MAD', 'Market avg: 135 MAD', false),
                const Divider(),
                _buildCompetitorMetric('Wait Time', 'You: 8 min', 'Market avg: 12 min', true),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Recommendations
          const Text(
            'Improvement Recommendations',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildRecommendationCard(
            Icons.trending_up,
            'Increase Lunch Capacity',
            'Your lunch hours are at 89% capacity. Consider expanding seating or offering takeaway options.',
            'High Impact',
            AppTheme.moroccoGreen,
          ),

          _buildRecommendationCard(
            Icons.schedule,
            'Optimize Dead Hours',
            'Tuesday 15:00-17:00 shows lowest occupancy. Create targeted promotions for this slot.',
            'Medium Impact',
            AppTheme.moroccoGold,
          ),

          _buildRecommendationCard(
            Icons.star,
            'Improve Service Speed',
            'Reduce average wait time to under 6 minutes to match top performers in your category.',
            'Low Impact',
            Colors.blue,
          ),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _buildRevenueCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueSource(String source, String amount, String percentage, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  source,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemographicRow(String category, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              category,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeakHourRow(String time, String label, String occupancy, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              occupancy,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(String feedback, String customer, int rating, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feedback,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                customer,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              ...List.generate(5, (index) => Icon(
                Icons.star,
                size: 12,
                color: index < rating ? Colors.amber : Colors.grey[300],
              )),
              const Spacer(),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKPICard(String title, String value, String change, Color color, IconData icon, bool isGood) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                isGood ? Icons.trending_up : Icons.trending_down,
                color: isGood ? Colors.green : Colors.red,
                size: 16,
              ),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  color: isGood ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitorMetric(String metric, String yours, String market, bool isBetter) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metric,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  yours,
                  style: TextStyle(
                    fontSize: 12,
                    color: isBetter ? AppTheme.moroccoGreen : AppTheme.moroccoRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  market,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isBetter ? Icons.check_circle : Icons.warning,
            color: isBetter ? AppTheme.moroccoGreen : AppTheme.moroccoGold,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(IconData icon, String title, String description, String impact, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        impact,
                        style: TextStyle(
                          fontSize: 10,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}