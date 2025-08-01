
import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Cultural insights tab showing prayer time, Ramadan, and cultural event analysis
class HealthCulturalInsightsTab extends StatelessWidget {
  final CulturalCalendarService culturalService;

  const HealthCulturalInsightsTab({
    super.key,
    required this.culturalService,
  });

  @override
  Widget build(BuildContext context) {
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
    final isRamadan = culturalService.isRamadan();
    
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}