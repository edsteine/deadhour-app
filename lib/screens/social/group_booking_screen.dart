import '../dev_menu/dead_hour_app_bar.dart';
import 'services/group_booking_service.dart';
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import 'widgets/group_booking_stats_header.dart';
import 'widgets/group_booking_tab_bar.dart';
import 'widgets/group_booking_all_tab.dart';
import 'widgets/group_booking_my_tab.dart';
import 'widgets/group_booking_deals_tab.dart';
import 'widgets/group_booking_create_tab.dart';
import 'widgets/group_booking_create_dialog.dart';

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
                  onRefresh: () => setState(() {}),
                ),
                GroupBookingMyTab(
                  groupBookingService: _groupBookingService,
                  onRefresh: () => setState(() {}),
                ),
                GroupBookingDealsTab(
                  groupBookingService: _groupBookingService,
                  onRefresh: () => setState(() {}),
                ),
                const GroupBookingCreateTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "group_booking_fab",
        onPressed: () => _showCreateBookingDialog(),
        backgroundColor: AppTheme.moroccoGreen,
        label: const Text('Create Group'),
        icon: const Icon(Icons.group_add),
      ),
    );
  }

  void _showCreateBookingDialog() {
    GroupBookingCreateDialog.show(
      context,
      onCreateBooking: () {
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
      },
    );
  }
}