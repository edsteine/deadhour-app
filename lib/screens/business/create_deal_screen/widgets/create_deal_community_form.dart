import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class CreateDealCommunityForm extends StatelessWidget {
  final TextEditingController communityMessageController;
  final bool notifyCommunity;
  final ValueChanged<bool> onNotifyCommunityChanged;

  const CreateDealCommunityForm({
    super.key,
    required this.communityMessageController,
    required this.notifyCommunity,
    required this.onNotifyCommunityChanged,
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
            hintText: 'Tell the community why this deal is special...',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 16),

        SwitchListTile(
          title: const Text('📱 Notify Community'),
          subtitle: const Text('Send push notification to relevant rooms'),
          value: notifyCommunity,
          onChanged: onNotifyCommunityChanged,
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