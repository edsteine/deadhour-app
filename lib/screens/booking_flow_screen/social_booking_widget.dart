import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

class SocialBookingWidget extends StatelessWidget {
  final bool inviteFriends;
  final int groupSize;
  final List<String> invitedFriends;
  final ValueChanged<bool> onInviteFriendsChanged;
  final ValueChanged<int> onGroupSizeChanged;
  final Function(String, bool) onFriendToggle;

  const SocialBookingWidget({
    super.key,
    required this.inviteFriends,
    required this.groupSize,
    required this.invitedFriends,
    required this.onInviteFriendsChanged,
    required this.onGroupSizeChanged,
    required this.onFriendToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '👥 Social Booking:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        
        // Invite friends option
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Switch(
                    value: inviteFriends,
                    onChanged: onInviteFriendsChanged,
                    activeColor: AppTheme.moroccoGreen,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Invite friends from community',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              
              if (inviteFriends) ...[
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                
                // Group size selector
                Row(
                  children: [
                    const Text('Group size: '),
                    const SizedBox(width: 8),
                    DropdownButton<int>(
                      value: groupSize,
                      items: List.generate(8, (index) => index + 1)
                          .map((size) => DropdownMenuItem(
                                value: size,
                                child: Text('$size ${size == 1 ? 'person' : 'people'}'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          onGroupSizeChanged(value);
                        }
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Friend invitation interface
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.moroccoGreen.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Community members:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildFriendChip('Ahmed_Casa', false),
                          _buildFriendChip('Sarah_Guide', false),
                          _buildFriendChip('LocalFoodie', invitedFriends.contains('LocalFoodie')),
                          _buildFriendChip('Student_Rbat', false),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (invitedFriends.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: Text(
                            'Invited: ${invitedFriends.join(', ')}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Group booking benefits
                if (groupSize >= 4)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.celebration, 
                             color: Colors.orange.shade700, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${groupSize >= 6 ? '15%' : '10%'} group discount applied!',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.orange.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFriendChip(String name, bool isInvited) {
    return FilterChip(
      label: Text(name),
      selected: isInvited,
      onSelected: (selected) => onFriendToggle(name, selected),
      selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
      checkmarkColor: AppTheme.moroccoGreen,
    );
  }
}