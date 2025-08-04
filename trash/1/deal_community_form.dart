import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

/// Community message form with notification settings
class DealCommunityForm extends StatelessWidget {
  final TextEditingController communityMessageController;
  final bool notifyCommunity;
  final Function(bool) onNotifyChanged;

  const DealCommunityForm({
    super.key,
    required this.communityMessageController,
    required this.notifyCommunity,
    required this.onNotifyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('💬 Community Message'),
        const SizedBox(height: 12),
        TextFormField(
          controller: communityMessageController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText:
                'Tell the community why this deal is special...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('📱 Notify Community'),
          subtitle: const Text(
              'Send push notification to relevant rooms'),
          value: notifyCommunity,
          onChanged: onNotifyChanged,
          activeColor: AppTheme.moroccoGreen,
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
        color: AppTheme.moroccoGreen,
      ),
    );
  }
}