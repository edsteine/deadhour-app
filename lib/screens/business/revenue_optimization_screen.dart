import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../../widgets/common/enhanced_app_bar.dart';

class RevenueOptimizationScreen extends StatefulWidget {
  const RevenueOptimizationScreen({super.key});

  @override
  State<RevenueOptimizationScreen> createState() => _RevenueOptimizationScreenState();
}

class _RevenueOptimizationScreenState extends State<RevenueOptimizationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTimeFrame = 'week';

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
      backgroundColor: AppTheme.backgroundColor,
      appBar: const EnhancedAppBar(
        title: 'Revenue Optimization',
        subtitle: 'Maximize your off-peak hour earnings',
        showBackButton: true,
        showGradient: true,
      ),
      body: Column(
        children: [
          _buildTimeFrameSelector(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDeadHoursTab(),
                _buildPricingTab(),
                _buildPromotionsTab(),
                _buildInsightsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeFrameSelector() {
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
          'today',
          'week',
          'month',
          'quarter',
        ].map((timeFrame) {
          final isSelected = _selectedTimeFrame == timeFrame;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeFrame = timeFrame;
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
                timeFrame.toUpperCase(),
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
        isScrollable: true,
        tabs: const [
          Tab(text: 'Dead Hours'),
          Tab(text: 'Smart Pricing'),
          Tab(text: 'Promotions'),
          Tab(text: 'AI Insights'),
        ],
      ),
    );
  }

  Widget _buildDeadHoursTab() {
    final analytics = MockData.businessAnalytics;
    final deadHours = analytics['deadHours'] as List<Map<String, dynamic>>;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dead Hours Overview
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.moroccoRed, AppTheme.moroccoGold],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.trending_down, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Revenue Opportunity',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'You\'re losing 2,340 MAD weekly during dead hours',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Optimize these periods to increase revenue by 35%',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _showOptimizationSuggestions,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.moroccoRed,
                  ),
                  child: const Text('Get AI Recommendations'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Dead Hours Breakdown
          const Text(
            'Dead Hours Analysis',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          ...deadHours.map((hour) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.moroccoRed.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.schedule,
                        color: AppTheme.moroccoRed,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hour['time'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${hour['occupancy']}% occupancy',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Lost: ${(100 - hour['occupancy'] as int) * 12} MAD',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.moroccoRed,
                          ),
                        ),
                        const Text(
                          'per day',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _createTargetedDeal(hour),
                        icon: const Icon(Icons.local_offer, size: 16),
                        label: const Text('Create Deal'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.moroccoGreen,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _optimizeTimeSlot(hour),
                        icon: const Icon(Icons.auto_fix_high, size: 16),
                        label: const Text('Optimize'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.moroccoGreen,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPricingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dynamic Pricing Overview
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.moroccoGreen, AppTheme.darkGreen],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.trending_up, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Smart Pricing Engine',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'AI-Powered Dynamic Pricing',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Automatically adjust prices based on demand, weather, events, and competitor analysis',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.white,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Pricing Recommendations
          const Text(
            'Pricing Recommendations',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildPricingRecommendation(
            'Lunch Rush (12:00-14:00)',
            '15% increase recommended',
            'High demand + nearby events',
            AppTheme.moroccoGreen,
            Icons.trending_up,
            '+180 MAD/day',
          ),

          _buildPricingRecommendation(
            'Afternoon Lull (14:00-16:00)',
            '25% discount recommended',
            'Low demand + weather favorable',
            AppTheme.moroccoGold,
            Icons.trending_down,
            '+95 MAD/day',
          ),

          _buildPricingRecommendation(
            'Evening Peak (19:00-21:00)',
            'Keep current pricing',
            'Optimal pricing detected',
            AppTheme.moroccoGreen,
            Icons.check_circle,
            'Optimized',
          ),

          const SizedBox(height: 24),

          // Competitor Pricing Analysis
          const Text(
            'Competitor Analysis',
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
                _buildCompetitorRow('Your Venue', '120 MAD', true),
                const Divider(),
                _buildCompetitorRow('Café Central', '135 MAD', false),
                _buildCompetitorRow('Restaurant Atlas', '98 MAD', false),
                _buildCompetitorRow('Le Bistrot', '150 MAD', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRecommendation(
    String timeSlot,
    String recommendation,
    String reason,
    Color color,
    IconData icon,
    String impact,
  ) {
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
                  timeSlot,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  recommendation,
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  reason,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                impact,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              ElevatedButton(
                onPressed: () => _applyPricingRecommendation(timeSlot),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(80, 32),
                ),
                child: const Text('Apply', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitorRow(String name, String price, bool isYours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (isYours)
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppTheme.moroccoGreen,
                shape: BoxShape.circle,
              ),
            )
          else
            const SizedBox(width: 6),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isYours ? FontWeight.bold : FontWeight.normal,
                color: isYours ? AppTheme.moroccoGreen : Colors.black,
              ),
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isYours ? AppTheme.moroccoGreen : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Automated Promotions
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.moroccoGold, Colors.orange],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Automated Promotions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'AI creates and launches deals automatically',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _enableAutomatedPromotions,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.moroccoGold,
                        ),
                        child: const Text('Enable Auto-Promotions'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Active Promotions
          const Text(
            'Active Promotions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildPromotionCard(
            'Happy Hour Special',
            '30% off all drinks 14:00-16:00',
            'Active until 16:00',
            '12 bookings today',
            AppTheme.moroccoGreen,
            true,
          ),

          _buildPromotionCard(
            'Rainy Day Deal',
            '25% off when weather < 18°C',
            'Weather-triggered',
            '8 bookings today',
            AppTheme.moroccoGold,
            true,
          ),

          _buildPromotionCard(
            'Late Night Bites',
            'Buy 2 get 1 free after 21:00',
            'Scheduled for tonight',
            'Ready to launch',
            Colors.grey,
            false,
          ),

          const SizedBox(height: 24),

          // Promotion Templates
          const Text(
            'Quick Promotion Templates',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildPromotionTemplate(
                '⏰',
                'Dead Hour\nSpecial',
                'Auto-discount during low occupancy',
              ),
              _buildPromotionTemplate(
                '🌧️',
                'Weather\nDeal',
                'Rain or cold weather promotion',
              ),
              _buildPromotionTemplate(
                '👥',
                'Group\nDiscount',
                'Encourage larger party bookings',
              ),
              _buildPromotionTemplate(
                '🎉',
                'Event\nBooster',
                'Capitalize on nearby events',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionCard(
    String title,
    String description,
    String status,
    String performance,
    Color color,
    bool isActive,
  ) {
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
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                value: isActive,
                onChanged: (value) => _togglePromotion(title, value),
                activeColor: AppTheme.moroccoGreen,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Text(
                performance,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionTemplate(String emoji, String title, String description) {
    return GestureDetector(
      onTap: () => _createFromTemplate(title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Insights Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[400]!, Colors.purple[600]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.psychology, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'AI Business Intelligence',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Smart insights to grow your business',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _generateNewInsights,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple[600],
                  ),
                  child: const Text('Generate New Insights'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Insights List
          _buildInsightCard(
            Icons.trending_up,
            'Revenue Growth Opportunity',
            'Your Tuesday afternoons show 40% less traffic than competitors. Consider launching a "Tuesday Treats" promotion to capture market share.',
            'High Impact',
            AppTheme.moroccoGreen,
            '+320 MAD/week potential',
          ),

          _buildInsightCard(
            Icons.people_outline,
            'Customer Pattern Discovery',
            'Families with children visit 60% more on weekends. Add kid-friendly menu items and play area promotions.',
            'Medium Impact',
            AppTheme.moroccoGold,
            '+180 MAD/week potential',
          ),

          _buildInsightCard(
            Icons.wb_sunny,
            'Weather Correlation',
            'Your sales increase 25% on sunny days above 22°C. Create weather-triggered outdoor seating promotions.',
            'Low Impact',
            Colors.blue,
            '+90 MAD/week potential',
          ),

          _buildInsightCard(
            Icons.event,
            'Event Optimization',
            'University exams period (next week) typically reduces student traffic by 35%. Offer "Study Break" deals to maintain revenue.',
            'Urgent',
            AppTheme.moroccoRed,
            'Prevent -200 MAD loss',
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
    IconData icon,
    String title,
    String description,
    String priority,
    Color color,
    String impact,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        priority,
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  impact,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => _implementInsight(title),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(80, 36),
                ),
                child: const Text('Implement'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Action Methods
  void _showOptimizationSuggestions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI Optimization Suggestions'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🎯 Targeted Deal Recommendations:'),
              SizedBox(height: 8),
              Text('• 25% off lunch combos (14:00-16:00)'),
              Text('• Buy-2-get-1 coffee deals (15:00-17:00)'),
              Text('• Happy hour pricing (20:00-22:00)'),
              SizedBox(height: 16),
              Text('📱 Marketing Boost:'),
              SizedBox(height: 8),
              Text('• Auto-post to social media during deals'),
              Text('• Send push notifications to nearby users'),
              Text('• Partner with local offices for bulk orders'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Optimization plan activated!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Activate All'),
          ),
        ],
      ),
    );
  }

  void _createTargetedDeal(Map<String, dynamic> hour) {
    // Navigate to create deal screen with pre-filled time slot
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Creating targeted deal for ${hour['time']}...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  void _optimizeTimeSlot(Map<String, dynamic> hour) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Optimize ${hour['time']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select optimization strategy:'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('Price Discount'),
              subtitle: const Text('20-30% off regular prices'),
              onTap: () => _applyOptimization('discount'),
            ),
            ListTile(
              leading: const Icon(Icons.group_add),
              title: const Text('Group Incentives'),
              subtitle: const Text('Deals for parties of 3+'),
              onTap: () => _applyOptimization('group'),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Loyalty Points'),
              subtitle: const Text('Double loyalty rewards'),
              onTap: () => _applyOptimization('loyalty'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _applyPricingRecommendation(String timeSlot) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Applied pricing recommendation for $timeSlot'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  void _enableAutomatedPromotions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable Automated Promotions'),
        content: const Text(
          'AI will automatically create and launch promotions based on:\n\n'
          '• Low occupancy periods\n'
          '• Weather conditions\n'
          '• Local events\n'
          '• Competitor pricing\n\n'
          'You can review and approve before each launch.',
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
                  content: Text('Automated promotions enabled!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Enable'),
          ),
        ],
      ),
    );
  }

  void _togglePromotion(String title, bool value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title ${value ? 'activated' : 'deactivated'}'),
        backgroundColor: value ? Colors.green : Colors.orange,
      ),
    );
  }

  void _createFromTemplate(String template) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Creating promotion from $template template...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  void _generateNewInsights() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generating new AI insights...'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _implementInsight(String insight) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Implementing: $insight'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  void _applyOptimization(String strategy) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Applied $strategy optimization strategy'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }
}