import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../state/community_health_dashboard_state.dart';

class HealthRoomActivityTab extends StatelessWidget {
  final CommunityHealthDashboardState state;

  const HealthRoomActivityTab({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final roomData = state.getRoomActivityData();
    
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