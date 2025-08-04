import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

/// User engagement tab showing top contributors and engagement trends
class HealthUserEngagementTab extends StatelessWidget {
  const HealthUserEngagementTab({super.key});

  @override
  Widget build(BuildContext context) {
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