import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/theme.dart';
import '../../widgets/common/dead_hour_app_bar.dart';
import '../../services/cultural_calendar_service.dart';

class CommunityHealthDashboardScreen extends ConsumerStatefulWidget {
  const CommunityHealthDashboardScreen({super.key});

  @override
  ConsumerState<CommunityHealthDashboardScreen> createState() => 
      _CommunityHealthDashboardScreenState();
}

class _CommunityHealthDashboardScreenState 
    extends ConsumerState<CommunityHealthDashboardScreen> 
    with TickerProviderStateMixin {
  
  // final _analyticsService = AnalyticsService(); // TODO: Implement when needed
  final _culturalService = CulturalCalendarService();
  late TabController _tabController;
  String _selectedTimeRange = '7d';
  String _selectedCity = 'Casablanca';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeadHourAppBar(
        title: 'Community Health',
        subtitle: 'Analytics & Engagement Insights',
        showBackButton: true,
        showMenuDrawer: true,
      ),
      body: Column(
        children: [
          _buildControlsHeader(),
          _buildMetricsOverview(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRoomActivityTab(),
                _buildUserEngagementTab(),
                _buildCulturalInsightsTab(),
                _buildBusinessImpactTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlsHeader() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Time Range Selector
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Time Range',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                DropdownButton<String>(
                  value: _selectedTimeRange,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: '24h', child: Text('Last 24 Hours')),
                    DropdownMenuItem(value: '7d', child: Text('Last 7 Days')),
                    DropdownMenuItem(value: '30d', child: Text('Last 30 Days')),
                    DropdownMenuItem(value: '90d', child: Text('Last 3 Months')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedTimeRange = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          // City Selector
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'City',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                DropdownButton<String>(
                  value: _selectedCity,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All Cities')),
                    DropdownMenuItem(value: 'Casablanca', child: Text('Casablanca')),
                    DropdownMenuItem(value: 'Marrakech', child: Text('Marrakech')),
                    DropdownMenuItem(value: 'Rabat', child: Text('Rabat')),
                    DropdownMenuItem(value: 'Fez', child: Text('Fez')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsOverview() {
    final metrics = _getOverviewMetrics();
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Row(
        children: [
          Expanded(child: _buildMetricCard(
            'Active Rooms', 
            metrics['activeRooms'].toString(),
            Icons.forum,
            Colors.blue,
            '+12% vs last period',
          )),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(child: _buildMetricCard(
            'Daily Messages', 
            metrics['dailyMessages'].toString(),
            Icons.message,
            AppTheme.moroccoGreen,
            '+8% vs last period',
          )),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(child: _buildMetricCard(
            'Active Users', 
            metrics['activeUsers'].toString(),
            Icons.people,
            Colors.orange,
            '+15% vs last period',
          )),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(child: _buildMetricCard(
            'Conversion Rate', 
            '${metrics['conversionRate']}%',
            Icons.trending_up,
            Colors.purple,
            '+3% vs last period',
          )),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String trend) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const Spacer(),
              const Icon(Icons.trending_up, color: Colors.green, size: 16),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            trend,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: AppTheme.moroccoGreen,
      unselectedLabelColor: Colors.grey,
      indicatorColor: AppTheme.moroccoGreen,
      isScrollable: true,
      tabs: const [
        Tab(text: 'Room Activity'),
        Tab(text: 'User Engagement'),
        Tab(text: 'Cultural Insights'),
        Tab(text: 'Business Impact'),
      ],
    );
  }

  Widget _buildRoomActivityTab() {
    final roomData = _getRoomActivityData();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Most Active Rooms'),
          const SizedBox(height: AppTheme.spacing12),
          ...roomData.map((room) => _buildRoomActivityCard(room)),
          const SizedBox(height: AppTheme.spacing24),
          _buildSectionTitle('Activity Heatmap'),
          const SizedBox(height: AppTheme.spacing12),
          _buildActivityHeatmap(),
        ],
      ),
    );
  }

  Widget _buildRoomActivityCard(Map<String, dynamic> room) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing8),
              decoration: BoxDecoration(
                color: (room['categoryColor'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Icon(
                room['icon'] as IconData,
                color: room['categoryColor'] as Color,
                size: 20,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${room['category']} • ${room['members']} members',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${room['messages']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
                const Text(
                  'messages/day',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityHeatmap() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart, size: 48, color: Colors.grey),
          SizedBox(height: AppTheme.spacing8),
          Text(
            'Activity Heatmap',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Shows peak activity hours across all rooms',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserEngagementTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Top Contributors'),
          const SizedBox(height: AppTheme.spacing12),
          _buildTopContributors(),
          const SizedBox(height: AppTheme.spacing24),
          _buildSectionTitle('Engagement Trends'),
          const SizedBox(height: AppTheme.spacing12),
          _buildEngagementChart(),
        ],
      ),
    );
  }

  Widget _buildTopContributors() {
    final contributors = [
      {'name': 'Fatima M.', 'messages': 247, 'helpfulVotes': 89, 'avatar': 'F'},
      {'name': 'Ahmed K.', 'messages': 198, 'helpfulVotes': 76, 'avatar': 'A'},
      {'name': 'Aicha B.', 'messages': 156, 'helpfulVotes': 54, 'avatar': 'A'},
      {'name': 'Youssef R.', 'messages': 134, 'helpfulVotes': 43, 'avatar': 'Y'},
    ];

    return Column(
      children: contributors.map((user) => Card(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppTheme.moroccoGreen,
            child: Text(
              user['avatar'] as String,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(user['name'] as String),
          subtitle: Text('${user['messages']} messages • ${user['helpfulVotes']} helpful votes'),
          trailing: const Icon(Icons.star, color: Colors.amber),
        ),
      )).toList(),
    );
  }

  Widget _buildEngagementChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.trending_up, size: 48, color: Colors.grey),
          SizedBox(height: AppTheme.spacing8),
          Text(
            'Engagement Trends',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'User engagement patterns over time',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCulturalInsightsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Prayer Time Impact'),
          const SizedBox(height: AppTheme.spacing12),
          _buildPrayerTimeAnalysis(),
          const SizedBox(height: AppTheme.spacing24),
          _buildSectionTitle('Ramadan Engagement'),
          const SizedBox(height: AppTheme.spacing12),
          _buildRamadanAnalysis(),
          const SizedBox(height: AppTheme.spacing24),
          _buildSectionTitle('Cultural Events Correlation'),
          const SizedBox(height: AppTheme.spacing12),
          _buildCulturalEventsAnalysis(),
        ],
      ),
    );
  }

  Widget _buildPrayerTimeAnalysis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.access_time, color: AppTheme.moroccoGreen),
                SizedBox(width: AppTheme.spacing8),
                Text(
                  'Activity During Prayer Times',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            _buildInsightRow('Messages drop by', '78%', 'during prayer times'),
            _buildInsightRow('Recovery time', '15 min', 'average after prayer'),
            _buildInsightRow('Respectful users', '94%', 'follow prayer-aware posting'),
          ],
        ),
      ),
    );
  }

  Widget _buildRamadanAnalysis() {
    final isRamadan = _culturalService.isRamadan();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.nightlight_round, color: Colors.purple),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  isRamadan ? 'Current Ramadan Activity' : 'Last Ramadan Analysis',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            _buildInsightRow('Iftar deals engagement', '+230%', 'vs regular periods'),
            _buildInsightRow('Suhoor activity', '+145%', 'early morning bookings'),
            _buildInsightRow('Community solidarity', '89%', 'users share breaking fast'),
          ],
        ),
      ),
    );
  }

  Widget _buildCulturalEventsAnalysis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.celebration, color: Colors.orange),
                SizedBox(width: AppTheme.spacing8),
                Text(
                  'Cultural Events Impact',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            _buildInsightRow('Eid celebrations', '+340%', 'community activity'),
            _buildInsightRow('National holidays', '+180%', 'local venue bookings'),
            _buildInsightRow('Traditional festivals', '+120%', 'cultural content sharing'),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightRow(String label, String value, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.moroccoGreen,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
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

  Widget _buildBusinessImpactTab() {
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

  // Data Methods
  Map<String, dynamic> _getOverviewMetrics() {
    return {
      'activeRooms': 47,
      'dailyMessages': 2847,
      'activeUsers': 1234,
      'conversionRate': 34,
    };
  }

  List<Map<String, dynamic>> _getRoomActivityData() {
    return [
      {
        'name': 'Food Lovers Casablanca',
        'category': 'Food & Dining',
        'members': 1247,
        'messages': 87,
        'icon': Icons.restaurant,
        'categoryColor': Colors.orange,
      },
      {
        'name': 'Marrakech Entertainment',
        'category': 'Entertainment',
        'members': 892,
        'messages': 64,
        'icon': Icons.movie,
        'categoryColor': Colors.purple,
      },
      {
        'name': 'Wellness Warriors',
        'category': 'Wellness',
        'members': 567,
        'messages': 43,
        'icon': Icons.spa,
        'categoryColor': Colors.green,
      },
      {
        'name': 'Cultural Explorers',
        'category': 'Tourism',
        'members': 723,
        'messages': 38,
        'icon': Icons.explore,
        'categoryColor': Colors.blue,
      },
    ];
  }
}