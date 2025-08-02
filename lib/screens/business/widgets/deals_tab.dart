import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/utils/mock_data.dart';

class DealsTab extends StatelessWidget {
  final VoidCallback editDeal;
  final VoidCallback viewDealAnalytics;

  const DealsTab({
    super.key,
    required this.editDeal,
    required this.viewDealAnalytics,
  });

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(width: AppTheme.spacing12),
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
          const SizedBox(height: AppTheme.spacing24),

          // Active deals list
          _buildSectionHeader('Active Deals'),
          const SizedBox(height: AppTheme.spacing12),
          ...activeDeals.map((deal) => _buildDealCard(deal)),
        ],
      ),
    );
  }

  Widget _buildDealStatCard(
      String title, String value, IconData icon, Color color) {
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
          const SizedBox(height: AppTheme.spacing12),
          Row(
            children: [
              _buildDealMetric('Bookings', '${deal.currentBookings}'),
              const SizedBox(width: 16),
              _buildDealMetric('Revenue',
                  '${(deal.discountedPrice * deal.currentBookings).toInt()} MAD'),
              const SizedBox(width: 16),
              _buildDealMetric('Spots Left', '${deal.availableSpots}'),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => editDeal(),
                  child: const Text('Edit'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => viewDealAnalytics(),
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
