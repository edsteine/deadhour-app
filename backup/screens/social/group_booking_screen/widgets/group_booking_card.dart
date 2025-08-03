import 'package:flutter/material.dart';
import '../../../../utils/theme.dart';

class GroupBookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  final bool isUserBooking;
  final VoidCallback onTap;
  final VoidCallback onJoinGroup;
  final VoidCallback onLeaveGroup;

  const GroupBookingCard({
    super.key,
    required this.booking,
    this.isUserBooking = false,
    required this.onTap,
    required this.onJoinGroup,
    required this.onLeaveGroup,
  });

  @override
  Widget build(BuildContext context) {
    final participants = booking['currentParticipants'] as List<String>;
    final waitlist = booking['waitlist'] as List<String>;
    final maxParticipants = booking['maxParticipants'] as int;
    final dateTime = booking['dateTime'] as DateTime;
    final status = booking['status'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getStatusIcon(status),
                        color: _getStatusColor(status),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${booking['venueName']} • ${booking['organizer']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(status),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  booking['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondaryText,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      _formatDateTime(dateTime),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.people, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      '${participants.length}/$maxParticipants',
                      style: const TextStyle(fontSize: 12),
                    ),
                    if (waitlist.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${waitlist.length} waiting',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.orange.shade700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (booking['dealRequested'] == true) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.local_offer, size: 16, color: Colors.green.shade700),
                        const SizedBox(width: 6),
                        Text(
                          '${booking['groupDiscount']}% group discount ${_getDealStatus(booking)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (status == 'open' && !participants.contains('user_current'))
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onJoinGroup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.moroccoGreen,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(participants.length < maxParticipants ? 'Join Group' : 'Join Waitlist'),
                        ),
                      ),
                    if (participants.contains('user_current')) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onLeaveGroup,
                          child: const Text('Leave Group'),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onTap,
                        icon: const Icon(Icons.info, size: 16),
                        label: const Text('Details'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'open':
        return Colors.blue;
      case 'confirmed':
        return Colors.green;
      case 'full':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return AppTheme.moroccoGreen;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'open':
        return Icons.group_add;
      case 'confirmed':
        return Icons.check_circle;
      case 'full':
        return Icons.people;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.group;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _getDealStatus(Map<String, dynamic> booking) {
    final venueResponse = booking['venue_response'] as Map<String, dynamic>;
    final status = venueResponse['status'];
    
    switch (status) {
      case 'approved':
        return 'approved';
      case 'pending':
        return 'requested';
      case 'rejected':
        return 'declined';
      default:
        return 'requested';
    }
  }
}