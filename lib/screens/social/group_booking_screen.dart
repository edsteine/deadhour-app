import 'package:flutter/material.dart';
import 'package:deadhour/services/group_booking_service.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/widgets/common/dead_hour_app_bar.dart';

class GroupBookingScreen extends StatefulWidget {
  const GroupBookingScreen({super.key});

  @override
  State<GroupBookingScreen> createState() => _GroupBookingScreenState();
}

class _GroupBookingScreenState extends State<GroupBookingScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final _groupBookingService = GroupBookingService();
  
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
    final stats = _groupBookingService.getGroupBookingStats();
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const DeadHourAppBar(
        title: 'Group Bookings',
        subtitle: 'Coordinate social dining and experiences',
        showBackButton: true,
      ),
      body: Column(
        children: [
          _buildStatsHeader(stats),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllBookingsTab(),
                _buildMyBookingsTab(),
                _buildDealOpportunitiesTab(),
                _buildCreateBookingTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateBookingDialog(),
        backgroundColor: AppTheme.moroccoGreen,
        label: const Text('Create Group'),
        icon: const Icon(Icons.group_add),
      ),
    );
  }

  Widget _buildStatsHeader(Map<String, dynamic> stats) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Active Groups',
                  '${stats['active_bookings']}',
                  Icons.group,
                  Colors.blue,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'Avg Size',
                  stats['average_group_size'],
                  Icons.people,
                  Colors.green,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'Deal Success',
                  '${stats['deal_success_rate']}%',
                  Icons.local_offer,
                  Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.savings, color: AppTheme.moroccoGreen, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Total Community Savings: ${stats['total_savings'].toStringAsFixed(0)} MAD',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return ColoredBox(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppTheme.moroccoGreen,
        unselectedLabelColor: AppTheme.secondaryText,
        indicatorColor: AppTheme.moroccoGreen,
        tabs: const [
          Tab(text: 'All Groups'),
          Tab(text: 'My Groups'),
          Tab(text: 'Deal Ops'),
          Tab(text: 'Create'),
        ],
      ),
    );
  }

  Widget _buildAllBookingsTab() {
    final allBookings = _groupBookingService.getAllGroupBookings();
    
    if (allBookings.isEmpty) {
      return _buildEmptyState('No group bookings yet', 'Be the first to create a group booking!');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: allBookings.length,
      itemBuilder: (context, index) {
        final booking = allBookings[index];
        return _buildGroupBookingCard(booking);
      },
    );
  }

  Widget _buildMyBookingsTab() {
    final userBookings = _groupBookingService.getUserGroupBookings('user_current');
    
    if (userBookings.isEmpty) {
      return _buildEmptyState('No bookings yet', 'Join a group or create your own!');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: userBookings.length,
      itemBuilder: (context, index) {
        final booking = userBookings[index];
        return _buildGroupBookingCard(booking, isUserBooking: true);
      },
    );
  }

  Widget _buildDealOpportunitiesTab() {
    final opportunities = _groupBookingService.getGroupDealOpportunities();
    
    if (opportunities.isEmpty) {
      return _buildEmptyState('No deal opportunities', 'Create larger groups to unlock group discounts!');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: opportunities.length,
      itemBuilder: (context, index) {
        final opportunity = opportunities[index];
        return _buildDealOpportunityCard(opportunity);
      },
    );
  }

  Widget _buildCreateBookingTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.group_add, size: 64, color: AppTheme.moroccoGreen),
          SizedBox(height: 16),
          Text(
            'Create Group Booking',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Use the + button to create a new group booking',
            style: TextStyle(color: AppTheme.secondaryText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGroupBookingCard(Map<String, dynamic> booking, {bool isUserBooking = false}) {
    final participants = booking['currentParticipants'] as List<String>;
    final waitlist = booking['waitlist'] as List<String>;
    final maxParticipants = booking['maxParticipants'] as int;
    final dateTime = booking['dateTime'] as DateTime;
    final status = booking['status'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: InkWell(
          onTap: () => _showBookingDetails(booking),
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
                          onPressed: () => _joinGroup(booking['id']),
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
                          onPressed: () => _leaveGroup(booking['id']),
                          child: const Text('Leave Group'),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showBookingDetails(booking),
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

  Widget _buildDealOpportunityCard(Map<String, dynamic> opportunity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
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
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.local_offer, color: Colors.orange.shade700, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opportunity['venueName'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Group Deal Opportunity',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.people, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    '${opportunity['participantCount']}/${opportunity['maxParticipants']} people',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.savings, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    '${opportunity['requestedDiscount']}% off',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, size: 16, color: Colors.green.shade700),
                    const SizedBox(width: 6),
                    Text(
                      'Potential savings: ${opportunity['potential_savings'].toStringAsFixed(0)} MAD',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => _negotiateDeal(opportunity),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Negotiate Deal'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.group_off, size: 64, color: AppTheme.lightText),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: AppTheme.lightText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showCreateBookingDialog() {
    // Mock implementation - would show full form
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Group Booking'),
        content: const Text('Group booking creation form would go here with venue selection, date/time, requirements, etc.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _createMockBooking();
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _createMockBooking() {
    _groupBookingService.createGroupBooking(
      venueId: 'venue_1',
      venueName: 'Café Central',
      organizerId: 'user_current',
      organizerName: 'Current User',
      title: 'Study Session',
      description: 'Group study for exams',
      dateTime: DateTime.now().add(const Duration(days: 1)),
      duration: 120,
      maxParticipants: 6,
      requestDeal: true,
      requestedDiscount: 15.0,
      requirements: ['wifi', 'quiet'],
    );
    
    setState(() {}); // Refresh the screen
  }

  void _joinGroup(String bookingId) {
    final result = _groupBookingService.joinGroupBooking(bookingId, 'user_current');
    setState(() {});
    
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully joined the group!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to waitlist')),
      );
    }
  }

  void _leaveGroup(String bookingId) {
    _groupBookingService.leaveGroupBooking(bookingId, 'user_current');
    setState(() {});
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Left the group')),
    );
  }

  void _showBookingDetails(Map<String, dynamic> booking) {
    // Mock implementation - would show detailed view
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking['title'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(booking['description']),
              const SizedBox(height: 16),
              Text('Venue: ${booking['venueName']}'),
              Text('Organizer: ${booking['organizer']}'),
              Text('Time: ${_formatDateTime(booking['dateTime'])}'),
              Text('Participants: ${(booking['currentParticipants'] as List).length}/${booking['maxParticipants']}'),
              if ((booking['waitlist'] as List).isNotEmpty)
                Text('Waitlist: ${(booking['waitlist'] as List).length}'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _negotiateDeal(Map<String, dynamic> opportunity) {
    // Mock implementation - would show negotiation interface
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Negotiate Group Deal'),
        content: Text('Deal negotiation for ${opportunity['venueName']} would be handled here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Send Request'),
          ),
        ],
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