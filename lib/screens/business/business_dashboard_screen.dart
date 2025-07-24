import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';

class BusinessDashboardScreen extends StatefulWidget {
  const BusinessDashboardScreen({super.key});

  @override
  State<BusinessDashboardScreen> createState() => _BusinessDashboardScreenState();
}

class _BusinessDashboardScreenState extends State<BusinessDashboardScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = [
    const Tab(text: 'Overview'),
    const Tab(text: 'Deals'),
    const Tab(text: 'Analytics'),
    const Tab(text: 'Settings'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Business info header
          _buildBusinessHeader(),

          // Tab bar
          TabBar(
            controller: _tabController,
            labelColor: AppTheme.moroccoGreen,
            unselectedLabelColor: AppTheme.secondaryText,
            indicatorColor: AppTheme.moroccoGreen,
            tabs: _tabs,
          ),

          // Tab views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildDealsTab(),
                _buildAnalyticsTab(),
                _buildSettingsTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createNewDeal,
        backgroundColor: AppTheme.moroccoGreen,
        icon: const Icon(Icons.add),
        label: const Text('Create Deal'),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Business Dashboard',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: _showNotifications,
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _showBusinessMenu,
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  Widget _buildBusinessHeader() {
    final businessData = MockData.businessData;
    final venue = businessData['venue'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.moroccoGreen, AppTheme.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    venue?.categoryIcon ?? '🏢',
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      venue?.name ?? 'Your Business',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      venue?.type ?? 'Business',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          venue?.address ?? 'Location',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${venue?.rating ?? 4.5}★',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildHeaderStat(
                  'Active Deals',
                  '${(businessData['activeDeals'] as List).length}',
                  Icons.local_fire_department,
                ),
              ),
              Expanded(
                child: _buildHeaderStat(
                  'This Month',
                  '${businessData['monthlyStats']['platformRevenue']} MAD',
                  Icons.trending_up,
                ),
              ),
              Expanded(
                child: _buildHeaderStat(
                  'Customers',
                  '${businessData['monthlyStats']['newCustomers']}',
                  Icons.people,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick stats
          _buildQuickStats(),
          const SizedBox(height: 24),

          // Recent activity
          _buildSectionHeader('Recent Activity'),
          const SizedBox(height: 12),
          _buildRecentActivity(),
          const SizedBox(height: 24),

          // Performance insights
          _buildSectionHeader('Performance Insights'),
          const SizedBox(height: 12),
          _buildPerformanceInsights(),
          const SizedBox(height: 24),

          // Quick actions
          _buildSectionHeader('Quick Actions'),
          const SizedBox(height: 12),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Today\'s Revenue',
            value: '2,450 MAD',
            change: '+12%',
            changeColor: AppColors.success,
            icon: Icons.attach_money,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Bookings',
            value: '23',
            change: '+8%',
            changeColor: AppColors.success,
            icon: Icons.book_online,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String change,
    required Color changeColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.moroccoGreen, size: 20),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: changeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 10,
                    color: changeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
              color: AppTheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    final activities = [
      {
        'icon': Icons.book_online,
        'title': 'New booking for lunch deal',
        'subtitle': '2 people • 12:30 PM',
        'time': '5 min ago',
        'color': AppColors.success,
      },
      {
        'icon': Icons.star,
        'title': 'New 5-star review',
        'subtitle': '"Amazing food and great service!"',
        'time': '1 hour ago',
        'color': AppColors.warning,
      },
      {
        'icon': Icons.local_fire_department,
        'title': 'Deal performance alert',
        'subtitle': 'Afternoon coffee deal is trending',
        'time': '2 hours ago',
        'color': AppColors.error,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: Colors.grey.shade200,
        ),
        itemBuilder: (context, index) {
          final activity = activities[index];
          return ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (activity['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                activity['icon'] as IconData,
                color: activity['color'] as Color,
                size: 20,
              ),
            ),
            title: Text(
              activity['title'] as String,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              activity['subtitle'] as String,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryText,
              ),
            ),
            trailing: Text(
              activity['time'] as String,
              style: const TextStyle(
                fontSize: 10,
                color: AppTheme.lightText,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPerformanceInsights() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.insights,
                color: AppTheme.moroccoGreen,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Key Insights',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInsightItem(
            '🔥',
            'Peak Hours',
            'Your busiest time is 2-4 PM with 85% booking rate',
          ),
          const SizedBox(height: 12),
          _buildInsightItem(
            '💰',
            'Best Performing Deal',
            'Afternoon coffee deal generates 40% more revenue',
          ),
          const SizedBox(height: 12),
          _buildInsightItem(
            '📈',
            'Growth Opportunity',
            'Consider adding evening deals to boost revenue',
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String emoji, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.add,
            label: 'Create Deal',
            onTap: _createNewDeal,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.analytics,
            label: 'View Analytics',
            onTap: () => _tabController.animateTo(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.settings,
            label: 'Settings',
            onTap: () => _tabController.animateTo(3),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.moroccoGreen, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDealsTab() {
    final activeDeals = MockData.deals.where((deal) => deal.isValid).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Deal stats
          Row(
            children: [
              Expanded(
                child: _buildDealStatCard(
                  'Active Deals',
                  '${activeDeals.length}',
                  Icons.local_fire_department,
                  AppColors.error,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDealStatCard(
                  'Total Bookings',
                  '156',
                  Icons.book_online,
                  AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Active deals list
          _buildSectionHeader('Active Deals'),
          const SizedBox(height: 12),
          ...activeDeals.map((deal) => _buildDealCard(deal)),
        ],
      ),
    );
  }

  Widget _buildDealStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
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
              color: AppTheme.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDealCard(dynamic deal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(deal.statusIcon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  deal.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  deal.discountDisplay,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            deal.description,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildDealMetric('Bookings', '${deal.currentBookings}'),
              const SizedBox(width: 16),
              _buildDealMetric('Revenue', '${(deal.discountedPrice * deal.currentBookings).toInt()} MAD'),
              const SizedBox(width: 16),
              _buildDealMetric('Spots Left', '${deal.availableSpots}'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _editDeal(deal),
                  child: const Text('Edit'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _viewDealAnalytics(deal),
                  child: const Text('Analytics'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDealMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Revenue Analytics'),
          const SizedBox(height: 12),
          _buildRevenueChart(),
          const SizedBox(height: 24),
          _buildSectionHeader('Customer Insights'),
          const SizedBox(height: 12),
          _buildCustomerInsights(),
          const SizedBox(height: 24),
          _buildSectionHeader('Deal Performance'),
          const SizedBox(height: 12),
          _buildDealPerformance(),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart,
              size: 48,
              color: AppTheme.lightText,
            ),
            SizedBox(height: 16),
            Text(
              'Revenue Chart',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.secondaryText,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Interactive charts would be implemented here',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.lightText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInsights() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInsightRow('Peak Hours', '2:00 PM - 4:00 PM', Icons.schedule),
          const Divider(),
          _buildInsightRow('Average Spend', '85 MAD per customer', Icons.attach_money),
          const Divider(),
          _buildInsightRow('Return Rate', '68% customers return', Icons.repeat),
          const Divider(),
          _buildInsightRow('Rating', '4.8/5 average rating', Icons.star),
        ],
      ),
    );
  }

  Widget _buildInsightRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.moroccoGreen, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealPerformance() {
    final performanceData = [
      {'name': 'Afternoon Coffee', 'bookings': 45, 'revenue': 2250},
      {'name': 'Lunch Special', 'bookings': 32, 'revenue': 1920},
      {'name': 'Happy Hour', 'bookings': 28, 'revenue': 1680},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: performanceData.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: Colors.grey.shade200,
        ),
        itemBuilder: (context, index) {
          final deal = performanceData[index];
          return ListTile(
            title: Text(
              deal['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('${deal['bookings']} bookings'),
            trailing: Text(
              '${deal['revenue']} MAD',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.moroccoGreen,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Business Information'),
          const SizedBox(height: 12),
          _buildBusinessSettings(),
          const SizedBox(height: 24),
          _buildSectionHeader('Notification Settings'),
          const SizedBox(height: 12),
          _buildNotificationSettings(),
          const SizedBox(height: 24),
          _buildSectionHeader('Account Management'),
          const SizedBox(height: 12),
          _buildAccountSettings(),
        ],
      ),
    );
  }

  Widget _buildBusinessSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('Business Details'),
            subtitle: const Text('Name, address, contact info'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Operating Hours'),
            subtitle: const Text('Set your business hours'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Photos & Media'),
            subtitle: const Text('Manage venue photos'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.book_online),
            title: const Text('New Bookings'),
            subtitle: const Text('Get notified of new bookings'),
            value: true,
            onChanged: (value) {},
            activeColor: AppTheme.moroccoGreen,
          ),
          const Divider(height: 1),
          SwitchListTile(
            secondary: const Icon(Icons.star),
            title: const Text('Reviews'),
            subtitle: const Text('Get notified of new reviews'),
            value: true,
            onChanged: (value) {},
            activeColor: AppTheme.moroccoGreen,
          ),
          const Divider(height: 1),
          SwitchListTile(
            secondary: const Icon(Icons.analytics),
            title: const Text('Analytics Reports'),
            subtitle: const Text('Weekly performance reports'),
            value: false,
            onChanged: (value) {},
            activeColor: AppTheme.moroccoGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.workspace_premium, color: AppTheme.moroccoGold),
            title: const Text('Upgrade to Premium'),
            subtitle: const Text('Get more features and analytics'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _showPremiumUpgrade,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            subtitle: const Text('Get help with your account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text('Sign Out'),
            subtitle: const Text('Sign out of business account'),
            onTap: _signOut,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.book_online, color: AppColors.success),
              title: Text('New Booking'),
              subtitle: Text('Table for 2 at 2:30 PM'),
              dense: true,
            ),
            ListTile(
              leading: Icon(Icons.star, color: AppColors.warning),
              title: Text('New Review'),
              subtitle: Text('5 stars - "Great service!"'),
              dense: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showBusinessMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Business Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.switch_account),
              title: const Text('Switch to Customer Mode'),
              onTap: () {
                Navigator.pop(context);
                context.go('/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Business Profile'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Business Help'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _createNewDeal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Deal'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Deal Title',
                hintText: 'e.g., Afternoon Coffee Special',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Discount Percentage',
                hintText: 'e.g., 40',
                suffixText: '%',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Valid Until',
                hintText: 'e.g., 6 PM today',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Deal created successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _editDeal(dynamic deal) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit deal feature not implemented in mockup'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _viewDealAnalytics(dynamic deal) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deal analytics feature not implemented in mockup'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showPremiumUpgrade() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.workspace_premium, color: AppTheme.moroccoGold),
            SizedBox(width: 8),
            Text('Business Premium'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upgrade to Premium for:'),
            SizedBox(height: 8),
            Text('• Advanced analytics'),
            Text('• Priority support'),
            Text('• Custom branding'),
            Text('• API access'),
            Text('• Bulk deal management'),
            SizedBox(height: 16),
            Text(
              '299 MAD/month',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.moroccoGreen,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Premium upgrade not implemented in mockup'),
                  backgroundColor: AppColors.info,
                ),
              );
            },
            child: const Text('Upgrade Now'),
          ),
        ],
      ),
    );
  }

  void _signOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out of your business account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
