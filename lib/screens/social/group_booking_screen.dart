import 'package:flutter/material.dart';
import 'package:deadhour/services/group_booking_service.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/widgets/common/dead_hour_app_bar.dart';
import 'package:deadhour/screens/social/group_booking_screen/widgets/group_booking_stats_header.dart';
import 'package:deadhour/screens/social/group_booking_screen/widgets/group_booking_tab_bar.dart';
import 'package:deadhour/screens/social/group_booking_screen/widgets/group_booking_all_tab.dart';
import 'package:deadhour/screens/social/group_booking_screen/widgets/group_booking_my_tab.dart';
import 'package:deadhour/screens/social/group_booking_screen/widgets/group_booking_deal_opportunities_tab.dart';
import 'package:deadhour/screens/social/group_booking_screen/widgets/group_booking_create_tab.dart';
import 'package:deadhour/screens/social/group_booking_screen/widgets/group_booking_dialogs.dart';

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
          GroupBookingStatsHeader(stats: stats),
          GroupBookingTabBar(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GroupBookingAllTab(
                  groupBookingService: _groupBookingService,
                  onShowBookingDetails: _showBookingDetails,
                  onJoinGroup: _joinGroup,
                  onLeaveGroup: _leaveGroup,
                ),
                GroupBookingMyTab(
                  groupBookingService: _groupBookingService,
                  onShowBookingDetails: _showBookingDetails,
                  onJoinGroup: _joinGroup,
                  onLeaveGroup: _leaveGroup,
                ),
                GroupBookingDealOpportunitiesTab(
                  groupBookingService: _groupBookingService,
                  onNegotiateDeal: _negotiateDeal,
                ),
                const GroupBookingCreateTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateBookingDialog,
        backgroundColor: AppTheme.moroccoGreen,
        label: const Text('Create Group'),
        icon: const Icon(Icons.group_add),
      ),
    );
  }

  void _showCreateBookingDialog() {
    GroupBookingDialogs.showCreateBookingDialog(
      context,
      _groupBookingService,
      () => setState(() {}),
    );
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
        const SnackBar(content: Text('Failed to join group. It might be full.')),
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
    GroupBookingDialogs.showBookingDetails(context, booking);
  }

  void _negotiateDeal(Map<String, dynamic> opportunity) {
    GroupBookingDialogs.showNegotiateDealDialog(context, opportunity);
  }
}