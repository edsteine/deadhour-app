import 'professional_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/theme.dart';

class OverviewTab extends StatelessWidget {
  final VoidCallback handleActivityTap;
  final VoidCallback createNewDeal;
  final TabController tabController;

  const OverviewTab({
    super.key,
    required this.handleActivityTap,
    required this.createNewDeal,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick stats
          _buildQuickStats(),
          const SizedBox(height: AppTheme.spacing24),

          // Recent activity
          _buildSectionHeader('Recent Activity'),
          const SizedBox(height: AppTheme.spacing12),
          _buildRecentActivity(),
          const SizedBox(height: AppTheme.spacing24),

          // Performance insights
          _buildSectionHeader('Performance Insights'),
          const SizedBox(height: AppTheme.spacing12),
          _buildPerformanceInsights(),
          const SizedBox(height: AppTheme.spacing24),

          // Quick actions
          _buildSectionHeader('Quick Actions'),
          const SizedBox(height: AppTheme.spacing12),
          _buildQuickActions(context),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return const Row(
      children: [
        Expanded(
          child: ProfessionalStatsCard(
            title: 'Today\'s Revenue',
            value: '2,450 MAD',
            subtitle: '+12% vs yesterday',
            icon: Icons.attach_money,
            iconColor: AppTheme.moroccoGreen,
            valueColor: AppTheme.moroccoGreen,
          ),
        ),
        SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: ProfessionalStatsCard(
            title: 'Bookings',
            value: '23',
            subtitle: '+8% increase',
            icon: Icons.book_online,
            iconColor: AppTheme.moroccoGold,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      children: [
        ProfessionalActionCard(
          title: 'New booking for lunch deal',
          description: '2 people • 12:30 PM',
          icon: Icons.book_online,
          iconColor: AppColors.success,
          actionText: '5 min ago',
          onTap: () => handleActivityTap(),
        ),
        ProfessionalActionCard(
          title: 'New 5-star review',
          description: '"Amazing food and great service!"',
          icon: Icons.star,
          iconColor: AppColors.warning,
          actionText: '1 hour ago',
          onTap: () => handleActivityTap(),
        ),
        ProfessionalActionCard(
          title: 'Deal performance alert',
          description: 'Afternoon coffee deal is trending',
          icon: Icons.local_fire_department,
          iconColor: AppColors.error,
          actionText: '2 hours ago',
          onTap: () => handleActivityTap(),
        ),
      ],
    );
  }

  Widget _buildPerformanceInsights() {
    return ProfessionalCard(
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
              SizedBox(width: AppTheme.spacing8),
              Text(
                'Key Insights',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          _buildInsightItem(
            '🔥',
            'Peak Hours',
            'Your busiest time is 2-4 PM with 85% booking rate',
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildInsightItem(
            '💰',
            'Best Performing Deal',
            'Afternoon coffee deal generates 40% more revenue',
          ),
          const SizedBox(height: AppTheme.spacing12),
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
        const SizedBox(width: AppTheme.spacing12),
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

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.auto_fix_high,
                label: 'Revenue Optimizer',
                onTap: () => context.go('/business/optimization'),
                color: AppTheme.moroccoGreen,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: _buildActionButton(
                icon: Icons.add,
                label: 'Create Deal',
                onTap: createNewDeal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.analytics,
                label: 'Advanced Analytics',
                onTap: () => context.go('/business/analytics'),
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: _buildActionButton(
                icon: Icons.settings,
                label: 'Settings',
                onTap: () => tabController.animateTo(3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
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
            Icon(icon, color: color ?? AppTheme.moroccoGreen, size: 24),
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
